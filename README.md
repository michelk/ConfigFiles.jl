This is a rudimentary Julia version of a subset of
[configurator](https://www.github.com/bos/configurator).

The main difference is the way string interpolation works. So

* values, defined above in the config-file, should be accessible through `cfg`. Eg

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

* more flexible syntax 

Example
-------

    a = 1
    b = 2
    #c = cfg["a"] + cfg["b"] # this is currently not working
    d = reverse("abc")
    root = string(joinpath(ENV["HOME"], "src"))
    x {
       uno = "da"
       dos = "di"
       y {
       	  tres = "do"
    	  quadro = "la"
       }
    }
    z {
       import "test2.cfg"
    }
