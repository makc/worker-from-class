package
{
	import com.codeazur.as3swf.SWF;
	import com.codeazur.as3swf.data.SWFSymbol;
	import com.codeazur.as3swf.tags.ITag;
	import com.codeazur.as3swf.tags.TagSymbolClass;
	
	import flash.system.Worker;
	import flash.system.WorkerDomain;
	import flash.utils.ByteArray;
	
	import avmplus.getQualifiedClassName;

	public class WorkerFactory
	{
		
		/**
		 * Creates a Worker from a Class.
		 * @param clazz the Class to create a Worker from
		 * @param bytes SWF ByteArray which must contain the Class definition (usually loaderInfo.bytes)
		 * @param domain the WorkerDomain to create the Worker in
		 * @return the new Worker
		 */
		public static function getWorkerFromClass(clazz:Class, bytes:ByteArray, domain:WorkerDomain = null):Worker
		{
			var i:int;
			var swf:SWF = new SWF(bytes);
			var tags:Vector.<ITag> = swf.tags;
			var className:String = getQualifiedClassName(clazz).replace(/::/g, "."); 
			
			for (i = 0; i < tags.length; i++)
			{
				if (tags[i] is TagSymbolClass)
				{
					for each (var symbol:SWFSymbol in (tags[i] as TagSymbolClass).symbols)
					{
						if (symbol.tagId == 0)
						{
							symbol.name = className;

							var swfBytes:ByteArray = new ByteArray();
							swf.publish(swfBytes);
							swfBytes.position = 0;
							
							if (domain == null)
							{
								domain = WorkerDomain.current;
							}
							
							return domain.createWorker(swfBytes);	
						}
					}
				}
			}
			
			return null;
		}
	}
}