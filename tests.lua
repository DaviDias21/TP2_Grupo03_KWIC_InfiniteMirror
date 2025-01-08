-- so rodar esse arquivo para os testes executarem

luaunit = require("luaunit")
local kwic = require("kwic") -- nome do arquivo com o script

function testKWICfn() -- preciso saber os nomes das funcoes pra testar
    luaunit.assertEquals(0, 0)

os.exit( luaunit.LuaUnit.run() )