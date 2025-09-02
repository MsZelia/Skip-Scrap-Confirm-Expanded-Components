package
{
   import Shared.AS3.BSScrollingList;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol83")]
   public class MessageBoxButtonList extends BSScrollingList
   {
      
      private var m_GreatestWidth:Number = 0;
      
      public function MessageBoxButtonList()
      {
         super();
      }
      
      public function get greatestWidth() : Number
      {
         return this.m_GreatestWidth;
      }
      
      override public function InvalidateData() : *
      {
         super.InvalidateData();
         this.SetEntryBorderWidths();
      }
      
      private function SetEntryBorderWidths() : *
      {
         var _loc3_:MessageBoxButtonEntry = null;
         var _loc4_:Number = NaN;
         var _loc5_:MessageBoxButtonEntry = null;
         this.m_GreatestWidth = 0;
         var _loc1_:uint = 0;
         while(_loc1_ < uiNumListItems)
         {
            _loc3_ = GetClipByIndex(_loc1_) as MessageBoxButtonEntry;
            if(Boolean(_loc3_) && Boolean(_loc3_.textField))
            {
               _loc4_ = _loc3_.CalculateBorderWidth();
               if(_loc4_ > this.m_GreatestWidth)
               {
                  this.m_GreatestWidth = _loc4_;
               }
            }
            _loc1_++;
         }
         var _loc2_:uint = 0;
         while(_loc2_ < uiNumListItems)
         {
            _loc5_ = GetClipByIndex(_loc2_) as MessageBoxButtonEntry;
            if(_loc5_)
            {
               _loc5_.SetBorderWidth(this.m_GreatestWidth);
            }
            _loc2_++;
         }
         border.x = this.greatestWidth * -0.5;
         border.width = this.greatestWidth;
         if(ScrollUp != null)
         {
            ScrollUp.x = this.greatestWidth * -0.5 - 50;
         }
         if(ScrollDown != null)
         {
            ScrollDown.x = ScrollUp.x;
         }
         if(Mask_mc != null)
         {
            Mask_mc.x = border.x;
            Mask_mc.width = border.width;
         }
      }
      
      override protected function updateScrollPosition(param1:uint) : *
      {
         super.updateScrollPosition(param1);
         this.SetEntryBorderWidths();
      }
   }
}

