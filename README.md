Worker from Class
=================

Allows you to start specific class in background worker from anywhere in your code (using Claus Wahlers' excellent [as3swf library](https://github.com/claus/as3swf) to patch SWF main class).

Prerequisites:
- clone worker-from-class and update as3swf submodule
- download the 11.4 playerglobal.swc (available at the [Adobe site](http://www.adobe.com/support/flashplayer/downloads.html))
- add the 11.4 playerglobal.swc to the build path
- set the compiler options -swf-version=17 and -target-player=11.4

Usage:
```actionscript3
var worker:Worker = WorkerFactory.getWorkerFromClass(MyWorker, loaderInfo.bytes);
worker.start();
```
