This Julia package provides a single function, `readConfig`, which could
read a configuration-file formated similar to the one
[configurator](https://www.github.com/bos/configurator) uses.

The main difference is the way string interpolation works. So

* values, defined above in the config-file, should be accessible through `CFG`. Eg

        a = 1
        b = CFG["a"] + 2

* there is function interpolation eg `a = reverse("abc")` 

Already implemented features
----------------------------

* rudimentary file-reading
* `import` statements
* expression interpolation

ToDo
----

* more flexible syntax. Eg

        x {a = 4}
        y = [1
            ,2
            ,3
            ]
        z 
        {
          b = 9
        }

Example
-------

A valid file-format now looks for example like

    a = 1
    b = 2
    c = CFG["a"] + CFG["b"]
    d = reverse("abc")
    root = joinpath(ENV["HOME"], "src")
    # 
    x {
       uno = "da"
       dos = "di"
       y {
       	  tres = "do"
    	  cuatro = "la"
       }
    }
    z {
       import "test2.CFG"
    }
