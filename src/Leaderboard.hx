package;

import openfl.display.Sprite;

import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.text.TextField;

import sys.db.Sqlite;
import sys.db.Connection;
import sys.db.ResultSet;

/**
 * ...
 * @author Soshanna Botter
 */
class Leaderboard extends Sprite 
{
	//var name:String=insert name
	//var score:Int=score
	//var time:Int=time taken
	
	var playerNames:Array<String> = new Array<String>();
	var playerScores:Array<String> = new Array<String>();
	
	var playerTextFields:Array<TextField> = new Array<TextField>();

	public function new() 
	{
		super();
		
		var textFormatCenterAligned:TextFormat = new TextFormat("assets/font/DK Cool Crayon.ttf", 24, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.CENTER);
		
		requestPlayers();
		
		for (i in 0 ... playerNames.length)
		{
			playerTextFields[i] = new TextField();
			playerTextFields[i].defaultTextFormat = textFormatCenterAligned;
			
			playerTextFields[i].y = 100 + i * 40;
			
			
			playerTextFields[i].text = playerNames[i] + " - " + playerScores[i];
			
			addChild(playerTextFields[i]);
		}
		
		
	}
	
	public function requestPlayers()
	{
		var cnx = Sqlite.open("assets/QuizGameDatabase.db");
		
		var resultSet = cnx.request("SELECT name, score FROM Highscores ORDER BY score DESC");
		
		for ( row in resultSet)
		{
			playerNames.push(row.name);
			playerScores.push(row.score);
		}
	}
	
}