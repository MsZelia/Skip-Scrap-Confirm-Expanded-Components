package
{
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol8")]
   public class ConfirmPanelComponentEntry extends MovieClip
   {
      
      public var textField:TextField;
      
      public var Background_mc:MovieClip;
      
      public var FavoritedIcon_mc:MovieClip;
      
      private var ComponentName:String;
      
      private var ComponentRequiredCount:uint;
      
      private var ComponentInventoryCount:uint;
      
      private var ComponentFavorited:Boolean;
      
      private var ComponentDisplayColor:uint = 0;
      
      public function ConfirmPanelComponentEntry(param1:*)
      {
         super();
         this.ComponentName = param1;
         this.ComponentRequiredCount = 0;
         this.ComponentInventoryCount = uint.MAX_VALUE;
         Extensions.enabled = true;
         TextFieldEx.setTextAutoSize(this.textField,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setNoTranslate(this.textField,true);
      }
      
      public function get componentName() : String
      {
         return this.ComponentName;
      }
      
      public function get componentRequiredCount() : uint
      {
         return this.ComponentRequiredCount;
      }
      
      public function set componentRequiredCount(param1:uint) : *
      {
         this.ComponentRequiredCount = param1;
         this.UpdateText();
      }
      
      public function get componentInventoryCount() : uint
      {
         return this.ComponentInventoryCount;
      }
      
      public function set componentInventoryCount(param1:uint) : *
      {
         this.ComponentInventoryCount = param1;
         this.UpdateText();
      }
      
      public function get componentFavorited() : Boolean
      {
         return this.ComponentFavorited;
      }
      
      public function set componentFavorited(param1:Boolean) : *
      {
         this.ComponentFavorited = param1;
         this.UpdateFavoritedIcon();
      }
      
      public function set componentDisplayColor(param1:uint) : *
      {
         this.ComponentDisplayColor = param1;
         this.UpdateText();
      }
      
      public function UpdateText() : *
      {
         var _loc1_:* = null;
         var _loc2_:String = null;
         if(this.ComponentInventoryCount < uint.MAX_VALUE)
         {
            _loc1_ = this.ComponentName + " (" + Math.min(this.ComponentInventoryCount,this.ComponentRequiredCount).toString() + "/" + this.ComponentRequiredCount.toString() + ")";
         }
         else if(this.ComponentRequiredCount > 1)
         {
            _loc1_ = this.ComponentName + " (" + this.ComponentRequiredCount.toString() + ")";
         }
         else
         {
            _loc1_ = this.ComponentName;
         }
         if(this.ComponentDisplayColor > 0)
         {
            _loc2_ = this.ComponentDisplayColor.toString(16);
            _loc1_ = "<font color=\"#" + _loc2_ + "\">" + _loc1_ + "</font>";
         }
         GlobalFunc.SetText(this.textField,_loc1_,true);
         this.textField.alpha = this.ComponentInventoryCount < this.ComponentRequiredCount ? GlobalFunc.DIMMED_ALPHA : 1;
         if(this.Background_mc != null)
         {
            this.Background_mc.visible = this.ComponentName != "";
         }
      }
      
      public function UpdateFavoritedIcon() : *
      {
         this.FavoritedIcon_mc.visible = this.ComponentFavorited;
      }
   }
}

