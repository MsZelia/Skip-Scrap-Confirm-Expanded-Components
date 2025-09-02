package
{
   import Shared.AS3.BSScrollingListEntry;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol80")]
   public class ActivationTooltipListEntry extends BSScrollingListEntry
   {
      
      public var Text_tf:TextField;
      
      public function ActivationTooltipListEntry()
      {
         super();
      }
      
      override public function SetEntryText(param1:Object, param2:String) : *
      {
         this.Text_tf.text = param1.text;
      }
   }
}

