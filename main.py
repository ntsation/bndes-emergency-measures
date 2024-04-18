import parametros
import pandas as pd
import re


def palavra_num(palavra):
    palavra_para_num = {
        'mil': 1000,
        'milhões': 1000000
    }
    return palavra_para_num.get(palavra, 1)

def converte_numerico(valor):
    correspondencias = re.findall(r'(\d+(?:,\d+)?)(?:\s+(milhões?|mil))?', valor)
    for correspondencia in correspondencias:
        numero = float(correspondencia[0].replace(',', '.')) * palavra_num(correspondencia[1])
        valor = valor.replace(' '.join(correspondencia), str(numero))
    return float(valor.replace(',', '.'))

parametros.df['quantidade_ou_valor'] = parametros.df['quantidade_ou_valor'].apply(converte_numerico)
pd.options.display.float_format = '{:.2f}'.format

print(parametros.df)