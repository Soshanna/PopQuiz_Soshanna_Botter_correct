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

 
 class Questions extends Sprite
{
	var score:Int = 0;
	var questionNumber: Int = -1;
	var lastTime:Int = 0;
	var timer:Int = 7000;
	
	var scoreTextField:TextField = null;
	var timerTextField: TextField = null;
	var questionTextField:TextField = null;
	var answer1TextField: TextField;
	var answer2TextField: TextField;
	var answer3TextField: TextField;
	var answer4TextField: TextField; 
	
	var questions: Array <String> = new Array<String>();
	var answer1: Array <String> = new Array<String>();
	var answer2: Array <String> = new Array<String>();
	var answer3: Array <String> = new Array<String>();
	var answer4: Array <String> = new Array<String>();
	
	public function new() 
	{
		super(); 
		
		var backgroundImage:Sprite = new Sprite();	
		var backgroundImage:Bitmap = new Bitmap(Assets.getBitmapData("assets/img/background.png"));
		var board : Sprite = new Sprite();
		board.addChild(backgroundImage);
		addChild(board);
		backgroundImage.x = -750;
		backgroundImage.y = -600;
		
		var textFormatRightAligned:TextFormat = new TextFormat("assets/font/DK Cool Crayon.ttf", 35, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.RIGHT);
		var textFormatCenterAligned:TextFormat = new TextFormat("assets/font/DK Cool Crayon.ttf", 24, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.CENTER);
		
		scoreTextField = new TextField();
		scoreTextField.defaultTextFormat = textFormatRightAligned;
		scoreTextField.x = 0;
		scoreTextField.y = 20;
		scoreTextField.width = 50;
		scoreTextField.height = 35;
		scoreTextField.text = "0";
		addChild(scoreTextField);
		
		timerTextField = new TextField();
		timerTextField.defaultTextFormat = textFormatRightAligned;
		timerTextField.x = 800;
		timerTextField.y = 20;
		timerTextField.width = 50;
		timerTextField.height = 35;
		timerTextField.text = Std.string(timer/1000);
		addChild(timerTextField);
		
		questionTextField = new TextField();
		questionTextField.defaultTextFormat = textFormatCenterAligned;
		questionTextField.x = 0;
		questionTextField.y = 100;
		questionTextField.width = 900;
		questionTextField.height = 50;
		addChild(questionTextField);
		
	    answer1TextField = new TextField();
		answer1TextField.defaultTextFormat = textFormatCenterAligned;
		answer1TextField.x = 350;
		answer1TextField.y = 190;
		answer1TextField.width = 200;
		answer1TextField.height = 50;
		addChild(answer1TextField);
		answer1TextField.addEventListener(MouseEvent.CLICK, answerCorrect);
		
		answer2TextField = new TextField();
		answer2TextField.defaultTextFormat = textFormatCenterAligned;
		answer2TextField.x = 350;
		answer2TextField.y = 280;
		answer2TextField.width = 200;
		answer2TextField.height = 50;
		addChild(answer2TextField);
		answer2TextField.addEventListener(MouseEvent.CLICK, answerIncorrect);
		
		answer3TextField = new TextField();
		answer3TextField.defaultTextFormat = textFormatCenterAligned;
		answer3TextField.x = 350;
		answer3TextField.y = 370;
		answer3TextField.width = 200;
		answer3TextField.height = 50;
		addChild(answer3TextField);
		answer3TextField.addEventListener(MouseEvent.CLICK, answerIncorrect);
		
		answer4TextField = new TextField();
		answer4TextField.defaultTextFormat = textFormatCenterAligned;
		answer4TextField.x = 350;
		answer4TextField.y = 460;
		answer4TextField.width = 200;
		answer4TextField.height = 50;
		addChild(answer4TextField);
		answer4TextField.addEventListener(MouseEvent.CLICK, answerIncorrect);
		
		requestQuestions();
		startQuestion();
		
		lastTime = getTimer();
		
		addEventListener(Event.ENTER_FRAME, startTimer);
		
	}
	
	function answerCorrect(event:MouseEvent) 
	{
		trace("correct");
		score = score + 1;
		scoreTextField.text = Std.string(score);
		startQuestion();
		
	}
	
	function answerIncorrect(event:MouseEvent) 
	{
		trace("incorrect");
		startQuestion();
	}
	
	public function startTimer(event:KeyboardEvent)
	{
		var currentTime:Int = getTimer();
		var elapsedTime:Int = currentTime - lastTime;
		lastTime = currentTime;
		
		timer = timer - elapsedTime;
		
		if (timer <= 0)
		{
			startQuestion();
		}
		
		timerTextField.text = Std.string(Math.ceil(timer / 1000));
	}
	
	public function requestQuestions()
	{
		var cnx = Sqlite.open("assets/QuizGameDatabase.db");
		
		var resultSet = cnx.request("SELECT question, answer1, answer2, answer3, answer4 FROM Questions ORDER BY RANDOM() LIMIT 11;");
		
		for ( row in resultSet)
		{
			questions.push(row.question);
			answer1.push(row.answer1);
			answer2.push(row.answer2);
			answer3.push(row.answer3);
			answer4.push(row.answer4);
		}
	}
	
	public function startQuestion()
	{
		questionNumber += 1;
		timer = 7000;
		
		questionTextField.text = questions[questionNumber];
		answer1TextField.text = answer1[questionNumber];
		answer2TextField.text = answer2[questionNumber];
		answer3TextField.text = answer3[questionNumber];
		answer4TextField.text = answer4[questionNumber];
		
	}
	

}