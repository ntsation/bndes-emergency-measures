import requests
import pandas as pd

url = 'https://dadosabertos.bndes.gov.br/api/3/action/datastore_search?resource_id=165243b3-e57b-47e6-bd79-65d12ead7c02&limit=5000000'

r = requests.get(url)

if r.status_code == 200:
    dados_json = r.json()
    dados = dados_json['result']['records']
    df = pd.DataFrame(dados)
    print("Dados obtidos com sucesso!")
else:
    print("Erro ao fazer requisição:", r.status_code)
