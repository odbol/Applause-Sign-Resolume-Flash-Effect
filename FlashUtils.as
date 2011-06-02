﻿//This contains all the functionality that Flash SHOULD have but doesn't or for some reason Adobe removed it.package{	import flash.display.DisplayObject;	import flash.events.*;	import flash.net.URLRequest;	import flash.net.URLLoader;		import flash.display.Loader;	import fl.motion.Color;	import flash.display.Sprite;		import fl.transitions.*;	import fl.transitions.easing.*;		import flash.utils.*;		import flash.filters.GlowFilter;	    public class FlashUtils    {		//this is needed to store references to currently running Tweens so they don't get garbage collected in the middle! Flash is stupid.		private static var tweens:Dictionary = new Dictionary(false); //need strong references since that's the whole point of this!!!			        public function FlashUtils()        {			        }				public static function centerObjWithin(obj, container):void {			//trace("centering: " + obj.width + ": " + container.width);			obj.x = (container.width / 2) - (obj.width / 2);			obj.y = (container.height / 2) - (obj.height / 2);			//trace("centered: " + obj.x + ", " + obj.y);		}		//loads the given URL as text. when fully loaded, calls callback function with single parameter: the loaded content.		public static function loadFromURL(url:String, callback:Function) {			var request:URLRequest = new URLRequest(url);			var loader:URLLoader = new URLLoader();			loader.load(request);										loader.addEventListener(Event.COMPLETE, function (e:Event) {				callback(loader.data);						});		}						//loads an image from the given URL into the given display object container. 		//optionally centers within container or within the given centeredWithin object if not null.		//optionally constrains image to max dimensions given if they are greater than 0.		//callback is a function with one parameter: the image DisplayObject.		//thanks Adobe for making this such a big deal when it took two lines before!		public static function loadImageInto(url:String, container, isCentered:Boolean = true, centeredWithin = null, maxWidth:Number = 0, maxHeight:Number = 0, callback:Function = null) {			var request:URLRequest = new URLRequest(url);			var loader:Loader = new Loader();			loader.load(request);			var contentMC = container.addChild(loader);			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (e:Event) {				var img = e.target.content;											if (maxWidth > 0 || maxHeight > 0) {					if (img.width > img.height) {						img.width = maxWidth;						img.scaleY = img.scaleX;					}					else {						img.height = maxHeight;						img.scaleX = img.scaleY;					}				}								if (isCentered) {					if (!centeredWithin)						centeredWithin = container;											centerObjWithin(img, centeredWithin);				}								if (callback != null)					callback(img);			});						return contentMC;		}				//draws a rectangle to cover the given objToCover and returns that sprite.		public static function drawRectOver(objToCover, color:Number = 0x000000, alpha:Number = 1.0):Sprite { 			var sprite = new Sprite();			sprite.x = objToCover.x;			sprite.y = objToCover.y;			sprite.graphics.lineStyle(1, color, alpha);			sprite.graphics.beginFill(color, alpha);			sprite.graphics.drawRect(0, 0, objToCover.width, objToCover.height);			sprite.graphics.endFill();						return sprite;		}				//fades out the given object using alpha.		//when it is finished, it hides the object and returns it to its original alpha		public static function fadeOut(obj, duration:Number = 0.5) {			var origAlpha = obj.alpha;			var tw = new Tween(obj, "alpha", Strong.easeOut, origAlpha, 0.0, duration, true);						//save the reference so it doesn't get deleted by the GC before it's finished!			tweens[tw] = tw;						tw.addEventListener(TweenEvent.MOTION_FINISH, function (e:TweenEvent) {				e.target.obj.visible = false;				e.target.obj.alpha = origAlpha;  								//okay, we're finally done. NOW you can delete the reference and be GC'd.				delete tweens[tw];			});						tw.start();		}				//fades in the given object using alpha.		public static function fadeIn(obj, duration:Number = 0.5) {						if (!obj.visible) {				obj.alpha = 0;				obj.visible = true;			}						var steps = 23; //should be 20, but go over since flash doesn't know how to add.			var interval = (duration * 100) / steps;						var timer = new Timer(interval, steps); 						timer.addEventListener(TimerEvent.TIMER, function (e:TimerEvent) {							//trace("fade in: " + obj.alpha);				obj.alpha += .05;				//trace("fade in after: " + obj.alpha);			});						timer.start();																					//none of these work. STUPID FLASH!!!						//TransitionManager.start(obj, {type:Fade, direction:Transition.IN, duration:duration, easing:Strong.easeIn});			//var tw = new Tween(obj, "alpha", None.easeNone, obj.alpha, 1.0, duration, true);						//tw.start();			/*			if (!obj.visible) {				//obj.alpha = 0;				obj.visible = true;			}			*/		}						public static function changeBrightness(obj, amount:Number) {			var colorTransformer:Color = new Color();						colorTransformer.brightness = amount;						// Apply the changes to the display object.			obj.transform.colorTransform = colorTransformer;		}				public static function addGlow(obj, color:Number = 0xFF0000, alpha:Number = 1, blur:Number = 6, strength:Number = 2) {			var glow:GlowFilter = new GlowFilter(color,                                  alpha,                                  blur,                                  blur,                                  strength);						var myFilters:Array = obj.filters;			if (!myFilters)				myFilters = [glow];			else			    myFilters.push(glow);            			obj.filters = myFilters;		}						//sorts an array or associative array and returns a new, sorted array.		public static function sortArrayOn(arrayToSort:Object, fieldName:String):Array {			var tempAr:Array = [];			for (var i in arrayToSort) 				tempAr.push(arrayToSort[i]);			var resul = tempAr.sortOn(fieldName, Array.CASEINSENSITIVE);			return resul;		}    }}