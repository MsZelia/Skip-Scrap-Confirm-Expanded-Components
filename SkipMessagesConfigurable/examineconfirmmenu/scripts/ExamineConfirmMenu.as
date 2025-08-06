package
{
   import Shared.AS3.IMenu;
   import flash.events.KeyboardEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol23")]
   public class ExamineConfirmMenu extends IMenu
   {
      
      public var BGRect_mc:TextField;
      
      public var Confirm_mc:ConfirmPanel;
      
      public var BGSCodeObj:Object;
      
      public function ExamineConfirmMenu()
      {
         super();
         this.BGSCodeObj = new Object();
         addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
      }
      
      public function onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            this.BGSCodeObj.OnAcceptPress();
         }
      }
      
      public function onKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.UP)
         {
            this.Confirm_mc.ScrollUp();
         }
         else if(param1.keyCode == Keyboard.DOWN)
         {
            this.Confirm_mc.ScrollDown();
         }
      }
      
      public function onCodeObjCreate() : *
      {
         this.Confirm_mc.InitCodeObj(this.BGSCodeObj);
      }
      
      public function onCodeObjDestruction() : *
      {
         this.Confirm_mc.ReleaseCodeObj();
      }
   }
}

