﻿/*** *	Example Resolume Flash communication DocumentClass* **/	package{	import flash.display.MovieClip;		import flash.events.MouseEvent;		import flash.text.TextFormat;	import flash.utils.*;	import flash.events.TimerEvent;	import fl.transitions.*;	import fl.transitions.easing.*;			import fl.motion.Color;	import flash.display.Sprite;	//import the Resolume communication classes	//make sure you have added the source path to these files in the ActionScript 3 Preferences of Flash	import resolumeCom.*;	import resolumeCom.parameters.*;	import resolumeCom.events.*;	public class ApplauseSign extends MovieClip	{		private const SIGN_MARGIN_RIGHT:Number = 50;		private const SIGN_MARGIN_LEFT:Number = 60;		private const SIGN_MARGIN_TOP:Number = 5;		private const SIGN_MARGIN_BOTTOM:Number = 10;		private var SIGN_MAX_WIDTH:Number = 620 - SIGN_MARGIN_LEFT - SIGN_MARGIN_RIGHT;				private var duration:Number = 400;						//this is needed to store references to currently running Tweens so they don't get garbage collected in the middle! Flash is stupid.		private static var tweens:Dictionary = new Dictionary(false); //need strong references since that's the whole point of this!!!				private var textCover:Sprite;						private var frameIdx:Number = 0;		/*		//create the resolume object that will do all the hard work for you		private var resolume:Resolume = new Resolume();				//create as many different parameters as you like		private var paramScaleX:FloatParameter = resolume.addFloatParameter("Scale X", 0.5);		private var paramScaleY:FloatParameter = resolume.addFloatParameter("Scale Y", 0.5);		private var paramMaxWidth:FloatParameter = resolume.addFloatParameter("Max Sign Width", 0.0);		private var paramFooter:StringParameter = resolume.addStringParameter("Footer", "VJ BOB");		private var paramShowBackground:BooleanParameter = resolume.addBooleanParameter("Background", true);		private var paramShowSurprise:EventParameter = resolume.addEventParameter("Surprise!");				*/								//draws a rectangle to cover the given objToCover and returns that sprite.			public function ApplauseSign():void		{			//set callback, this will notify us when a parameter has changed			//resolume.addParameterListener(parameterChanged);						var that = this;						/*			textCover = FlashUtils.drawRectOver(that.footer, 0xEDEDBE, 1);			addChild(textCover);			setChildIndex(textCover, numChildren - 1);			*/						/*			var amount = 10;			var colorTransformer:Color = new Color();						colorTransformer.brightness = amount;						// Apply the changes to the display object.			that.footer.transform.colorTransform = colorTransformer;			*/									this.addEventListener(MouseEvent.CLICK, 				function (e:MouseEvent):void{						trace("click: ");								that.footer.text = that.footer.text + "B";										resizeBox();				});									//start			var steps = 23; //should be 20, but go over since flash doesn't know how to add.			var interval = (duration * 100) / steps;						var timer:Timer = new Timer(duration, 0); 			timer.addEventListener(TimerEvent.TIMER, function (e:TimerEvent) {							frameIdx++;								if (frameIdx > 2) {					frameIdx = 0;										that.footer.visible = true;				}				else if (frameIdx == 2) {					that.footer.visible = false;				}				//that.footer.visible = !that.footer.visible;								/*																			var obj = that.textCover;				obj.alpha = 1;								var origAlpha = obj.alpha;trace("timer" + obj.alpha);				var tw = new Tween(obj, "alpha", Strong.easeOut, origAlpha, 0.0, (duration / 1000) / 2.0, true);								//save the reference so it doesn't get deleted by the GC before it's finished!				tweens[tw] = tw;								tw.addEventListener(TweenEvent.MOTION_FINISH, function (e:TweenEvent) {					//e.target.obj.visible = false;					//e.target.obj.alpha = origAlpha;  trace("tween over" + obj.alpha);					//okay, we're finally done. NOW you can delete the reference and be GC'd.					delete tweens[tw];				});								tw.start();				*/			});						timer.start();												resizeBox();		}						public function resizeBox():void {			var textW:Number = this.footer.getLineMetrics(0).width;						//trace("txt: " + this.footer.text + ' = ' + textW);						//resize text if too big			while (textW > SIGN_MAX_WIDTH) {				var format:TextFormat = this.footer.getTextFormat();								if (!format.size)					format.size = 20;				else if (format.size < 9)					break;				else					format.size = Number(format.size) - 1;								this.footer.setTextFormat(format);				textW = this.footer.getLineMetrics(0).width;			}						this.theSignBG.width = textW + SIGN_MARGIN_LEFT + SIGN_MARGIN_RIGHT;			this.theSignBG.height = this.footer.getLineMetrics(0).height + SIGN_MARGIN_TOP + SIGN_MARGIN_BOTTOM;			this.theSignBG.y = this.footer.y - SIGN_MARGIN_TOP;						var strokeSize = 8;						/*			textCover.width = this.theSignBG.width - strokeSize * 2;			textCover.height = this.theSignBG.height - strokeSize * 2;			textCover.y = this.theSignBG.y + strokeSize;			textCover.x = this.theSignBG.x + strokeSize;			*/		}						//fades out the given object using alpha.		//when it is finished, it hides the object and returns it to its original alpha		public static function fadeOut(obj, duration:Number = 0.5) {			var origAlpha = obj.alpha;			var tw = new Tween(obj, "alpha", Strong.easeOut, origAlpha, 0.0, duration, true);						//save the reference so it doesn't get deleted by the GC before it's finished!			tweens[tw] = tw;						tw.addEventListener(TweenEvent.MOTION_FINISH, function (e:TweenEvent) {				e.target.obj.visible = false;				e.target.obj.alpha = origAlpha;  								//okay, we're finally done. NOW you can delete the reference and be GC'd.				delete tweens[tw];			});						tw.start();		}				private function onTweenEnd(e:TweenEvent) {								//okay, we're finally done. NOW you can delete the reference and be GC'd.				//delete tweens[tw];			}				//this method will be called everytime you change a paramater in Resolume		public function parameterChanged(event:ChangeEvent): void		{/*			if (event.object == this.paramFooter)			{				that.footer.text = paramFooter.getValue();;									resizeBox();			}*/ 			return;									/*			//check to see what paramater was changed			if (event.object == this.paramScaleX)			{				//here you can do whatever you like with the value of the parameter				this.logo.scaleX = this.paramScaleX.getValue() * 2.0;			}			else if (event.object == this.paramScaleY)			{				this.logo.scaleY = this.paramScaleY.getValue() * 2.0;			}			else if (event.object == this.paramMaxWidth)			{				this.logo.rotation = this.paramMaxWidth.getValue() * 360.0;			}			else if (event.object == this.paramFooter)			{				this.footer.text = this.paramFooter.getValue();			}			else if (event.object == this.paramShowBackground)			{				this.background.visible = this.paramShowBackground.getValue();			}			else if (event.object == this.paramShowSurprise)			{				if (this.paramShowSurprise.getValue())					this.surprise.gotoAndPlay(2);			}			else			{				trace(event.object);			}						*/		}	}}