module Configurator

function parseValue(l, block)
    (k,v) = map(strip, (split(l, "=")))
    if ismatch(r"cfg", v)
        try
           return({k => eval(parse(v))})
        catch
            global ncfg = block
            nv = replace(v, "cfg", "ncfg")
            return({k => eval(parse(nv))})
        end
    else 
           return({k => eval(parse(v))})
    end
end

function parseBlockContents(con, cfg)
    block = Dict{Any,Any}()
    while true
        line = readline(con) 
        if line == ""  || line == "}"
            break
        end
        line = chomp(line)
        line = strip(replace(line, r"\#.*", "")) # remove comments
        if ismatch(r"=", line) || ismatch(r"\[", line)
            merge!(block,parseValue(line, block))
        elseif ismatch(r"\{", line)
            k = strip(split(line, "\{")[1])
            merge!(block, {k => parseBlockContents(con, cfg)})
        elseif ismatch(r"import", line)
            merge!(block,readConfig(eval(parse(split(line)[2]))))
        else
            continue
        end
    end
    merge!(cfg, block)
    block
end

function readConfig(con::IOStream)
    global cfg = Dict{Any,Any}()
    parseBlockContents(con, cfg)
end 

function readConfig(f::String)
    con = open(f, "r")
    v = readConfig(con)
    close(con)
    v
end
export readConfig

end
