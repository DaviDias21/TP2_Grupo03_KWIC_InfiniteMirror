local luaunit = require("resourses.luaunit")
local kwic_module = require("resourses.kwic_module")

function testReadFile()
    local expected = {"The quick brown fox", "A brown cat sat", "The cat is brown"}
    local file = "resourses\\test_cases\\phrases.txt"
    local result = kwic_module.readFile(file)
    luaunit.assertEquals(result, expected)
end

function testSplitString()
    local strings = {"The quick brown fox", "A brown cat sat", "The cat is brown"}
    luaunit.assertEquals(kwic_module.splitString(strings[1]), {"The", "quick", "brown", "fox"})
    luaunit.assertEquals(kwic_module.splitString(strings[2]), {"A", "brown", "cat", "sat"})
    luaunit.assertEquals(kwic_module.splitString(strings[3]), {"The", "cat", "is", "brown"})
end

function testGenerateKWICEntries()
    local stopWords = kwic_module.arrayToSet({"a", "an", "the", "is", "sat"})
    local index = 1
    
    local results = {}
    local words = {"The", "quick", "brown", "fox"}
    kwic_module.generateKWICEntries(words, stopWords, index, results)
    luaunit.assertEquals(results, {"quick brown fox The", "brown fox The quick", "fox The quick brown"})

    local results = {}
    local words = {"A", "brown", "cat", "sat"}
    kwic_module.generateKWICEntries(words, stopWords, index, results)
    luaunit.assertEquals(results, {"brown cat sat A", "cat sat A brown"})

    local results = {}
    local words = {"The", "cat", "is", "brown"}
    kwic_module.generateKWICEntries(words, stopWords, index, results)
    luaunit.assertEquals(results, {"cat is brown The", "brown The cat is"})
end

function testGenerateKWIC()
    local stopWordsFile = "resourses\\test_cases\\stopwords.txt"
    local phrasesFile = "resourses\\test_cases\\phrases.txt"
    local expected = {"brown cat sat A", "brown fox The quick", "brown is The cat", "cat is brown The", "cat sat A brown", "fox The quick brown", "quick brown fox The"}
    local result = kwic_module.generateKWIC(stopWordsFile, phrasesFile)
    luaunit.assertEquals(kwic_module.generateKWIC(result, expected))
end

os.exit( luaunit.LuaUnit.run() )