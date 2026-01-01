import pandas as pd


def process_data(df):
    if df.empty:
        return df

    df.dropna(how="all", inplace=True)

    if "descricao" in df.columns:
        df["descricao"] = df["descricao"].astype(str).str.strip()

    print("Data processed successfully!")
    return df


if __name__ == "__main__":
    data = {"descricao": [" Test "], "val": [100]}
    df = pd.DataFrame(data)
    process_data(df)
    print(df)
