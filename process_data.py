import pandas as pd
import re
from fetch_data import fetch_data

def word_to_num(word):
    """Maps words to their corresponding numeric values."""
    mapping = {
        'mil': 1000,
        'milhões': 1000000
    }
    return mapping.get(word, 1)

def convert_to_numeric(value):
    """Converts text-based numeric values in a string to actual numbers."""
    matches = re.findall(r'(\d+(?:,\d+)?)(?:\s+(milhões?|mil))?', value)
    for match in matches:
        number = float(match[0].replace(',', '.')) * word_to_num(match[1])
        value = value.replace(' '.join(match), str(number))
    return float(value.replace(',', '.'))

def process_data(df):
    """Processes the DataFrame to convert text-based numeric values."""
    if 'quantidade_ou_valor' in df.columns:
        df['quantidade_ou_valor'] = df['quantidade_ou_valor'].apply(convert_to_numeric)
        pd.options.display.float_format = '{:.2f}'.format
        print("Data processed successfully!")
    else:
        print("Column 'quantidade_ou_valor' not found in DataFrame.")

if __name__ == "__main__":
    df = fetch_data()
    if not df.empty:
        process_data(df)
        print(df.head())
