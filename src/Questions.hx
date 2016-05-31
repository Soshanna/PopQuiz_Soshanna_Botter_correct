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

 //score bijhouden in een variable
 class Questions extends Sprite
{
	var score:Int = 0;
	
	var scoreTextField:TextField = null;
	var timerTextField: TextField = null;
	
	var questionNumber: Int = -1;
	var lastTime:Int = 0;
	var timer:Int = 5000;
	
	var questionTextField:TextField = null;
	var textFieldAnswer1: TextField;
	var textFieldAnswer2: TextField;
	var textFieldAnswer3: TextField;
	var textFieldAnswer4: TextField; 
	
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
		
		
		var textFormatRightAligned:TextFormat = new TextFormat("Arial", 24, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.RIGHT);
		var textFormatCenterAligned:TextFormat = new TextFormat("Arial", 24, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.CENTER);
		
		scoreTextField = new TextField();
		scoreTextField.defaultTextFormat = textFormatRightAligned;
		scoreTextField.x = 0;
		scoreTextField.y = 20;
		scoreTextField.width = 50;
		scoreTextField.height = 25;
		scoreTextField.text = "0";
		addChild(scoreTextField);
		
		timerTextField = new TextField();
		timerTextField.defaultTextFormat = textFormatRightAligned;
		timerTextField.x = 700;
		timerTextField.y = 20;
		timerTextField.width = 50;
		timerTextField.height = 25;
		timerTextField.text = Std.string(timer/1000);
		addChild(timerTextField);
		
		questionTextField = new TextField();
		questionTextField.defaultTextFormat = textFormatCenterAligned;
		questionTextField.x = 0;
		questionTextField.y = 100;
		questionTextField.width = 800;
		questionTextField.height = 50;
		addChild(questionTextField);
		
	    textFieldAnswer1 = new TextField();
		textFieldAnswer1.defaultTextFormat = textFormatCenterAligned;
		textFieldAnswer1.x = 140;
		textFieldAnswer1.y = 160;
		textFieldAnswer1.width = 500;
		textFieldAnswer1.height = 50;
		addChild(textFieldAnswer1);
		textFieldAnswer1.addEventListener(MouseEvent.CLICK, answerCorrect);
		
		textFieldAnswer2 = new TextField();
		textFieldAnswer2.defaultTextFormat = textFormatCenterAligned;
		textFieldAnswer2.x = 140;
		textFieldAnswer2.y = 230;
		textFieldAnswer2.width = 500;
		textFieldAnswer2.height = 50;
		addChild(textFieldAnswer2);
		textFieldAnswer2.addEventListener(MouseEvent.CLICK, answerIncorrect);
		
		textFieldAnswer3 = new TextField();
		textFieldAnswer3.defaultTextFormat = textFormatCenterAligned;
		textFieldAnswer3.x = 140;
		textFieldAnswer3.y = 300;
		textFieldAnswer3.width = 500;
		textFieldAnswer3.height = 50;
		addChild(textFieldAnswer3);
		textFieldAnswer3.addEventListener(MouseEvent.CLICK, answerIncorrect);
		
		textFieldAnswer4 = new TextField();
		textFieldAnswer4.defaultTextFormat = textFormatCenterAligned;
		textFieldAnswer4.x = 140;
		textFieldAnswer4.y = 370;
		textFieldAnswer4.width = 500;
		textFieldAnswer4.height = 50;
		addChild(textFieldAnswer4);
		textFieldAnswer4.addEventListener(MouseEvent.CLICK, answerIncorrect);
		
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
		timer = 5000;
		
		questionTextField.text = questions[questionNumber];
		textFieldAnswer1.text = answer1[questionNumber];
		textFieldAnswer2.text = answer2[questionNumber];
		textFieldAnswer3.text = answer3[questionNumber];
		textFieldAnswer4.text = answer4[questionNumber];
		
	}
}