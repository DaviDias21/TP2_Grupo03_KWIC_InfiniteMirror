function readLines(file)
    local line = file:read("*line")
    if not line then
        return {}
    end
    local lines = readLines(file)
    table.insert(lines, 1, line)
    return lines
end

function readFile(filename)
    local file = io.open(filename, "r")
    if not file then
        error("arquivo \""  .. filename .. "\" nao existe")
    end
    local lines = readLines(file)
    file:close()
    return lines
end

-- array -> set (busca em O(1))
function arrayToSet(arr)
    local set = {}
    for _, value in ipairs(arr) do
        set[string.lower(value)] = true
    end
    return set
end

function splitString(str)
    local words = {}
    for word in string.gmatch(str, "%S+") do  -- eu copiei isso do google eu nao sei oq isso significa %S+ tem que olhar depois
        table.insert(words, word)
    end
    return words
end

function generateKWICEntries(words, stopWords, index, results)
    if index > #words then
        return results
    end
    
    local word = string.lower(words[index])
    
    -- se a palavra não é uma stopword, criar uma entry
    if not stopWords[word] then
        -- criar a frase com deslocamento circular
        local entry = {}
        for i = index, #words do
            table.insert(entry, words[i])
        end
        for i = 1, index - 1 do
            table.insert(entry, words[i])
        end
        table.insert(results, table.concat(entry, " "))
    end
    
    return generateKWICEntries(words, stopWords, index + 1, results)
end

function generateKWIC(stopWordsFile, phrasesFile)
    local stopWords = arrayToSet(readFile(stopWordsFile))
    local phrases = readFile(phrasesFile)
    
    local allResults = {}
    
    local function processPhrases(phrases, index)
        if index > #phrases then
            return
        end
        
        local phrase = phrases[index]
        local words = splitString(phrase)
        local results = {}
        generateKWICEntries(words, stopWords, 1, results)
        
        for _, result in ipairs(results) do
            table.insert(allResults, result)
        end
        
        processPhrases(phrases, index + 1)
    end
    
    processPhrases(phrases, 1)
    
    table.sort(allResults, function(a, b) 
        return string.lower(a) < string.lower(b) -- se não fizer isso ele ordena por ordem alfabética case sensitive (maiusculo primeiro)
    end)
    
    return allResults
end

--argumentos da linha de comando ?????????
local args = {...}  

if #args ~= 2 then
    print("uso: lua kwic.lua <stopwords> <frases>")
    os.exit(1)
end


-- args[1] = arquivo das stopwords
-- args[2] = arquivo das frases 


local results = generateKWIC(args[1], args[2])
for _, line in ipairs(results) do
    print(line)
end
