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
	
	var answerTexts:Array<String> = new Array<String>();
	
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
		answer1TextField.x = 330;
		answer1TextField.y = 190;
		answer1TextField.width = 250;
		answer1TextField.height = 50;
		//answer1TextField.text = "0";
		addChild(answer1TextField);
		answer1TextField.addEventListener(MouseEvent.CLICK, checkAnswer1);
		
		answer2TextField = new TextField();
		answer2TextField.defaultTextFormat = textFormatCenterAligned;
		answer2TextField.x = 330;
		answer2TextField.y = 280;
		answer2TextField.width = 250;
		answer2TextField.height = 50;
		//answer2TextField.text = "0";
		addChild(answer2TextField);
		answer2TextField.addEventListener(MouseEvent.CLICK, checkAnswer2);
		
		answer3TextField = new TextField();
		answer3TextField.defaultTextFormat = textFormatCenterAligned;
		answer3TextField.x = 330;
		answer3TextField.y = 370;
		answer3TextField.width = 250;
		answer3TextField.height = 50;
		//answer3TextField.text = "0";
		addChild(answer3TextField);
		answer3TextField.addEventListener(MouseEvent.CLICK, checkAnswer3);
		
		answer4TextField = new TextField();
		answer4TextField.defaultTextFormat = textFormatCenterAligned;
		answer4TextField.x = 330;
		answer4TextField.y = 460;
		answer4TextField.width = 250;
		answer4TextField.height = 50;
		//answer4TextField.text = "0";
		addChild(answer4TextField);
		answer4TextField.addEventListener(MouseEvent.CLICK, checkAnswer4);
		
		requestQuestions();
		startQuestion();
		
		lastTime = getTimer();
		
		addEventListener(Event.ENTER_FRAME, startTimer);
		
	}
	
	function shuffleAnswers()
	{
		for (i in 0...4)
		{
			var change:Int = i + Math.floor(Math.random() * (4 - i));
			var tempAnswer = answerTexts[i];
			answerTexts[i] = answerTexts[change];
			answerTexts[change] = tempAnswer;
		}
	}
	
	function checkAnswer1(event:MouseEvent)
	{
		if (answer1TextField.text == answer1[questionNumber]) 
		{
			answerCorrect();
			
		}
		else 
		{
			answerIncorrect();
		}
	}
	
	function checkAnswer2(event:MouseEvent)
	{
		if (answer2TextField.text == answer1[questionNumber]) 
		{
			answerCorrect();
			
		}
		else 
		{
			answerIncorrect();
		}
	}
	
	function checkAnswer3(event:MouseEvent)
	{
		if (answer3TextField.text == answer1[questionNumber]) 
		{
			answerCorrect();
			
		}
		else 
		{
			answerIncorrect();
		}
	}
	
	function checkAnswer4(event:MouseEvent)
	{
		if (answer4TextField.text == answer1[questionNumber]) 
		{
			answerCorrect();
			
		}
		else 
		{
			answerIncorrect();
		}
	}
	
	
	function answerCorrect()
	{
		trace("correct");
		score = score + 1;
		scoreTextField.text = Std.string(score);
		startQuestion();
		
	}
	
	function answerIncorrect()
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
		
		var resultSet = cnx.request("SELECT question, answer1, answer2, answer3, answer4 FROM Questions ORDER BY RANDOM() LIMIT 20;");
		
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
		
		answerTexts.push(answer1[questionNumber]);
		answerTexts.push(answer2[questionNumber]);
		answerTexts.push(answer3[questionNumber]);
		answerTexts.push(answer4[questionNumber]);
		
		shuffleAnswers();
		
		questionTextField.text = questions[questionNumber];
		answer1TextField.text = answerTexts[0];
		answer2TextField.text = answerTexts[1];
		answer3TextField.text = answerTexts[2];
		answer4TextField.text = answerTexts[3];
		
		answerTexts = new Array<String>();
		
		
		
		
		
		if (questionNumber == 11)
		{
			endGame();
		}
		
		
	}
	
	function endGame()
	{
		removeChild(scoreTextField);
		removeChild(timerTextField);
		removeChild(questionTextField);
		removeChild(answer1TextField);
		removeChild(answer2TextField);
		removeChild(answer3TextField);
		removeChild(answer4TextField);
		//var highScore:Leaderboard = new Leaderboard();
		//highScore.Leaderboard();
	}
	

}