package Shared
{
   import flash.display.GradientType;
   import flash.display.Shape;
   import flash.geom.Matrix;
   
   public class ResolutionDarkeners
   {
      
      public static const FLA_WIDTH:Number = 1920;
      
      public static const FLA_HEIGHT:Number = 1080;
      
      public static const DARKENER_TYPE_SOLID:uint = 0;
      
      public static const DARKENER_TYPE_RADIAL:uint = 1;
      
      public static const DARKENER_TYPE_LINEAR_LEFT:uint = 2;
      
      public static const DARKENER_TYPE_LINEAR_RIGHT:uint = 3;
      
      private static const GRADIENT_COLORS:Array = [0,0];
      
      private static const RADIAL_ALPHAS:Array = [0,0.75];
      
      private static const LINEAR_LEFT_ALPHAS:Array = [0.9,0];
      
      private static const LINEAR_RIGHT_ALPHAS:Array = [0,0.9];
      
      private static const RADIAL_RATIOS:Array = [150,255];
      
      private static const LINEAR_RATIOS:Array = [75,125];
      
      private static const FILL_COLOR:* = 0;
      
      private static const ALPHA_VALUE:* = 0.75;
       
      
      public function ResolutionDarkeners()
      {
         super();
      }
      
      public static function CreateDarkener(param1:uint, param2:uint, param3:uint) : Shape
      {
         var _loc7_:Matrix = null;
         var _loc8_:* = undefined;
         var _loc4_:Shape = new Shape();
         var _loc5_:Number = param1 < FLA_WIDTH ? FLA_WIDTH : param1;
         var _loc6_:Number = param2 < FLA_HEIGHT ? FLA_HEIGHT : param1;
         switch(param3)
         {
            case DARKENER_TYPE_SOLID:
               _loc4_.graphics.beginFill(FILL_COLOR);
               _loc4_.graphics.drawRect(0,0,_loc5_,_loc6_);
               _loc4_.graphics.endFill();
               _loc4_.alpha = ALPHA_VALUE;
               break;
            case DARKENER_TYPE_RADIAL:
               (_loc7_ = new Matrix()).createGradientBox(_loc5_ + _loc5_ * 0.2,_loc6_ + _loc6_ * 0.2,0,0 - _loc5_ * 0.2 / 2,0 - _loc6_ * 0.2 / 2);
               _loc4_.graphics.beginGradientFill(GradientType.RADIAL,GRADIENT_COLORS,RADIAL_ALPHAS,RADIAL_RATIOS,_loc7_);
               _loc4_.graphics.drawRect(0,0,_loc5_,_loc6_);
               break;
            case DARKENER_TYPE_LINEAR_LEFT:
               (_loc8_ = new Matrix()).createGradientBox(_loc5_,_loc6_);
               _loc4_.graphics.beginGradientFill(GradientType.LINEAR,GRADIENT_COLORS,LINEAR_LEFT_ALPHAS,LINEAR_RATIOS,_loc8_);
               _loc4_.graphics.drawRect(0,0,_loc5_,_loc6_);
               break;
            case DARKENER_TYPE_LINEAR_RIGHT:
               (_loc8_ = new Matrix()).createGradientBox(_loc5_,_loc6_);
               _loc4_.graphics.beginGradientFill(GradientType.LINEAR,GRADIENT_COLORS,LINEAR_RIGHT_ALPHAS,LINEAR_RATIOS,_loc8_);
               _loc4_.graphics.drawRect(0,0,_loc5_,_loc6_);
         }
         return _loc4_;
      }
      
      public static function PositionDarkener(param1:Shape) : void
      {
         param1.x -= param1.width / 2 - FLA_WIDTH / 2;
         param1.y -= param1.height / 2 - FLA_HEIGHT / 2;
      }
   }
}
