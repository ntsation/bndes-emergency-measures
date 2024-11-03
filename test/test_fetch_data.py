# test_parametros.py
import parametros
import pandas as pd

def test_fetch_data():
    df = parametros.fetch_data()
    assert df is None or isinstance(df, pd.DataFrame), "Should return a DataFrame or None"
    if df is not None:
        assert not df.empty, "DataFrame should not be empty if the request was successful"
