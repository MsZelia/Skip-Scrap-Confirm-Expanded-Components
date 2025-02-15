package
{
   import Shared.AS3.BSScrollingListEntry;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol7")]
   public class MessageBoxButtonEntry extends BSScrollingListEntry
   {
      
      public static const ENTRY_BORDER_PAD:Number = 30;
       
      
      private var m_BaseFilters:Array;
      
      public function MessageBoxButtonEntry()
      {
         super();
         this.m_BaseFilters = textField.filters;
      }
      
      public function CalculateBorderWidth() : Number
      {
         return textField.getLineMetrics(0).width + ENTRY_BORDER_PAD;
      }
      
      public function SetBorderWidth(param1:Number) : *
      {
         border.width = param1;
         border.x = param1 * -0.5;
      }
      
      override public function SetEntryText(param1:Object, param2:String) : *
      {
         super.SetEntryText(param1,param2);
         if(selected)
         {
            textField.filters = [];
         }
         else
         {
            textField.filters = this.m_BaseFilters;
         }
      }
   }
}
