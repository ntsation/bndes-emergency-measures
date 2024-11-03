# BNDES COVID-19 Emergency Measures Analysis

This project is designed to fetch, preprocess, and analyze data from the Brazilian Development Bank (BNDES) Open Data API, specifically related to emergency COVID-19 measures. The project includes data retrieval, preprocessing for text-based numeric values, and exploratory data analysis.

## Project Structure

- **fetch_data.py**: Fetches data from the BNDES API and loads it into a DataFrame.
- **process_data.py**: Processes the data by converting text-based numeric values into numeric format.
- **test_fetch_data.py**: Contains tests to verify that data retrieval from the API is functioning as expected.
- **BNDES_COVID19_Data_Analysis_Notebook.ipynb**: A Jupyter Notebook that demonstrates data loading, preprocessing, and analysis.

## Setup Instructions

### Prerequisites

- Python 3.7 or higher
- Recommended packages:
  - `requests`
  - `pandas`
  - `matplotlib`
  - `seaborn`
  - `pytest` (for testing)

### Installation

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

### File Descriptions

- **fetch_data.py**: Contains `fetch_data()` to fetch and load data from the BNDES API. If the request is successful, it returns the data as a DataFrame.
- **process_data.py**: Contains functions to convert text-based numeric values. Functions include:
  - `word_to_num(word)`: Maps words like "million" and "thousand" to their numeric equivalents.
  - `convert_to_numeric(value)`: Uses regular expressions to replace text-based numbers with numeric values.
- **test_fetch_data.py**: Tests the `fetch_data` function to confirm data retrieval from the API.
- **BNDES_COVID19_Data_Analysis_Notebook.ipynb**: Interactive notebook that:
  - Loads and preprocesses data.
  - Generates statistical summaries and visualizations.
  - Analyzes distribution patterns and top categories by amount/value.

## Running the Code

### Fetching Data

```bash
python fetch_data.py
```

### Processing Data

```bash
python process_data.py
```

### Running Tests

Run tests to verify data retrieval functionality:

```bash
pytest test_fetch_data.py
```

### Using the Notebook

To run the full analysis, open the Jupyter Notebook:

```bash
jupyter notebook BNDES_COVID19_Data_Analysis_Notebook.ipynb
```
