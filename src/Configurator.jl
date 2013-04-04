module Configurator
    function readConfig(con::IOStream)
    end 

    function readConfig(f::String)
        con = open(f, "r")
        v = readConfig(con)
        close(con)
        v
    end
    export readConfig
end
