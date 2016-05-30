package;

import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;

import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.BitmapData;

import openfl.Lib.getTimer;
import openfl.Lib;

import openfl.ui.Keyboard;
import openfl.Assets;
import flash.system.System;
import sys.db.Sqlite;
import openfl.display.DisplayObject;

/**
 * ...
 * @author Soshanna Botter
 */
class Main extends Sprite 
{
	var board : Sprite = new Sprite();
	var exitButton:Sprite = new Sprite();
	
	
	public function new() 
	{
		super();
		var exitImage : Bitmap = new Bitmap (Assets.getBitmapData("assets/img/exitbutton.png"));
		var startButton : Bitmap = new Bitmap (Assets.getBitmapData("assets/img/startbutton.png"));
		
		board.addChild(startButton);
		addChild(board);
		startButton.x = 220;
		startButton.y = 300;
		board.addEventListener(MouseEvent.CLICK, startGame);
		
		exitButton.addChild(exitImage);
		board.addChild(exitButton);
		exitButton.x = 465;
		exitButton.y = 300;
		exitButton.addEventListener(MouseEvent.CLICK, exitGame);
	}
	
	public function exitGame (event:MouseEvent)
	{
		System.exit(0);
	}
	
	public function startGame(event:MouseEvent)
	{
		var questionAnswer: Questions = new Questions();
		
		board.removeChildren();
		board.removeEventListener(MouseEvent.CLICK, startGame);
		
		addChild(questionAnswer);
		questionAnswer.startQuestion();
		
	}
} 
