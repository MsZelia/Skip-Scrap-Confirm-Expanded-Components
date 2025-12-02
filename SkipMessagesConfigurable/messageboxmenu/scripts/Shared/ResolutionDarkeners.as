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
      
      private static const DEFAULT_RADIAL_RATIOS:Array = [150,255];
      
      private static const SUPER_ULTRAWIDE_RADIAL_RATIOS:Array = [25,175];
      
      private static const ULTRAWIDE_RADIAL_RATIOS:Array = [75,255];
      
      private static const LINEAR_RATIOS:Array = [75,125];
      
      private static const FILL_COLOR:* = 0;
      
      private static const ALPHA_VALUE:* = 0.75;
      
      public function ResolutionDarkeners()
      {
         super();
      }
      
      public static function CreateDarkener(param1:uint, param2:uint, param3:uint, param4:Number = 0, param5:String = "16:9") : Shape
      {
         var _loc9_:Matrix = null;
         var _loc10_:Array = null;
         var _loc11_:* = undefined;
         var _loc6_:Shape = new Shape();
         var _loc7_:Number = param1 < FLA_WIDTH ? FLA_WIDTH : param1;
         var _loc8_:Number = param2 < FLA_HEIGHT ? FLA_HEIGHT : param1;
         switch(param3)
         {
            case DARKENER_TYPE_SOLID:
               _loc6_.graphics.beginFill(FILL_COLOR);
               _loc6_.graphics.drawRect(0,0,_loc7_,_loc8_);
               _loc6_.graphics.endFill();
               _loc6_.alpha = param4 > 0 ? param4 : ALPHA_VALUE;
               break;
            case DARKENER_TYPE_RADIAL:
               _loc9_ = new Matrix();
               _loc9_.createGradientBox(_loc7_ + _loc7_ * 0.2,_loc8_ + _loc8_ * 0.2,0,0 - _loc7_ * 0.2 / 2,0 - _loc8_ * 0.2 / 2);
               _loc10_ = DEFAULT_RADIAL_RATIOS;
               switch(param5)
               {
                  case "21:9":
                     _loc10_ = ULTRAWIDE_RADIAL_RATIOS;
                     break;
                  case "32:9":
                     _loc10_ = SUPER_ULTRAWIDE_RADIAL_RATIOS;
               }
               _loc6_.graphics.beginGradientFill(GradientType.RADIAL,GRADIENT_COLORS,RADIAL_ALPHAS,_loc10_,_loc9_);
               _loc6_.graphics.drawRect(0,0,_loc7_,_loc8_);
               break;
            case DARKENER_TYPE_LINEAR_LEFT:
               _loc11_ = new Matrix();
               _loc11_.createGradientBox(_loc7_,_loc8_);
               _loc6_.graphics.beginGradientFill(GradientType.LINEAR,GRADIENT_COLORS,LINEAR_LEFT_ALPHAS,LINEAR_RATIOS,_loc11_);
               _loc6_.graphics.drawRect(0,0,_loc7_,_loc8_);
               break;
            case DARKENER_TYPE_LINEAR_RIGHT:
               _loc11_ = new Matrix();
               _loc11_.createGradientBox(_loc7_,_loc8_);
               _loc6_.graphics.beginGradientFill(GradientType.LINEAR,GRADIENT_COLORS,LINEAR_RIGHT_ALPHAS,LINEAR_RATIOS,_loc11_);
               _loc6_.graphics.drawRect(0,0,_loc7_,_loc8_);
         }
         return _loc6_;
      }
      
      public static function PositionDarkener(param1:Shape) : void
      {
         param1.x -= param1.width / 2 - FLA_WIDTH / 2;
         param1.y -= param1.height / 2 - FLA_HEIGHT / 2;
      }
   }
}

