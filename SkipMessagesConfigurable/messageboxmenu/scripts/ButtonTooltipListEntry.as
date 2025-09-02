package
{
   import Shared.AS3.BSScrollingListEntry;
   import Shared.AS3.Events.PlatformChangeEvent;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol75")]
   public class ButtonTooltipListEntry extends BSScrollingListEntry
   {
      
      private static var m_Platform:uint;
      
      public var Button_mc:MovieClip;
      
      public var Text_tf:TextField;
      
      public var HoldMeter_mc:MovieClip;
      
      private const TEXT_SPACING:uint = 24;
      
      public function ButtonTooltipListEntry()
      {
         super();
         this.buttonTextField.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public static function set platform(param1:uint) : *
      {
         m_Platform = param1;
      }
      
      private function get buttonTextField() : TextField
      {
         return this.Button_mc.IconAnimInstance.Icon_tf as TextField;
      }
      
      override public function SetEntryText(param1:Object, param2:String) : *
      {
         var _loc3_:TextFormat = null;
         this.Text_tf.text = param1.text;
         this.HoldMeter_mc.visible = param1.canHold;
         switch(m_Platform)
         {
            case PlatformChangeEvent.PLATFORM_PC_KB_MOUSE:
               _loc3_ = new TextFormat("$MAIN_FONT");
               this.Button_mc.IconAnimInstance.Icon_tf.setTextFormat(_loc3_);
               this.Button_mc.IconAnimInstance.Icon_tf.text = param1.button + ")";
               break;
            case PlatformChangeEvent.PLATFORM_PC_GAMEPAD:
            case PlatformChangeEvent.PLATFORM_XB1:
               _loc3_ = new TextFormat("$Controller_buttons");
               this.Button_mc.IconAnimInstance.Icon_tf.setTextFormat(_loc3_);
               this.Button_mc.IconAnimInstance.Icon_tf.text = GlobalFunc.GetButtonFontKey(param1.button);
               break;
            case PlatformChangeEvent.PLATFORM_PS4:
               _loc3_ = new TextFormat("$Controller_buttons");
               this.Button_mc.IconAnimInstance.Icon_tf.setTextFormat(_loc3_);
               this.Button_mc.IconAnimInstance.Icon_tf.text = GlobalFunc.GetButtonFontKey(param1.button);
         }
         this.Text_tf.x = this.Button_mc.x + this.buttonTextField.width + this.TEXT_SPACING;
      }
   }
}

