/**
 * SquaredSprite.as
 *
 * A simple bubble marker
 * 
 * Configurable attributes
 *
 * width
 *     Number
 *     Marker initial width 
 *     Default: 20 
 * 
 * height
 *     Number
 *     Marker initial height 
 *     Default: 20
 * 
 * tailWidth
 *     Number
 *     Indicates the width of the marker tail  
 *     Default: 5
 * 
 * tailHeight
 *     Number
 *     Indicates the height of the marker tail  
 *     Default: 8
 * 
 * backgroundColor
 *     uint
 *     Background color in hexagesimal format
 *     Default: 0xF17A26
 *
 * backgroundAlpha
 *     Number
 *     Background transparency, between 0 and 1
 *     Default: 1
 *
 * borderColor
 *     uint
 *     Border color in hexagesimal format
 *     Default.: 0xFFFFFF
 *     
 * borderAlpha
 *     Number
 *     Border transparency, between 0 and 1
 *     Default: 1
 * 
 * borderWidth
 *     Number
 *     Used to determine how thick the line will be
 *     Default: 1
 * 
 * tweenDuration
 *     Number
 *     Indicates how much long should the transition effect be
 *     Default: 0.5
 * 
 *
 * Author:
 *    Fabio R. Panettieri
 *    frenzo.panettieri@gmail.com
 *
 * Date:
 *    17/06/2009
 *      
 */
 
package com.asmarkers.sprite
{
    import com.asmarkers.event.FormatterEvent;
    import com.asmarkers.state.MarkerState;
    import com.eclecticdesignstudio.utils.tween.GTweener;
    
    import flash.events.Event;
    
    public class SquaredBubbleSprite extends BubbleSprite
    {
        override public function draw():void
        {
            // Set marker content bbox
            _left = 0;
            _top = -_height - _tailHeight;
            _right = _width;  
            _bottom = -_tailHeight;
            
            with(this.graphics){
                clear();
                
                lineStyle(_borderWidth, _borderColor, _borderAlpha); 
                beginFill(_backgroundColor, _backgroundAlpha);
                
                lineTo(_left, _top);
                lineTo(_right, _top);
                lineTo(_right, _bottom);
                lineTo(_tailWidth, _bottom);
                
                endFill();
            }
            
            _format.draw(_left, _bottom, _right, _top);
        }
    }
}

