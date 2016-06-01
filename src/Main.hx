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
import openfl.system.System;
import sys.db.Sqlite;
import openfl.display.DisplayObject;

/**
 * ...
 * @author Soshanna Botter
 */

  //name insert at start of game
 //shuffle position of answer textfield
 //ending for game after 10 questions, show highscores
 
class Main extends Sprite 
{
	var board : Sprite = new Sprite();
	var exitButton:Sprite = new Sprite();
	var backgroundImage:Sprite = new Sprite();
	var logo:Sprite = new Sprite();
	
	
	public function new() 
	{
		super();
		var backgroundImage:Bitmap = new Bitmap(Assets.getBitmapData("assets/img/background.png"));
		var exitImage : Bitmap = new Bitmap (Assets.getBitmapData("assets/img/exitbutton.png"));
		var startButton : Bitmap = new Bitmap (Assets.getBitmapData("assets/img/startbutton.png"));
		var logo : Bitmap = new Bitmap (Assets.getBitmapData("assets/img/logo.png"));
		
		board.addChild(backgroundImage);
		addChild(board);
		backgroundImage.x = -750;
		backgroundImage.y = -600;
		
		board.addChild(logo);
		addChild(board);
		logo.x = 300;
		logo.y = 50;
		
		board.addChild(startButton);
		addChild(board);
		startButton.x = 150;
		startButton.y = 390;
		board.addEventListener(MouseEvent.CLICK, startGame);
		
		exitButton.addChild(exitImage);
		board.addChild(exitButton);
		exitButton.x = 530;
		exitButton.y = 390;
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
