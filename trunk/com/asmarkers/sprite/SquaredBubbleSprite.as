/*
 * SquaredSprite.as
 *
 * A simple bubble marker
 * 
 * Configurable attributes
 *
 * bgColor
 *     Background color in hexagesimal format
 *     Ex.: 0xF17A26
 *
 * bgAlpha
 *     Background transparency, between 0 and 1
 *     Ex.: 0.6
 *
 * fgColor
 *     Foreground color in hexagesimal format
 *     Ex.: 0xB0E9E9
 *     
 * bgAlpha
 *     Foreground transparency, between 0 and 1
 *     Ex.: 0.6
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
    import com.asmarkers.event.MarkerEvent;
    import com.asmarkers.format.SmartFormat;
    import com.asmarkers.state.MarkerState;
    import com.eclecticdesignstudio.utils.tween.GTweener;
    
    import flash.events.Event;
    
    public class SquaredBubbleSprite extends MarkerSprite
    {
        protected var _width:Number;
    	protected var _height:Number;
    	
    	protected var _borderColor:uint;
    	protected var _borderAlpha:Number;
    	protected var _borderWidth:Number;
    	
    	protected var _backgroundColor:uint;
    	protected var _backgroundAlpha:Number;
    	
    	// Used to indicate the contet where should it be placed
    	private var _minX:Number;
    	private var _minY:Number;
    	
    	// Tween duration
    	private var _tweenDuration:Number;
    	
    	override public function configure(cfg:Object):void
    	{
    		_width = cfg.width ? cfg.width : 20;
    		_height = cfg.height ? cfg.height : 20;
    		
    		_borderColor = cfg.borderColor ? cfg.borderColor : 0xFFFFFF;
    		_borderAlpha = cfg.borderAlpha ? cfg.borderAlpha : 1;
    		_borderWidth = cfg.borderWidth ? cfg.borderWidth : 1;
    		
    		_backgroundColor = cfg.backgroundColor ? cfg.backgroundColor : 0xF17A26;
    		_backgroundAlpha = cfg.backgroundAlpha ? cfg.backgroundAlpha : 1;
    		
    		_tweenDuration = cfg.tweenDuration ? cfg.tweenDuration : 0.5;
    		 
    		_format = new SmartFormat();
    		_format.configure(cfg);
    		addChild(_format);
    		
    		cfg.marker.addEventListener(MarkerEvent.STATE_CHANGE, stateChangeHandler, false, 0, false);
    	}
        
        override public function draw():void
        {
        	// Set marker bbox
        	_minX = 1;
        	_minY = -_height - 8;
        	
            with(this.graphics){
                clear();
                
                lineStyle(_borderWidth, _borderColor, _borderAlpha); 
                beginFill(_backgroundColor, _backgroundAlpha);
                
                //moveTo(0,0);
                lineTo(0,-_height-8);
                lineTo(_width,-_height-8);
                lineTo(_width,-8);
                lineTo(5,-8);
                endFill();
            }
            
            _format.draw(_minX, _minY, _width, _height);
        }

        override public function set width(width:Number):void
        {
        	_width = width;
        }
        
        override public function get width():Number
        {
        	return _width;
        }
        
        override  public function set height(height:Number):void
        {
        	_height = height;
        }
        
        override  public function get height():Number
        {
        	return _height;
        }
        
        private function stateChangeHandler(evt:MarkerEvent):void
        {
        	GTweener.removeTweens (this);
        	_format.changeState(evt.marker.state);
        	
        	// Create tween efect
			GTweener.addTween (this, _tweenDuration, { width: _format.width, height: _format.height }, {changeListener: changeHandler} );
        }
        
        private function changeHandler(evt:Event):void
        {
        	draw();
        }
        
    }
}
