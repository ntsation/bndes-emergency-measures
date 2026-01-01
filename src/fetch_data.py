import requests
import pandas as pd
import os


def fetch_resources_by_year(year, dataset_id="balanco-patrimonial"):
    base_url = "https://dadosabertos.bndes.gov.br/api/3/action"
    str_year = str(year)

    try:
        pkg_url = f"{base_url}/package_show?id={dataset_id}"
        print(f"Fetching metadata for dataset: {dataset_id}")
        response = requests.get(pkg_url)
        response.raise_for_status()
        pkg_data = response.json()

        resources = pkg_data.get("result", {}).get("resources", [])

        found_any = False
        for resource in resources:
            name = resource.get("name", "")
            rid = resource.get("id")

            if str_year in name and resource.get("datastore_active"):
                print(f"Fetching records for: {name} (ID: {rid})")

                ds_url = f"{base_url}/datastore_search?resource_id={rid}&limit=50000"
                ds_resp = requests.get(ds_url)
                ds_resp.raise_for_status()
                ds_data = ds_resp.json()

                records = ds_data.get("result", {}).get("records", [])
                if records:
                    df = pd.DataFrame(records)
                    df["source_resource_name"] = name
                    df["source_resource_id"] = rid

                    yield name, df
                    found_any = True
                else:
                    print(f"No records found in datastore for {name}")

        if not found_any:
            print(
                f"No matching resources with active datastore found for year {str_year}"
            )

    except Exception as e:
        print(f"Error in fetch_resources_by_year: {e}")


if __name__ == "__main__":
    for name, df in fetch_resources_by_year(2023):
        print(f"Success: {name} - {len(df)} records")
        break
