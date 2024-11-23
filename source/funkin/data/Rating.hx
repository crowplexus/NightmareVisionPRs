package funkin.data;

import funkin.objects.Note;

class Rating
{
	public static function judgeNote(note:Note, diff:Float = 0):Rating // die
	{
        var data = PlayState.instance.ratingsData;
		switch (note.noteType) { // custom notetypes get custom ways of being judged
			//case "mine": // example case, replace if needed
			default:
				// hey NVE devs, i think you could call noteScript.executeFunc("onJudgeNote", [diff]) here
				// just in case other notetypes need to change how they are judged
				// up to you, though @crowplexus
				for(i in 0...data.length-1)
					if (diff <= data[i].hitWindow)
						return data[i];
		}
		return data[data.length - 1];
	}

	/**
	 * Same as `Rating.judgeNote` but only judges a window of time
	 *
	 * e.g: try 22.5 to get an Epic
	**/
	public static function judgeTime(time:Float = 0):Rating
	{
        var data = PlayState.instance.ratingsData;
		for(i in 0...data.length-1)
			if (time <= data[i].hitWindow)
				return data[i];
		return data[data.length - 1];
	}

	public var name:String = '';
	public var image:String = '';
	public var counter:String = '';
	public var hitWindow:Null<Float> = 0; //ms
	public var ratingMod:Float = 1;
	public var score:Int = 350;
	public var noteSplash:Bool = true;

	public function new(name:String)
	{
		this.name = name;
		this.image = name;
		this.counter = name + 's';
		this.hitWindow = Reflect.field(ClientPrefs, name + 'Window');
		if(hitWindow == null)
			hitWindow = 0;
	}

	public function increase(blah:Int = 1)
	{
		Reflect.setField(PlayState.instance, counter, Reflect.field(PlayState.instance, counter) + blah);
	}
}