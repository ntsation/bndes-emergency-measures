# API - Medidas emergenciais Covid-19

Este repositório contém dois códigos em Python para acessar e manipular dados do Banco Nacional de Desenvolvimento Econômico e Social (BNDES).

O código 1 (parametros.py) realiza a obtenção dos dados da API do BNDES, enquanto o código 2 (main.py) realiza a conversão e manipulação desses dados.

## Código 1: parametros.py

- Descrição
  - O arquivo é responsável por fazer uma requisição à API do Portal de dados abertos do BNDES e obter os dados disponíveis. Ele utiliza a biblioteca requests para fazer a solicitação HTTP e a biblioteca pandas para manipulação dos dados recebidos.

- Funcionalidades
  - Faz uma requisição à API do Portal de dados abertos do BNDES.
  - Extrai os dados da resposta JSON.
  - Cria um DataFrame do Pandas com os dados extraídos.

### Código 2: main.py

- Descrição
  - O arquivo complementa o código parametros.py, adicionando funcionalidades para a conversão e manipulação dos dados obtidos. Ele utiliza expressões regulares para identificar e converter valores numéricos expressos em formato de texto, como "1 milhão" para o valor numérico correspondente.

- Funcionalidades
  - Define funções para converter palavras como "mil" e "milhões" em seus valores numéricos correspondentes.
  - Utiliza expressões regulares para encontrar padrões de valores numéricos seguidos de palavras como "mil" ou "milhões".
  - Converte os valores no formato de texto para valores numéricos e atualiza o DataFrame.
