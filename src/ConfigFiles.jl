module ConfigFiles
type ConfigFile
end
type Block
end

function parseValue(l, block)
    (k,v) = map(strip, (split(l, "=")))
    if ismatch(r"CFG", v)
        try
           return({k => eval(parse(v))})
        catch
            global nCFG = block
            nv = replace(v, "CFG", "nCFG")
            return({k => eval(parse(nv))})
        end
    else 
           return({k => eval(parse(v))})
    end
end

function parseBlockContents(con, CFG)
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
            merge!(block, {k => parseBlockContents(con, CFG)})
        elseif ismatch(r"import", line)
            merge!(block,readConfig(eval(parse(split(line)[2]))))
        else
            continue
        end
    end
    merge!(CFG, block)
    block
end

function readConfig(con::IOStream)
    global CFG = Dict{Any,Any}()
    parseBlockContents(con, CFG)
end 

function readConfig(f::String)
    con = open(f, "r")
    v = readConfig(con)
    close(con)
    v
end
export readConfig

end
