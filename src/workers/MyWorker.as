package workers
{
	import flash.display.Sprite;
	import flash.system.Worker;
	import other.MyClass;
	
	public class MyWorker extends Sprite
	{
		public function MyWorker()
		{
			super();
			trace("Hello from the Worker!");
			trace("isPrimordial: " + Worker.current.isPrimordial)
			
			var life:MyClass = new MyClass;
			trace("Meaning of life is: " + life.meaning);
		}
	}
}