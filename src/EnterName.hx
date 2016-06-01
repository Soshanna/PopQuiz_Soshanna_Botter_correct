package;

import openfl.display.Sprite;

import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;

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

	public function new(score:Int) 
	{
		super();
		
		this.score = score;
		
		var textFormatCenterAligned:TextFormat = new TextFormat("assets/font/DK Cool Crayon.ttf", 24, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.CENTER);
		
		enterNameTextField = new TextField();
		enterNameTextField.defaultTextFormat = textFormatCenterAligned;
		
		enterNameTextField.type = TextFieldType.INPUT;
		addChild(enterNameTextField);
		addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		
	}
	
	function onKeyDown(event:KeyboardEvent)
	{
		trace(event.keyCode);
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