package
{
   import Shared.AS3.BSButtonHintBar;
   import Shared.AS3.BSButtonHintData;
   import Shared.GlobalFunc;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.*;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol22")]
   public class ConfirmPanel extends MovieClip
   {
       
      
      public var ButtonHintBar_mc:BSButtonHintBar;
      
      public var BGRect_mc:MovieClip;
      
      public var ConfirmQuestion_mc:MovieClip;
      
      public var ConfirmSubtitle_mc:MovieClip;
      
      public var ScrollUp_mc:MovieClip;
      
      public var ScrollDown_mc:MovieClip;
      
      private var ButtonHints:Vector.<BSButtonHintData>;
      
      private var AcceptButton:BSButtonHintData;
      
      private var AltButton:BSButtonHintData;
      
      private var AltButton2:BSButtonHintData;
      
      private var CancelButton:BSButtonHintData;
      
      private var TopComponentSource:* = 0;
      
      private var TopComponent:* = 0;
      
      private const YBufferAfterQuestionC:Number = 20;
      
      private const YBufferBetweenEntriesC:Number = 5;
      
      private const YBufferBeforeButtonsC:Number = 20;
      
      private const YBufferAfterButtonsC:Number = 20;
      
      private const MaxHeightC:Number = 1080;
      
      private const MinWidthC:Number = 400;
      
      private const WidthPaddingC:Number = 32;
      
      private var m_ConfirmQuestionFullHeight:* = 30;
      
      private var m_Entries:Vector.<ConfirmPanelComponentSourceEntry>;
      
      protected var BGSCodeObj:Object;
      
      public function ConfirmPanel()
      {
         this.AcceptButton = new BSButtonHintData("$CONFIRM","Space","PSN_A","Xenon_A",1,this.onAcceptButton);
         this.AltButton = new BSButtonHintData("","R","PSN_X","Xenon_X",1,this.onAltButton);
         this.AltButton2 = new BSButtonHintData("","T","PSN_Y","Xenon_Y",1,this.onAltButton2);
         this.CancelButton = new BSButtonHintData("$CANCEL","Tab","PSN_B","Xenon_B",1,this.onCancelButton);
         super();
         this.ButtonHints = new Vector.<BSButtonHintData>();
         this.ButtonHints.push(this.AcceptButton);
         this.ButtonHints.push(this.AltButton);
         this.ButtonHints.push(this.AltButton2);
         this.ButtonHints.push(this.CancelButton);
         this.ButtonHintBar_mc.SetButtonHintData(this.ButtonHints);
         this.AltButton.ButtonVisible = false;
         this.AltButton2.ButtonVisible = false;
         this.ConfirmSubtitle_mc.visible = false;
         this.m_Entries = new Vector.<ConfirmPanelComponentSourceEntry>();
         this.ButtonHintBar_mc.useVaultTecColor = true;
         Extensions.enabled = true;
         TextFieldEx.setTextAutoSize(this.ConfirmQuestion_mc.ConfirmQuestion_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel,false,0,true);
         this.ScrollUp_mc.addEventListener(MouseEvent.CLICK,this.onUpArrowClick,false,0,true);
         this.ScrollDown_mc.addEventListener(MouseEvent.CLICK,this.onDownArrowClick,false,0,true);
      }
      
      public function Clear() : *
      {
         var _loc2_:DisplayObject = null;
         this.m_Entries.splice(0,this.m_Entries.length);
         var _loc1_:* = 0;
         while(_loc1_ < numChildren)
         {
            _loc2_ = getChildAt(_loc1_);
            if(_loc2_ is ConfirmPanelComponentSourceEntry)
            {
               removeChildAt(_loc1_--);
            }
            _loc1_++;
         }
      }
      
      public function InitCodeObj(param1:Object) : *
      {
         this.BGSCodeObj = param1;
      }
      
      public function ReleaseCodeObj() : *
      {
         this.BGSCodeObj = null;
      }
      
      public function set confirmQuestion(param1:String) : *
      {
         GlobalFunc.SetText(this.ConfirmQuestion_mc.ConfirmQuestion_tf,param1,false);
      }
      
      public function set confirmSubtitle(param1:String) : *
      {
         if(param1.length > 0)
         {
            GlobalFunc.SetText(this.ConfirmSubtitle_mc.ConfirmSubtitle_tf,param1,false);
            this.ConfirmSubtitle_mc.visible = true;
         }
         else
         {
            this.ConfirmSubtitle_mc.visible = false;
         }
      }
      
      public function set acceptButtonText(param1:String) : *
      {
         this.AcceptButton.ButtonText = param1;
      }
      
      public function set altButtonText(param1:String) : *
      {
         this.AltButton.ButtonText = param1;
         this.AltButton.ButtonVisible = param1.length > 0;
      }
      
      public function set altButton2Text(param1:String) : *
      {
         this.AltButton2.ButtonText = param1;
         this.AltButton2.ButtonVisible = param1.length > 0;
      }
      
      public function set hasCancelButton(param1:Boolean) : *
      {
         this.CancelButton.ButtonVisible = param1;
      }
      
      public function AddComponentSource(param1:String, param2:uint, param3:String, param4:uint, param5:uint = 4294967295, param6:Boolean = false, param7:uint = 0) : *
      {
         var _loc8_:* = null;
         var _loc9_:* = this.m_Entries.length;
         var _loc10_:* = 0;
         while(_loc10_ < _loc9_)
         {
            if(this.m_Entries[_loc10_].itemName == param1)
            {
               _loc8_ = this.m_Entries[_loc10_];
               break;
            }
            _loc10_++;
         }
         if(_loc8_ == null)
         {
            _loc8_ = new ConfirmPanelComponentSourceEntry(param1);
            addChild(_loc8_);
            this.m_Entries.push(_loc8_);
         }
         _loc8_.itemCount = Math.max(param2,_loc8_.itemCount);
         _loc8_.AddComponent(param3,param4,param5,param6,param7);
      }
      
      public function Build() : *
      {
         var _loc7_:uint = 0;
         var _loc8_:ConfirmPanelComponentSourceEntry = null;
         var _loc1_:* = this.m_Entries.length;
         var _loc2_:Number = this.ConfirmQuestion_mc.y;
         var _loc3_:uint = 0;
         var _loc4_:TextField = this.ConfirmQuestion_mc.ConfirmQuestion_tf as TextField;
         var _loc5_:TextField = this.ConfirmSubtitle_mc.ConfirmSubtitle_tf as TextField;
         _loc2_ += GlobalFunc.getTextfieldSize(_loc4_);
         if(this.ConfirmSubtitle_mc.visible)
         {
            this.ConfirmSubtitle_mc.y = _loc2_;
            _loc2_ += GlobalFunc.getTextfieldSize(_loc5_);
         }
         _loc2_ += this.YBufferAfterQuestionC;
         this.ScrollUp_mc.y = _loc2_;
         _loc2_ += this.ScrollUp_mc.height + this.YBufferAfterQuestionC / 2;
         this.m_ConfirmQuestionFullHeight = _loc2_;
         var _loc6_:Number = GlobalFunc.getTextfieldSize(_loc4_,false);
         if(this.ConfirmSubtitle_mc.visible)
         {
            _loc6_ = Math.max(_loc6_,GlobalFunc.getTextfieldSize(_loc5_,false));
         }
         _loc7_ = 0;
         while(_loc7_ < _loc1_)
         {
            (_loc8_ = this.m_Entries[_loc7_]).originalY = _loc2_;
            _loc8_.y = _loc2_;
            _loc8_.UpdateList();
            _loc6_ = Math.max(_loc6_,this.m_Entries[_loc7_].fullWidth);
            _loc2_ += _loc8_.height + this.YBufferBetweenEntriesC;
            _loc7_++;
         }
         this.ButtonHintBar_mc.redrawUIComponent();
         _loc6_ = Math.max(_loc6_,this.ButtonHintBar_mc.Sizer_mc.width);
         _loc6_ = Math.max(this.MinWidthC,_loc6_ + this.WidthPaddingC);
         _loc7_ = 0;
         while(_loc7_ < _loc1_)
         {
            (_loc8_ = this.m_Entries[_loc7_]).x = _loc6_ / 2;
            _loc7_++;
         }
         this.TopComponentSource = !!_loc1_ ? 0 : -1;
         this.TopComponent = 0;
         this.BGRect_mc.height = Math.min(_loc2_,this.MaxHeightC) + this.YBufferBeforeButtonsC + this.ButtonHintBar_mc.Sizer_mc.height + this.YBufferAfterButtonsC;
         this.ButtonHintBar_mc.y = this.BGRect_mc.height - this.ButtonHintBar_mc.Sizer_mc.height - this.YBufferAfterButtonsC;
         this.x = (loaderInfo.width - _loc6_) / 2;
         this.y = (loaderInfo.height - this.BGRect_mc.height) / 2;
         this.BGRect_mc.width = _loc6_;
         this.ConfirmQuestion_mc.x = _loc6_ / 2;
         this.ButtonHintBar_mc.x = _loc6_ / 2;
         this.ScrollDown_mc.y = this.ButtonHintBar_mc.y - this.YBufferBeforeButtonsC - this.ScrollDown_mc.height;
         this.UpdateScroll();
      }
      
      private function onAcceptButton() : *
      {
         this.BGSCodeObj.onAcceptPress();
      }
      
      private function onCancelButton() : *
      {
         trace("Canceling craft");
         this.BGSCodeObj.onCancelPress();
      }
      
      private function onAltButton() : *
      {
         this.BGSCodeObj.onAltPress();
      }
      
      private function onAltButton2() : *
      {
         this.BGSCodeObj.onAltPress2();
      }
      
      public function ScrollUp() : *
      {
         var _loc1_:ConfirmPanelComponentSourceEntry = null;
         if(this.ScrollUp_mc.visible)
         {
            if(this.TopComponent > 0)
            {
               --this.TopComponent;
            }
            else
            {
               --this.TopComponentSource;
               _loc1_ = this.m_Entries[this.TopComponentSource];
               this.TopComponent = _loc1_.numComponents - 1;
            }
            this.UpdateScroll();
         }
      }
      
      public function ScrollDown() : *
      {
         var _loc1_:ConfirmPanelComponentSourceEntry = null;
         if(this.ScrollDown_mc.visible)
         {
            _loc1_ = this.m_Entries[this.TopComponentSource];
            if(this.TopComponent == _loc1_.numComponents - 1)
            {
               if(this.TopComponentSource < this.m_Entries.length - 1)
               {
                  ++this.TopComponentSource;
                  this.TopComponent = 0;
                  this.UpdateScroll();
               }
            }
            else
            {
               ++this.TopComponent;
               this.UpdateScroll();
            }
         }
      }
      
      public function onLeftThumbstickInput(param1:uint) : *
      {
         if(param1 == 1)
         {
            this.ScrollUp();
         }
         else if(param1 == 3)
         {
            this.ScrollDown();
         }
      }
      
      public function onMouseWheel(param1:MouseEvent) : *
      {
         if(param1.delta > 0)
         {
            this.ScrollUp();
         }
         else if(param1.delta < 0)
         {
            this.ScrollDown();
         }
      }
      
      public function onUpArrowClick(param1:MouseEvent) : *
      {
         if(this.ScrollUp_mc.visible)
         {
            this.ScrollUp();
         }
      }
      
      public function onDownArrowClick(param1:MouseEvent) : *
      {
         if(this.ScrollDown_mc.visible)
         {
            this.ScrollDown();
         }
      }
      
      private function UpdateScroll() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:ConfirmPanelComponentSourceEntry = null;
         var _loc4_:* = undefined;
         var _loc5_:Boolean = false;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         if(this.TopComponentSource == -1)
         {
            this.ScrollUp_mc.visible = this.ScrollDown_mc.visible = false;
         }
         else
         {
            _loc1_ = this.m_ConfirmQuestionFullHeight;
            _loc2_ = this.ButtonHintBar_mc.y - this.YBufferBeforeButtonsC;
            _loc3_ = this.m_Entries[this.TopComponentSource];
            _loc4_ = _loc3_.GetComponentOriginalY(this.TopComponent) - _loc1_;
            _loc5_ = false;
            _loc6_ = this.m_Entries.length;
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc3_ = this.m_Entries[_loc7_];
               _loc3_.y = _loc3_.originalY - _loc4_;
               _loc5_ = _loc3_.Clip(_loc1_,_loc2_);
               _loc7_++;
            }
            this.ScrollUp_mc.visible = this.TopComponentSource > 0 || this.TopComponent > 0;
            if(_loc5_)
            {
               if(this.TopComponent < _loc3_.numComponents - 1)
               {
                  this.ScrollDown_mc.visible = true;
               }
               else
               {
                  this.ScrollDown_mc.visible = this.TopComponentSource < _loc6_ - 1;
               }
            }
            else
            {
               this.ScrollDown_mc.visible = false;
            }
         }
      }
   }
}
