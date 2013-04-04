This is a rudimentary Julia version of a subset of
[configurator](https://www.github.com/bos/configurator).

The main difference is the way string interpolation works so:

* values, defined above in the config-file, should be accessable through `cfg` eg

    a = 1
    b = cfg["a"] + 2

* there is function interpolation eg `a = reverse("abc")` 

Besides that, there is currently no reloading of configuration-files: so it is
a sole reader.

Already implemented features
----------------------------

* rudimentary file-reading
* `import` statements
* expression interpolation

ToDo
----

* more flexible syetax 

Example
-------

    uno  = 1
    dos  = 2
    tres = cfg["uno"] + 2
    ll   = [1,2,3]
    bb   = reverse("abc")
    tres {
       a = "da"
       b = "di"
       quadro {
       	  c = "do"
    	  d = "la"
       }
    x {
       import "test2.cfg"
    }
    }

