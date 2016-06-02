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

import sys.db.Sqlite;
import sys.db.Connection;
import sys.db.ResultSet;

/**
 * ...
 * @author Soshanna Botter
 */
class Leaderboard extends Sprite 
{
	var playerNames:Array<String> = new Array<String>();
	var playerScores:Array<String> = new Array<String>();
	
	var playerTextFields:Array<TextField> = new Array<TextField>();
	
	var leaderboardTextField:TextField = null;

	var exitButton:Sprite = new Sprite();



	public function new() 
	{
		super();
		
		var textFormatCenterAligned:TextFormat = new TextFormat("assets/font/DK Cool Crayon.ttf", 24, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.CENTER);
		
		leaderboardTextField = new TextField();
		leaderboardTextField.defaultTextFormat = textFormatCenterAligned;
		leaderboardTextField.x = 50;
		leaderboardTextField.y = 50;
		leaderboardTextField.width = 800;
		leaderboardTextField.height = 35;
		leaderboardTextField.text = "LEADERBOARD";
		addChild(leaderboardTextField);
		
		var exitImage : Bitmap = new Bitmap (Assets.getBitmapData("assets/img/exitbutton.png"));
		exitButton.addChild(exitImage);
		addChild(exitButton);
		exitButton.x = 650;
		exitButton.y = 435;
		exitButton.addEventListener(MouseEvent.CLICK, exitGame);
		
		requestPlayers();
		
		for (i in 0 ... playerNames.length)
		{
			playerTextFields[i] = new TextField();
			
			playerTextFields[i].defaultTextFormat = textFormatCenterAligned;
			
			playerTextFields[i].y = 130 + i * 40;
			
			playerTextFields[i].x = 200;
			
			playerTextFields[i].width = 500;
			
			playerTextFields[i].text = "Name: " + playerNames[i] + " - " + "Score: " + playerScores[i];
			
			addChild(playerTextFields[i]);
		}
	}
	
	public function requestPlayers()
	{
		var cnx = Sqlite.open("assets/QuizGameDatabase.db");
		
		var resultSet = cnx.request("SELECT name, score FROM Highscores ORDER BY score DESC LIMIT 10;");
		
		for ( row in resultSet)
		{
			playerNames.push(row.name);
			playerScores.push(row.score);
		}
	}
	
	
	public function exitGame (event:MouseEvent)
	{
		System.exit(0);
	}
	
}