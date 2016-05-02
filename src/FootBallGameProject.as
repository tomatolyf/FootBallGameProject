package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	[SWF(width=800, height=454, frameRate=24,backgroundColor=0x000000)]
	public class FootBallGameProject extends Sprite
	{
		private const START_POINT : Point = new Point(246,55);
		private const END_POINT : Point = new Point(602,444);
		
		private var _mainUI : Sprite;
		private var _footBall : Sprite;
		private var _pathMC : Sprite;
		
		
		public function FootBallGameProject()
		{
			initUI();
			initPanel();
			initEvent();
			_mainUI["mcStartPanel"].visible = true;
			_mainUI["mcResultPanel"].visible = false;
		}
		
		private function initUI():void
		{
			_mainUI = new UI_FootBallMain();
			this.addChild(_mainUI);
			_footBall = _mainUI["mcFootBall"];
			_pathMC = _mainUI["mcPath"];
		}
		
		private function initPanel():void
		{
			_footBall.x = START_POINT.x;
			_footBall.y = START_POINT.y;
			_footBall.mouseChildren = false;
			_footBall.buttonMode = true;
		}
		
		private function initEvent():void
		{
			_mainUI["mcStartPanel"]["btnStart"].addEventListener(MouseEvent.CLICK,onStartClick);
			_mainUI["mcResultPanel"]["btnReplay"].addEventListener(MouseEvent.CLICK,onReplayClick);
			_footBall.addEventListener(MouseEvent.MOUSE_DOWN,onBallDown);
		}
		
		private function onStartClick(e : MouseEvent):void
		{
			_mainUI["mcStartPanel"].visible = false;
			initPanel();
		}
		
		private function onReplayClick(e : MouseEvent):void
		{
			_mainUI["mcStartPanel"].visible = true;
			_mainUI["mcResultPanel"].visible = false;
		}
		
		private function onBallDown(e : MouseEvent):void
		{
			_footBall.startDrag(true);
			_mainUI.addEventListener(MouseEvent.MOUSE_UP,onBallUp);
			_mainUI.addEventListener(Event.ENTER_FRAME,onMoveFrame);
		}
		
		private function onBallUp(e : MouseEvent):void
		{
			_footBall.stopDrag();
			_mainUI.removeEventListener(MouseEvent.MOUSE_UP,onBallUp);
			_mainUI.removeEventListener(Event.ENTER_FRAME,onMoveFrame);
		}
		
		private function onMoveFrame(e : Event):void
		{
			var point : Point = new Point(_footBall.x,_footBall.y);
			if(_pathMC.hitTestPoint(point.x,point.y,true))
			{
				if(Point.distance(END_POINT,point) < 10)
				{
					onBallUp(null);
					showResultPanel(1);
				}
			}else
			{
				onBallUp(null);
				showResultPanel(2);
			}
		}
		
		private function showResultPanel(result : uint):void
		{
			_mainUI["mcResultPanel"].visible = true;
			_mainUI["mcResultPanel"]["mcTitle"].gotoAndStop(result);
		}
		
	}
}