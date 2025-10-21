package
{
   import Shared.AS3.BGSExternalInterface;
   import Shared.AS3.BSScrollingList;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.IMenu;
   import Shared.AS3.StyleSheet;
   import Shared.AS3.Styles.MessageBoxButtonListStyle;
   import Shared.GlobalFunc;
   import Shared.ResolutionDarkeners;
   import com.adobe.serialization.json.*;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.*;
   import flash.filters.*;
   import flash.net.*;
   import flash.text.*;
   import flash.utils.*;
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol97")]
   public class MessageBoxMenu extends IMenu
   {
      
      public static const SPACING_Y_PAD:Number = 9;
      
      public static const BODY_SIZE_PAD:Number = 25;
      
      public static var TAG_SCRAPTOSTASH:String = "ScrapToStash";
      
      public var Body_mc:MovieClip;
      
      public var Tooltip_mc:MovieClip;
      
      public var List_mc:MessageBoxButtonList;
      
      public var BodyScrollUp_mc:MovieClip;
      
      public var BodyScrollDown_mc:MovieClip;
      
      private var TooltipList_mc:BSScrollingList;
      
      private var Tooltip_tf:TextField;
      
      public var backgroundBoxHeader:MovieClip;
      
      public var backgroundBoxContainer_mc:MovieClip;
      
      public var backgroundBoxStroke:MovieClip;
      
      public var BGSCodeObj:Object;
      
      private var DisableInputCounter:uint;
      
      private var MenuMode:Boolean = false;
      
      private var m_Tag:String = "";
      
      private var m_ButtonHintsArray:Array;
      
      private var m_ActivationListArray:Array;
      
      private var initTime:int;
      
      private var debug_tf:TextField;
      
      private var config:Object = {"debug":true};
      
      private var headerText:String;
      
      public function MessageBoxMenu()
      {
         super();
         this.BGSCodeObj = new Object();
         this.m_ButtonHintsArray = new Array();
         this.m_ActivationListArray = new Array();
         this.Tooltip_tf = this.Tooltip_mc.Tooltip_tf;
         this.TooltipList_mc = this.Tooltip_mc.TooltipList_mc;
         Shared.AS3.StyleSheet.apply(this.List_mc,false,MessageBoxButtonListStyle);
         this.Body_mc.Body_tf.autoSize = TextFieldAutoSize.CENTER;
         BSUIDataManager.Subscribe("ScreenResolutionData",this.onScreenResolutionData);
         addEventListener(Event.ENTER_FRAME,this.initDisableInputCounter);
         this.List_mc.addEventListener(BSScrollingList.ITEM_PRESS,this.onItemPress);
         this.List_mc.addEventListener(BSScrollingList.PLAY_FOCUS_SOUND,this.playFocusSound);
         this.Tooltip_mc.Tooltip_tf.addEventListener(MouseEvent.MOUSE_WHEEL,this.onTooltipMouseWheel);
         this.visible = false;
         this.List_mc.disableInput_Inspectable = true;
         this.DisableInputCounter = 0;
         this.Tooltip_tf.scrollV = 0;
         this.loadConfig();
      }
      
      private function loadConfig() : void
      {
         var loader:URLLoader = null;
         try
         {
            this.initTime = getTimer();
            loader = new URLLoader();
            loader.load(new URLRequest("../SkipMessagesConfig.json"));
            loader.addEventListener(Event.COMPLETE,this.onConfigLoaded);
            loader.addEventListener(IOErrorEvent.IO_ERROR,this.onConfigLoadError);
         }
         catch(e:*)
         {
            this.log("Error loading config " + e);
         }
      }
      
      private function log(str:String) : void
      {
         if(!this.config || !this.config.debug)
         {
            return;
         }
         if(this.debug_tf == null)
         {
            this.debug_tf = new TextField();
            var tff:TextFormat = new TextFormat("$MAIN_Font",16,16777215);
            this.debug_tf.defaultTextFormat = tff;
            this.debug_tf.setTextFormat(tff);
            this.debug_tf.width = 400;
            this.debug_tf.height = 200;
            this.debug_tf.y = 100;
            this.debug_tf.wordWrap = true;
            this.debug_tf.multiline = true;
            this.debug_tf.selectable = false;
            this.debug_tf.mouseEnabled = false;
            addChild(this.debug_tf);
         }
         if(this.config.dt)
         {
            this.debug_tf.text += "\n[" + getTimer() + "] " + str;
         }
         else
         {
            this.debug_tf.text += "\n" + str;
         }
      }
      
      private function onConfigLoadError(param1:Event) : void
      {
         this.log("Config error: " + param1);
      }
      
      private function onConfigLoaded(param1:Event) : void
      {
         var configLoadTime:int;
         try
         {
            this.config = new JSONDecoder(param1.target.data,true).getValue();
            this.config.SkipDelay = this.config.SkipDelay == null || isNaN(this.config.SkipDelay) ? 25 : int(this.config.SkipDelay);
            configLoadTime = getTimer() - this.initTime;
            this.log("Config loaded (" + configLoadTime + "ms)");
            if(this.config.SkipDelay > configLoadTime)
            {
               configLoadTime = this.config.SkipDelay - configLoadTime;
               setTimeout(Process,configLoadTime);
            }
            else
            {
               Process();
            }
         }
         catch(e:*)
         {
            this.log("Error parsing config " + e);
         }
      }
      
      private function Process() : void
      {
         var dummy:TextField = new TextField();
         if(this.headerText == "$RepairKitChoose")
         {
            if(this.config.AutoUseRepairKit)
            {
               GlobalFunc.SetText(dummy,"$RepairKitOption");
               var NoKitsRegex:RegExp = new RegExp(dummy.text.replace("{1}",".*").replace("{2}","0").replace("(","\\(").replace(")","\\)"));
               var i:int = buttonArray.length - 2;
               while(i >= 0)
               {
                  if(!NoKitsRegex.test(buttonArray[i].text))
                  {
                     this.log("Repair Kit: " + (i == 0 ? "Basic" : "Improved"));
                     if(!this.config.testRun)
                     {
                        BGSExternalInterface.call(BGSCodeObj,"onButtonPress",buttonArray[i].buttonIndex);
                     }
                     return;
                  }
                  i--;
               }
               this.log("Repair Kit: Cancel");
               if(!this.config.testRun)
               {
                  BGSExternalInterface.call(BGSCodeObj,"onButtonPress",buttonArray[buttonArray.length - 1].buttonIndex);
               }
               return;
            }
         }
         else if(this.headerText == "$ConfirmLegendaryItemHeader")
         {
            if(this.config.ScrapLegendary)
            {
               this.log("Legendary Item");
               if(!this.config.testRun)
               {
                  BGSExternalInterface.call(BGSCodeObj,"onButtonPress",1);
               }
               return;
            }
         }
         else if(this.headerText == "$ConfirmPremiumItemHeader")
         {
            if(this.config.ScrapPremium)
            {
               this.log("Premium Item");
               if(!this.config.testRun)
               {
                  BGSExternalInterface.call(BGSCodeObj,"onButtonPress",1);
               }
               return;
            }
         }
         if(this.config.SkipCustom)
         {
            for(o in this.config.SkipCustom)
            {
               GlobalFunc.SetText(dummy,o);
               if(this.bodyText == dummy.text)
               {
                  var buttonId:int = int(this.config.SkipCustom[o]);
                  this.log("Found in config:");
                  this.log("\"" + o + "\"");
                  this.log("Activate button " + buttonId + " : " + (buttonArray.length > buttonId ? buttonArray[buttonId].text : "null"));
                  if(!this.config.testRun)
                  {
                     BGSExternalInterface.call(BGSCodeObj,"onButtonPress",buttonId);
                  }
                  return;
               }
            }
         }
         if(this.config.SkipCustomRegex)
         {
            for(o in this.config.SkipCustomRegex)
            {
               var regex:RegExp = new RegExp(o);
               if(regex.test(this.bodyText))
               {
                  buttonId = int(this.config.SkipCustomRegex[o]);
                  this.log("Found regex in config:");
                  this.log("\"" + o + "\"");
                  this.log("Activate button " + buttonId + " : " + (buttonArray.length > buttonId ? buttonArray[buttonId].text : "null"));
                  if(!this.config.testRun)
                  {
                     BGSExternalInterface.call(BGSCodeObj,"onButtonPress",int(buttonId));
                  }
                  return;
               }
            }
         }
         if(this.config.debug)
         {
            this.log("Not found in config:");
            this.log("\"" + this.headerText + "\"");
            this.log("Buttons:");
            i = 0;
            while(i < buttonArray.length)
            {
               this.log(buttonArray[i].buttonIndex + " : " + buttonArray[i].text);
               i++;
            }
         }
      }
      
      private function onScreenResolutionData(param1:FromClientDataEvent) : void
      {
         var _loc2_:Shape = null;
         if(param1.data)
         {
            _loc2_ = ResolutionDarkeners.CreateDarkener(param1.data.ScreenWidth,param1.data.ScreenHeight,ResolutionDarkeners.DARKENER_TYPE_SOLID);
            this.parent.addChildAt(_loc2_,0);
            ResolutionDarkeners.PositionDarkener(_loc2_);
         }
      }
      
      public function get bodyText() : String
      {
         return this.Body_mc.Body_tf.text;
      }
      
      public function set bodyText(param1:String) : *
      {
         var _loc2_:* = param1.indexOf("<font") > -1;
         TextFieldEx.setNoTranslate(this.Body_mc.Body_tf,_loc2_);
         GlobalFunc.SetText(this.Body_mc.Body_tf,param1,true);
         this.headerText = param1;
      }
      
      public function get tooltipText() : String
      {
         return this.Tooltip_tf.text;
      }
      
      public function set tooltipText(param1:String) : *
      {
         GlobalFunc.SetText(this.Tooltip_tf,param1,true);
      }
      
      public function get buttonHintsArray() : Array
      {
         return this.m_ButtonHintsArray;
      }
      
      public function set buttonHintsArray(param1:Array) : void
      {
         this.m_ButtonHintsArray = param1;
      }
      
      public function get activationListArray() : Array
      {
         return this.m_ActivationListArray;
      }
      
      public function set activationListArray(param1:Array) : void
      {
         this.m_ActivationListArray = param1;
      }
      
      public function get isValidTextScrollMode() : Boolean
      {
         return this.m_Tag == TAG_SCRAPTOSTASH;
      }
      
      public function updateMessageScrollIndicators() : void
      {
         var _loc1_:Boolean = false;
         _loc1_ = this.isValidTextScrollMode;
         this.BodyScrollUp_mc.visible = _loc1_ && this.Tooltip_tf.scrollV > 1;
         this.BodyScrollDown_mc.visible = _loc1_ && this.Tooltip_tf.bottomScrollV < this.Tooltip_tf.numLines;
      }
      
      public function set tag(param1:String) : void
      {
         this.m_Tag = param1;
         this.updateMessageScrollIndicators();
      }
      
      public function onRightThumbstickInput(param1:uint) : *
      {
         if(this.isValidTextScrollMode)
         {
            if(param1 == 1)
            {
               --this.Tooltip_tf.scrollV;
            }
            else if(param1 == 3)
            {
               ++this.Tooltip_tf.scrollV;
            }
            this.updateMessageScrollIndicators();
         }
      }
      
      private function onTooltipMouseWheel(param1:MouseEvent) : *
      {
         if(this.isValidTextScrollMode && this.Tooltip_tf.hitTestPoint(stage.mouseX,stage.mouseY))
         {
            if(param1.delta < 0)
            {
               ++this.Tooltip_tf.scrollV;
            }
            else if(param1.delta > 0)
            {
               --this.Tooltip_tf.scrollV;
            }
            this.updateMessageScrollIndicators();
         }
      }
      
      public function get buttonArray() : Array
      {
         return this.List_mc.entryList;
      }
      
      public function set buttonArray(param1:Array) : *
      {
         this.List_mc.entryList = param1;
      }
      
      public function get selectedIndex() : uint
      {
         return this.List_mc.selectedIndex;
      }
      
      public function set menuMode(param1:Boolean) : *
      {
         this.MenuMode = param1;
      }
      
      public function ForceInit() : *
      {
         if(this.List_mc.numListItems_Inspectable == 0)
         {
            this.List_mc.listEntryClass_Inspectable = "MessageBoxButtonEntry";
            this.List_mc.numListItems_Inspectable = 4;
            this.List_mc.onComponentInit(null);
         }
      }
      
      public function InvalidateMenu() : *
      {
         this.List_mc.InvalidateData();
         this.List_mc.selectedIndex = 0;
         var _loc1_:Number = this.backgroundBoxContainer_mc.width;
         var _loc2_:Number = BODY_SIZE_PAD * 0.4;
         this.Body_mc.y = _loc2_;
         this.Body_mc.x = _loc1_ / 2;
         this.List_mc.x = _loc1_ / 2;
         var _loc3_:Number = 0;
         _loc3_ = Number(this.Body_mc.Body_tf.textHeight);
         _loc2_ += _loc3_ + SPACING_Y_PAD;
         this.backgroundBoxHeader.height = _loc2_;
         switch(this.m_Tag)
         {
            case "BUTTONHINTS":
               this.Tooltip_mc.gotoAndStop("List");
               this.TooltipList_mc.visible = this.m_ButtonHintsArray.length > 0;
               ButtonTooltipListEntry.platform = uiPlatform;
               if(this.TooltipList_mc.visible)
               {
                  this.TooltipList_mc.listEntryClass_Inspectable = "ButtonTooltipListEntry";
                  this.TooltipList_mc.numListItems_Inspectable = 4;
                  this.TooltipList_mc.SetNumListItems(4);
                  this.TooltipList_mc.entryList = this.m_ButtonHintsArray;
                  this.TooltipList_mc.InvalidateData();
                  this.Tooltip_mc.y = _loc2_;
                  _loc2_ += this.TooltipList_mc.shownItemsHeight;
               }
               break;
            case "ACTIVATIONLIST":
               this.Tooltip_mc.gotoAndStop("List");
               this.TooltipList_mc.visible = this.m_ActivationListArray.length > 0;
               if(this.TooltipList_mc.visible)
               {
                  this.TooltipList_mc.listEntryClass_Inspectable = "ActivationTooltipListEntry";
                  this.TooltipList_mc.numListItems_Inspectable = 3;
                  this.TooltipList_mc.SetNumListItems(3);
                  this.TooltipList_mc.entryList = this.m_ActivationListArray;
                  this.TooltipList_mc.InvalidateData();
                  this.Tooltip_mc.y = _loc2_;
                  _loc2_ += this.TooltipList_mc.shownItemsHeight;
               }
               break;
            default:
               this.Tooltip_mc.gotoAndStop("Text");
               this.Tooltip_tf.visible = this.Tooltip_tf.length > 0;
               if(this.Tooltip_tf.visible)
               {
                  this.Tooltip_mc.y = _loc2_;
                  if(this.isValidTextScrollMode)
                  {
                     _loc2_ += Math.min(GlobalFunc.getTextfieldSize(this.Tooltip_tf),this.Tooltip_tf.height) + SPACING_Y_PAD;
                  }
                  else
                  {
                     _loc2_ += GlobalFunc.getTextfieldSize(this.Tooltip_tf) + SPACING_Y_PAD;
                  }
               }
         }
         _loc2_ += SPACING_Y_PAD * 4;
         this.List_mc.y = _loc2_;
         _loc2_ += this.List_mc.shownItemsHeight + BODY_SIZE_PAD * 0.4;
         this.List_mc.ScrollUp.x = this.List_mc.greatestWidth * -0.5 - 20;
         this.List_mc.ScrollDown.x = this.List_mc.ScrollUp.x;
         var _loc4_:Array = [this.backgroundBoxContainer_mc,this.backgroundBoxStroke];
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc4_[_loc5_].height = _loc2_;
            _loc4_[_loc5_].width = _loc1_;
            _loc5_++;
         }
         this.backgroundBoxHeader.width = _loc1_;
         stage.stageFocusRect = false;
         stage.focus = this.List_mc;
         this.x = (this.loaderInfo.width - _loc1_) / 2;
         this.y = (this.loaderInfo.height - _loc2_) / 2;
         this.visible = true;
      }
      
      private function initDisableInputCounter(param1:Event) : *
      {
         ++this.DisableInputCounter;
         if(this.DisableInputCounter > 3)
         {
            removeEventListener(Event.ENTER_FRAME,this.initDisableInputCounter);
            this.List_mc.disableInput_Inspectable = false;
         }
      }
      
      private function onItemPress(param1:Event) : *
      {
         if(this.List_mc.selectedEntry.buttonIndex != undefined)
         {
            BGSExternalInterface.call(this.BGSCodeObj,"onButtonPress",this.List_mc.selectedEntry.buttonIndex);
         }
      }
      
      private function playFocusSound() : *
      {
         if(this.BGSCodeObj.PlayFocusSound != undefined)
         {
            BGSExternalInterface.call(this.BGSCodeObj,"PlayFocusSound");
         }
      }
      
      public function ProcessUserEvent(param1:String, param2:Boolean) : Boolean
      {
         if(!param2)
         {
            switch(param1)
            {
               case "Cancel":
                  BGSExternalInterface.call(this.BGSCodeObj,"onBackButton");
            }
         }
         return true;
      }
   }
}

