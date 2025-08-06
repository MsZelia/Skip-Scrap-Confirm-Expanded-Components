package
{
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2")]
   public class ConfirmPanelComponentSourceEntry extends MovieClip
   {
      
      public var textField:TextField;
      
      private var XBufferBeforeComponentsC:* = 17.25;
      
      private var EntriesA:Array;
      
      private var ItemCount:uint;
      
      private var ItemName:String;
      
      private var OriginalWidth:Number;
      
      private var OriginalY:Number;
      
      private var ComponentDisplayColor:uint;
      
      public function ConfirmPanelComponentSourceEntry(param1:String)
      {
         super();
         this.EntriesA = new Array();
         this.ItemName = param1;
         Extensions.enabled = true;
         TextFieldEx.setTextAutoSize(this.textField,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setNoTranslate(this.textField,true);
      }
      
      public function get itemCount() : uint
      {
         return this.ItemCount;
      }
      
      public function set itemCount(param1:uint) : *
      {
         this.ItemCount = param1;
         this.UpdateText();
      }
      
      public function get itemName() : String
      {
         return this.ItemName;
      }
      
      public function get numComponents() : uint
      {
         return this.EntriesA.length;
      }
      
      public function get originalY() : Number
      {
         return this.OriginalY;
      }
      
      public function set originalY(param1:Number) : *
      {
         this.OriginalY = param1;
      }
      
      public function get textWidth() : Number
      {
         return this.textField.textWidth;
      }
      
      public function get textFieldWidth() : Number
      {
         return this.textField.width;
      }
      
      public function set textFieldWidth(param1:*) : *
      {
         var _loc2_:* = param1 - this.textField.width;
         this.textField.width = param1;
         this.textField.x -= _loc2_;
      }
      
      public function get fullWidth() : Number
      {
         var _loc2_:ConfirmPanelComponentEntry = null;
         var _loc1_:Number = this.width;
         var _loc3_:uint = 0;
         while(_loc3_ < this.EntriesA.length)
         {
            _loc2_ = this.EntriesA[_loc3_] as ConfirmPanelComponentEntry;
            _loc1_ = Math.max(_loc1_,(_loc2_.width + this.XBufferBeforeComponentsC) * 2);
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function AddComponent(param1:String, param2:uint, param3:uint = 4294967295, param4:Boolean = false, param5:* = 0) : *
      {
         var _loc6_:ConfirmPanelComponentEntry = null;
         var _loc7_:* = this.EntriesA.length;
         var _loc8_:* = 0;
         while(_loc8_ < _loc7_)
         {
            if(this.EntriesA[_loc8_].componentName == param1)
            {
               _loc6_ = this.EntriesA[_loc8_];
               break;
            }
            _loc8_++;
         }
         if(_loc6_ == null)
         {
            _loc6_ = new ConfirmPanelComponentEntry(param1);
            _loc6_.x = this.XBufferBeforeComponentsC;
            addChild(_loc6_);
            this.EntriesA.push(_loc6_);
         }
         _loc6_.componentRequiredCount += param2;
         _loc6_.componentInventoryCount = param3;
         _loc6_.componentFavorited = param4;
         _loc6_.componentDisplayColor = param5;
         this.ComponentDisplayColor = param5;
         if(param5)
         {
            this.UpdateText();
         }
      }
      
      public function Clip(param1:Number, param2:Number) : Boolean
      {
         var _loc8_:* = undefined;
         var _loc3_:Boolean = false;
         var _loc4_:Number = param1 - y;
         var _loc5_:Number = param2 - y;
         this.textField.visible = this.textField.y >= _loc4_ && this.textField.y + this.textField.textHeight <= _loc5_;
         var _loc6_:* = this.EntriesA.length;
         var _loc7_:* = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = this.EntriesA[_loc7_] as ConfirmPanelComponentEntry;
            if(_loc8_.y < _loc4_ - 1)
            {
               _loc8_.visible = false;
            }
            else if(_loc8_.y + _loc8_.height > _loc5_)
            {
               _loc8_.visible = false;
               _loc3_ = true;
            }
            else
            {
               _loc8_.visible = true;
            }
            _loc7_++;
         }
         return _loc3_;
      }
      
      public function GetComponentOriginalY(param1:uint) : Number
      {
         var _loc2_:* = this.EntriesA[0] as ConfirmPanelComponentEntry;
         return this.OriginalY + param1 * _loc2_.height;
      }
      
      public function UpdateList() : *
      {
         var _loc4_:* = undefined;
         var _loc1_:* = 0;
         var _loc2_:* = this.EntriesA.length;
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.EntriesA[_loc3_] as ConfirmPanelComponentEntry;
            _loc4_.y = _loc1_;
            _loc1_ += _loc4_.height;
            _loc3_++;
         }
      }
      
      public function UpdateText() : *
      {
         var _loc1_:* = null;
         var _loc2_:String = null;
         if(this.ItemCount > 1)
         {
            _loc1_ = this.ItemName + " (" + this.ItemCount.toString() + ")";
         }
         else
         {
            _loc1_ = this.ItemName;
         }
         trace(this.ComponentDisplayColor);
         if(this.ComponentDisplayColor > 0)
         {
            _loc2_ = this.ComponentDisplayColor.toString(16);
            _loc1_ = "<font color=\"#" + _loc2_ + "\">" + _loc1_ + "</font>";
         }
         trace(_loc1_);
         GlobalFunc.SetText(this.textField,_loc1_,true);
      }
   }
}

