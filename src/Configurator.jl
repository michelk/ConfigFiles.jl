module Configurator

function parseAttr(l)
    (k,v) = map(strip, (split(l, "=")))
    {k => eval(parse(v))}
end

function parseList(l)  
    (k,v) = map(strip, (split(l, "=")))
    {k => eval(parse(v))}
end

function parseBlockContents(con)
    cfg = Dict{Any,Any}()
    while true
        line = readline(con) 
        if line == ""  || line == "}"
            break
        end
        line = chomp(line)
        line = strip(replace(line, r"\#.*", "")) # remove comments
        if ismatch(r"=", line)
            merge!(cfg,parseAttr(line))
        elseif ismatch(r"\[", line)
            merge!(cfg, parseList(line))
        elseif ismatch(r"\{", line)
            k = strip(split(line, "\{")[1])
            merge!(cfg, {k => parseBlockContents(con)})
        elseif ismatch(r"import", line)
            merge!(cfg,readConfig(eval(parse(split(line)[2]))))
        else
            continue
        end
    end
    cfg
end

function readConfig(con::IOStream)
    parseBlockContents(con)
end 

function readConfig(f::String)
    con = open(f, "r")
    v = readConfig(con)
    close(con)
    v
end
export readConfig

end
