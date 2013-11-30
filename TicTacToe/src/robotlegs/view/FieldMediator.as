package robotlegs.view
{
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import robotlegs.controller.events.EndGameEvent;
	import robotlegs.controller.events.FieldTurnEvent;
	import robotlegs.controller.events.LoadGameInfoEvent;
	import robotlegs.controller.events.LoadGraphicsEvent;
	import robotlegs.controller.events.LoadImageEvent;
	import robotlegs.model.FieldConteiner;
	import robotlegs.model.ImageVO;
	import robotlegs.model.TurnVO;
	
	public class FieldMediator extends Mediator
	{
		
		[Inject]
		public var view: FieldView;
		
		[Inject]
		public var model: FieldConteiner;
		
		public function FieldMediator()
		{
			super();
		}

		
		override public function onRegister ():void
		{
			addViewListener(MouseEvent.CLICK, onClick);
			eventMap.mapListener(eventDispatcher, LoadGraphicsEvent.LOAD_GRAPHICS_SUCCES, loadImages);
			eventMap.mapListener(eventDispatcher, LoadImageEvent.LOAD_IMAGE_SUCCES, loadImageResult);
			eventMap.mapListener(eventDispatcher, LoadImageEvent.LOAD_ALL_IMAGES_SUCCES, allImagesLoading);
			eventMap.mapListener(eventDispatcher, LoadGameInfoEvent.LOAD_GAME_INFO_SUCCES, loadGame);FieldTurnEvent.SHOW_TURN
			eventMap.mapListener(eventDispatcher, FieldTurnEvent.SHOW_TURN, showTurn);
			eventMap.mapListener(eventDispatcher, EndGameEvent.CLEAR_FIELD, clearView);
		}
		protected function loadImages(event: LoadGraphicsEvent): void
		{
			model.graphics(event.graphicsXML);
			loadImage();
		}
		
		protected function loadImage(event: LoadImageEvent = null): void
		{
			var nextImage: ImageVO = model.loadNextImage();
			
			if(nextImage)
			{
				dispatch(new LoadImageEvent(LoadImageEvent.LOAD_IMAGE, nextImage));
			}
			else
			{
				dispatch(new LoadImageEvent(LoadImageEvent.LOAD_ALL_IMAGES_SUCCES));
			}
		}
		
		protected function loadImageResult(event: LoadImageEvent): void
		{
			model.currentImageBm(event.image)
			loadImage();
		}
		protected function allImagesLoading (event: LoadImageEvent):void
		{
			view.addField(model.getImageByName(FieldConteiner.FIELD_IMAGE_NAME));
			view.addZero(model.getImageByName(FieldConteiner.ZERO_IMAGE_NAME));
			view.addCross(model.getImageByName(FieldConteiner.CROSS_IMAGE_NAME));
			
			dispatch(new LoadGameInfoEvent(LoadGameInfoEvent.LOAD_GAME_INFO));
		}
		
		protected function onClick (event:MouseEvent):void
		{
			var cell_X: int = int(event.localX / (view.fieldH / 3));
			var cell_Y: int = int(event.localY / (view.fieldH / 3));
			var turn: TurnVO = new TurnVO(FieldConteiner.USER_ID, cell_X, cell_Y)
			if(	model.isTurnPossible(turn))
			{
				dispatch(new FieldTurnEvent(FieldTurnEvent.MADE_TURN, turn));
			}
			
		}
		protected function loadGame (event:LoadGameInfoEvent):void 
		{
			model.fieldArray = event.gameAr;
			view.startGame(model.fieldArray);
		}
		
		protected function showTurn (event: FieldTurnEvent):void 
		{
			view.showTurn(event.turn);
		}
		protected function clearView (event: EndGameEvent):void 
		{
			view.clearView();
		}
	}
}