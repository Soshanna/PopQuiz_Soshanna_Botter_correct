package;

import openfl.text.TextFieldType;
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

import sys.db.Sqlite;
import sys.db.Connection;
import sys.db.ResultSet;

/**
 * ...
 * @author Soshanna Botter
 */
class EnterName extends Sprite
{
	var score:Int;
	var player:String = "";
	
	var enterNameTextField:TextField;
	var enterTextField:TextField = null;
	
	public function new(score:Int) 
	{
		super();
		
		this.score = score;
		
		var textFormatCenterAligned:TextFormat = new TextFormat("assets/font/DK Cool Crayon.ttf", 24, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.CENTER);
		
		enterTextField = new TextField();
		enterTextField.defaultTextFormat = textFormatCenterAligned;
		enterTextField.x = 50;
		enterTextField.y = 200;
		enterTextField.width = 800;
		enterTextField.height = 35;
		enterTextField.text = "Please enter your name for the leaderboard and press Enter";
		
		
		enterNameTextField = new TextField();
		enterNameTextField.defaultTextFormat = textFormatCenterAligned;
		enterNameTextField.border = true;
		enterNameTextField.x = 350;
		enterNameTextField.y = 300;
		enterNameTextField.width = 200;
		enterNameTextField.height = 50;
		
		enterNameTextField.type = TextFieldType.INPUT;
		addChild(enterTextField);
		addChild(enterNameTextField);
		addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		
	}
	
	function onKeyDown(event:KeyboardEvent)
	{
		switch (event.keyCode)
		{
			case 13:
				leaderboard();
		}
	}
	
	function leaderboard()
	{
		player = enterNameTextField.text;
		insertToDatabase();
		
		removeChildren();
		
		var leaderboard:Leaderboard = new Leaderboard();
		addChild(leaderboard);
	}
	
	function insertToDatabase()
	{
		var cnx:Connection = Sqlite.open("assets/QuizGameDatabase.db");
		
		cnx.request("INSERT INTO Highscores (name, score) VALUES (\'" + player + "\', " + score + ")");
		
		cnx.close();
		
	}
}