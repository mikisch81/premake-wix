# premake-wix

Premake extension to support [WIX](http://http://wixtoolset.org/) project files on Visual Studio

### Usage ###

Simply add:
```lua
language "wix"
```
to an external project of "None" kind.

### Example ###

The contents of your premake5.lua file would be:

```lua
solution "MySolution"
    configurations { "release", "debug" }

    externalproject "MyWixProject"
		uuid "383c1488-c78a-4268-b045-c22f679c69d1"
		kind "None"
		language "wix"
```