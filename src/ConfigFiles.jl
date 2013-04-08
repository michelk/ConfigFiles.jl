module ConfigFiles
typealias Block Dict{String, Any}
typealias ConfigFile Block
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
    block = Block()
    while true
        line = readline(con) 
        if  ismatch(r"\}", line) || line == ""  
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

function show(io::IO, cfg :: ConfigFile)
    for (key, value) in cfg
        println(io, "$key = $value")
    end
end

function readConfig(con::IOStream)
    global CFG = Block()
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
