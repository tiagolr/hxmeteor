##Hxmeteor-template

This template provides a base for building projects using haxe-meteor.

Features:

* **Iron Router** for routing.

* **Bootstrap** installed without meteorite package, which allows to override css rules.

* **File Structure** for haxe-meteor applications of any size:

```
├───src                 ;; haxe source code
│   ├───client          ;; client-only code  
│   │   └───templates   ;; template controllers
│   ├───server          ;; server-only code
│   └───shared          ;; client and server code
│       └───model       ;; collections
└───www                 ;; meteor app
    ├───.meteor
    ├───client
    │   ├───lib         ;; 3rd party libraries
    │   │   ├───css
    │   │   └───js
    │   ├───styles      ;; css files
    │   └───templates   ;; template files
    ├───public          ;; static files
    │   ├───fonts
    │   └───img
    └───server          ;; app server files
```

-----
Pull Requests and improvements are welcome.

#####Build and Run:
```
haxe build.hxml
cd www
meteor
```
