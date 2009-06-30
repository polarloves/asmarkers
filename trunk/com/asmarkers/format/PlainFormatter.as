/**
 * PlainFormat.as
 *
 * This class attemp to display the data in 
 * a way similar to Yahoo smart markers
 * 
 * Configuration parameters
 * 
 * minWidth
 *     Number
 *     Minimum valid width
 * 
 * minHeight
 *     Number
 *     Minimum valid height
 * 
 * maxWidth
 *     Number
 *     Maximum valid width
 * 
 * maxHeight
 *     Number
 *     Maximum valid height
 *
 * padding
 *     Number
 *     In pixels, how much space should be left in each side of the marker
 *     Default: 2
 * 
 * 
 * Author:
 *    Fabio R. Panettieri
 *    frenzo.panettieri@gmail.com
 *
 * Date:
 *    18/06/2009
 *      
 */

package com.asmarkers.format
{
    import com.asmarkers.data.SmartData;
    import com.asmarkers.event.FormatterEvent;
    import com.asmarkers.state.DetailState;
    import com.asmarkers.state.IconState;
    import com.asmarkers.state.MarkerState;
    import com.asmarkers.state.TooltipState;
    
    import flash.text.TextField;
    import flash.text.TextFormat;
    
    public class PlainFormatter extends TextFormatter
    {
        protected var _text:TextField;
        
        protected var _maxWidth:Number;
        protected var _maxHeight:Number;
        protected var _minWidth:Number;
        protected var _minHeight:Number;
        
        protected var _padding:Number;
        
        public function PlainFormatter()
        {
            super();
            _text = new TextField;
            _text.selectable = false;
            _text.mouseEnabled = false;
            _text.width = 0;
            _text.height = 0;
            addChild(_text);
        }
        
        override public function configure(config:Object):void
        {
            super.configure(config);

            // Safe initialization
            var cfg:Object = config ? config : {};           
            
            _maxWidth = cfg.maxWidth;
            _maxHeight = cfg.maxHeight;
            
            _minWidth = cfg.minWidth;
            _minHeight = cfg.minHeight;
            
            _padding = cfg.padding ? cfg.padding : 2;
            
            _text.defaultTextFormat = new TextFormat(_fontFamily, _fontSize, _fontColor, _bold, _italic, _underline);
        }
        
        override public function draw(minX:Number, minY:Number, maxX:Number, maxY:Number):void
        {
            _text.x = minX + _padding;
            _text.y = minY + _padding;
            
            _text.width =  maxX - minX - 2 * _padding;
            _text.height = maxY - minY - 2 * _padding;
        }
        
        override public function changeState(state:MarkerState):void
        {
            if(_data != null){
                var data:SmartData = _data as SmartData;
                
                if(state is IconState){
                    _text.text = data.id;
                } else if (state is TooltipState){
                    _text.text = data.tooltip;
                } else if (state is DetailState){
                    _text.text = data.detail;
                }
                
                adjustSize();
              }
        }
        
        private function adjustSize():void
        {
            _width = _text.textWidth + 4 + _padding * 2;
            _height = _text.textHeight + 4 + _padding * 2;
            
            // Adjusting width
            if(!isNaN(_maxWidth) && _maxWidth < _width - 2 * _padding){
                _width = _maxWidth;
                                
            } else if(!isNaN(_minWidth) && _minWidth > _width ){
                _width = _minWidth;
            }
            
            // Adjusting height
            if(!isNaN(_maxHeight) && _maxHeight < _height - 2 * _padding){
                _height = _maxHeight;
                
            } else if(!isNaN(_minHeight) && _minHeight > _height) {
                _height = _minHeight;
            }
            
            dispatchEvent(new FormatterEvent(FormatterEvent.RESIZE));
        }
        
    }
}
