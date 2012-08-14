package
{
	import com.codeazur.as3swf.SWF;
	import com.codeazur.as3swf.data.SWFSymbol;
	import com.codeazur.as3swf.tags.ITag;
	import com.codeazur.as3swf.tags.TagDoABC;
	import com.codeazur.as3swf.tags.TagEnableDebugger2;
	import com.codeazur.as3swf.tags.TagEnd;
	import com.codeazur.as3swf.tags.TagFileAttributes;
	import com.codeazur.as3swf.tags.TagShowFrame;
	import com.codeazur.as3swf.tags.TagSymbolClass;
	//import flash.net.FileReference;
	
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
		 * @param debug set to tru if you want to debug the Worker
		 * @param domain the WorkerDomain to create the Worker in
		 * @return the new Worker
		 */
		public static function getWorkerFromClass(clazz:Class, bytes:ByteArray, debug:Boolean = true, domain:WorkerDomain = null):Worker
		{
			var swf:SWF = new SWF(bytes);
			var tags:Vector.<ITag> = swf.tags;
			var className:String = getQualifiedClassName(clazz).replace(/::/g, "."); 
			var patched:Boolean;
			
			var i:int = -1;
			while (i++ < tags.length) {
				if (tags[i] is TagShowFrame) break;
			}
			while (i-- > 0) {
				if (tags[i] is TagSymbolClass) {
					var symbolTag:TagSymbolClass = tags[i] as TagSymbolClass;
					var symbol:SWFSymbol = symbolTag.symbols[0];
					symbolTag.symbols[0] = SWFSymbol.create(symbol.tagId, className);
					patched = true;
				}
			}
			
			// TODO reimplement debug parameter
			
			if (patched) {
				var swfBytes:ByteArray = new ByteArray();
				swf.publish(swfBytes);
				swfBytes.position = 0;
				
				//new FileReference ().save(swfBytes, "1.swf");
				
				if (!domain)
					domain = WorkerDomain.current;
				
				return domain.createWorker(swfBytes);	
			}
			
			return null;
		}
	}
}