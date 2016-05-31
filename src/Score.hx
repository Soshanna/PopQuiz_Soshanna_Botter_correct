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
class Score extends Sprite
{
	var score:Int = 0;
	var scoreTextField:TextField = null;
	
	public function new() 
	{
		super();
		
		scoreTextField = new TextField();
		scoreTextField.defaultTextFormat = textFormatRightAligned;
		scoreTextField.x = 20;
		scoreTextField.y = 20;
		scoreTextField.width = 50;
		scoreTextField.height = 25;
		scoreTextField.text = "0";
		addChild(scoreTextField);
	}
	
}