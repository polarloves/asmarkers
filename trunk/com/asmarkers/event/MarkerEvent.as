/*
 * MarkerEvent.as
 *
 * Author: 
 *    Fabio R. Panettieri
 *    fpanettieri@gisworking.com
 *
 * Copyright (c) 2008 Spatial Networks, Inc.
 * All Rights Reserved
 *
 */

package com.asmarkers.event
{
    import com.asmarkers.core.Marker;
    
    import flash.events.Event;
    
    public class MarkerEvent extends Event
    {
        public static const STATE_CHANGE:String = 'stateChangeEvent';
        
        public var marker:Marker;
        public var state:String;
        
        public function MarkerEvent(marker:Marker, state:String, type:String, bubbles:Boolean = true, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
            this.marker = marker;
            this.state = state; 
        }
        
    }
}

