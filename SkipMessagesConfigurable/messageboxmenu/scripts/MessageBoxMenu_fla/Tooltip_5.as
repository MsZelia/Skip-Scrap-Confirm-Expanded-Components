package MessageBoxMenu_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol94")]
   public dynamic class Tooltip_5 extends MovieClip
   {
      
      public var TooltipList_mc:TooltipList;
      
      public var Tooltip_tf:TextField;
      
      public function Tooltip_5()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         stop();
      }
   }
}

