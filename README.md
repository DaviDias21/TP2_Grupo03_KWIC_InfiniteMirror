# TP2 2024.2 - Grupo 03 - Key Words in Context

## Uma implementação do algoritmo de formatação Key Words in Context (KWIC) em Lua, aplicando o estilo de programação Infinite Mirror

### Alunos:

* Caio Eduardo da Silva - 231034298
* Davi Dias da Silva Cruz - 180063251
* Luís Augusto da Silveira Cavalcanti - 231003415
* Luiz Felipe Ducat - 231035400

## Funcionalidade

Recebe uma lista de frases e retorna uma lista das palavras-chave encontradas posicionadas em seu contexto, ordenadas em ordem alfabética.

## Utilização

Para a utilização deve-se haver Lua instalado em seu sistema. O projeto foi realizado com a versão 5.2.4 da linguagem.

Havendo Lua em seu sistema, simplesmente execute o seguinte comando no diretório do projeto:

``lua kwic.lua <arquivo_stopwords> <arquivo_frases>``

O programa pede dois arquivos .txt: um arquivo que contém as *stopwords*, e um que contém as frases que serão processadas, respectivamente.

## Exemplos

Segue abaixo um exemplo de entradas e saídas do algoritmo:

### Entrada:

stopwords.txt
```
a
an
the
is
sat
```

phrases.txt
```
The quick brown fox
A brown cat sat
The cat is brown
```

Na Command Line:
``` 
lua kwic.lua stopwords.txt phrases.txt
```

Saída:
```
brown cat sat A
brown fox The quick
brown The cat is
cat is brown The
cat sat A brown
fox The quick brown
quick brown fox The
```

## Licença

Licença MIT. Disponível em arquivo.