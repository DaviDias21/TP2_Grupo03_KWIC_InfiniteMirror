local NAME = "kwic_module"

local kwic_module = {}

function readLines(file) -- função que lê as linhas e retorna uma table
    local line = file:read("*line") -- lê a próxima linha
    if not line then -- se a linha for vazia, a função retorna uma table vazia
        return {}
    end
    
    local lines = readLines(file) -- se não, a próxima linha é lida
    
    table.insert(lines, 1, line)
    -- table é preenchida como uma pilha:
    -- primeiro inserimos a última linha e, então,
    -- as linhas anteriores são inseridas no início uma por uma
    
    return lines -- retorna a table após modificação
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
kwic_module.readFile = readFile

function arrayToSet(arr)
    local set = {}
    for _, value in ipairs(arr) do
        set[string.lower(value)] = true
    end
    return set
end
kwic_module.arrayToSet = arrayToSet

function splitString(str)
    local words = {}
    for word in string.gmatch(str, "%S+") do  -- eu copiei isso do google eu nao sei oq isso significa %S+ tem que olhar depois
        table.insert(words, word)
    end
    return words
end
kwic_module.splitString = splitString

function generateKWICEntries(words, stopWords, index, results)
    if index > #words then -- se o índice for maior que o comprimento da table de palavras, retorna
        return results
    end
    
    local word = string.lower(words[index]) -- pega a palavra do índice atual e a torna minúscula
    
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
kwic_module.generateKWICEntries = generateKWICEntries

function generateKWIC(stopWordsFile, phrasesFile)
    local stopWords = arrayToSet(readFile(stopWordsFile))
    local phrases = readFile(phrasesFile)
    
    local allResults = {}
    
    local function processPhrases(phrases, index) -- lê a table com as frases, também recebe um índice
        if index > #phrases then -- se o índice for maior que o comprimento da table, retorna
            return
        end
        
        local phrase = phrases[index] -- o índice recebido indica o índice da table a ser lido
        local words = splitString(phrase) -- a frase é dividida em palavras, inseridas em uma table
        local results = {} -- é criada uma table de resultados específica para a frase
        
        generateKWICEntries(words, stopWords, 1, results) -- a frase é processada e são geradas
                                                          -- as entradas de KWIC
        
        -- para cada elemento na table de resultados da frase, isto é, para cada
        -- entrada de KWIC gerada, insere os resultados numa table com
        -- todos os resultados (todas as entradas de KWIC)
        for _, result in ipairs(results) do 
            table.insert(allResults, result)                                            
        end
        
        processPhrases(phrases, index + 1) -- chama a função para a próxima frase
    end
    
    processPhrases(phrases, 1)
    
    table.sort(allResults, function(a, b) 
        return string.lower(a) < string.lower(b) -- se não fizer isso ele ordena por ordem alfabética case sensitive (maiusculo primeiro)
    end)
    
    return allResults
end
kwic_module.generateKWIC = generateKWIC

return kwic_module