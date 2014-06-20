Worker from Class
=================

Allows you to start specific class in background worker from anywhere in your code (using Claus Wahlers' excellent [as3swf library](https://github.com/claus/as3swf) to patch SWF main class).

Prerequisites:
- clone worker-from-class and update as3swf submodule
- set the compiler options -swf-version=17 and -target-player=11.4 or later

Usage:
```actionscript3
var worker:Worker = WorkerFactory.getWorkerFromClass(MyWorker, loaderInfo.bytes);
worker.start();
```

<span class="octicon octicon-beer"></span>
