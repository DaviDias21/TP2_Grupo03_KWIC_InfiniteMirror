local kwic_module = require("resourses.kwic_module")

--argumentos da linha de comando ?????????
local args = {...}  

if #args ~= 2 then
    print("uso: lua kwic.lua <stopwords> <frases>")
    os.exit(1)
end


-- args[1] = arquivo das stopwords
-- args[2] = arquivo das frases 


local results = kwic_module.generateKWIC(args[1], args[2])
for _, line in ipairs(results) do
    print(line)
end
