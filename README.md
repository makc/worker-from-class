Worker from Class
=================

Allows you to create ActionScript Workers from specific classes (using Claus Wahlers' excellent [as3swf library](https://github.com/claus/as3swf) to patch SWF main class).

Prerequisites:
- download worker-from-class and as3swf submodule
- download the 11.4 playerglobal.swc (available at the [Adobe labs](http://labs.adobe.com/downloads/flashplayer11-4.html))
- add the 11.4 playerglobal.swc to the build path
- set the compiler options -swf-version=17 and -target-player=11.4

Usage:
- use WorkerFactory.getWorkerFromClass(ClassReference, swfByteArray) to create a new Worker based on the ClassReference. The swfByteArray must be a valid SWF file ByteArray (e.g. loaderInfo.bytes)
