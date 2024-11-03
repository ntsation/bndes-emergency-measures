import requests
import pandas as pd

def fetch_data():
    """Fetches data from the BNDES Open Data API and returns it as a DataFrame."""
    url = 'https://dadosabertos.bndes.gov.br/api/3/action/datastore_search?' \
          'resource_id=165243b3-e57b-47e6-bd79-65d12ead7c02&limit=5000000'

    try:
        response = requests.get(url)
        response.raise_for_status()
        data_json = response.json()
        records = data_json['result']['records']
        df = pd.DataFrame(records)
        print("Data fetched successfully!")
        return df
    except requests.exceptions.RequestException as e:
        print("Error fetching data:", e)
        return pd.DataFrame()

if __name__ == "__main__":
    df = fetch_data()
    if not df.empty:
        print(df.head())
