# Investment Performance Tracker & Forecast Simulator - User Guide

## Overview

This system allows you to track and analyze your investment performance, visualize your portfolio data, and forecast future scenarios. It's built using Python and Jupyter notebooks, with a focus on ease of use and powerful analytics.

## System Components

The system consists of five main components:

1. **Data Fetching** - Retrieves financial data from Yahoo Finance
2. **Transaction Log** - Manages your investment transactions
3. **Performance Analysis** - Analyzes your portfolio performance
4. **Visualization** - Creates visual representations of your portfolio data
5. **Forecasting** - Predicts future performance using various models

## Quick Start

1. Open the main notebook:
   ```
   jupyter lab nbs/main.ipynb
   ```

2. Run through the cells to see how all components work together

3. Customize the transaction log with your own investment data by editing `data/transactions.csv`

## Detailed Component Guide

### 1. Data Fetching (`YahooFinanceDataFetcher`)

This component fetches financial data from Yahoo Finance.

**Key Methods:**
- `get_historical_data(ticker, start_date=None, end_date=None, period='max')` - Get historical price data
- `get_current_price(ticker)` - Get the current price of a ticker
- `get_dividend_history(ticker)` - Get dividend history for a ticker
- `get_multiple_tickers_data(tickers)` - Get data for multiple tickers at once

**Example:**
```python
from app.data_fetching import YahooFinanceDataFetcher

# Initialize the data fetcher
data_fetcher = YahooFinanceDataFetcher()

# Get historical data for Apple
apple_data = data_fetcher.get_historical_data('AAPL', period='1y')

# Get current price
current_price = data_fetcher.get_current_price('AAPL')
print(f"Current price of AAPL: ${current_price:.2f}")
```

### 2. Transaction Log (`TransactionLogManager`)

This component manages your investment transactions.

**Key Methods:**
- `add_transaction(date, ticker, transaction_type, quantity, price, fee=0, notes='')` - Add a new transaction
- `get_holdings()` - Get current holdings based on transaction history
- `get_transactions_by_ticker(ticker)` - Get all transactions for a specific ticker
- `get_transactions_by_type(transaction_type)` - Get all transactions of a specific type
- `import_from_csv(csv_path)` - Import transactions from a CSV file

**Example:**
```python
from app.transaction_log import TransactionLogManager

# Initialize the transaction log manager
transaction_manager = TransactionLogManager('data/transactions.csv')

# Add a new transaction
transaction_manager.add_transaction(
    date='2023-01-15',
    ticker='AAPL',
    transaction_type='Buy',
    quantity=10,
    price=150.25,
    fee=5.99,
    notes='Initial purchase'
)

# View current holdings
holdings = transaction_manager.get_holdings()
print(holdings)
```

### 3. Performance Analysis (`PerformanceAnalyzer`)

This component analyzes your portfolio performance.

**Key Methods:**
- `get_portfolio_performance()` - Calculate portfolio performance metrics
- `get_performance_summary()` - Get a summary of portfolio performance
- `plot_portfolio_performance()` - Plot portfolio performance over time
- `calculate_risk_metrics()` - Calculate risk metrics for the portfolio
- `compare_to_benchmark(benchmark_ticker='^GSPC')` - Compare portfolio to a benchmark

**Example:**
```python
from app.performance_analysis import PerformanceAnalyzer

# Initialize the performance analyzer
performance_analyzer = PerformanceAnalyzer(transaction_manager, data_fetcher)

# Get portfolio performance
performance = performance_analyzer.get_portfolio_performance()
print(performance)

# Get performance summary
summary = performance_analyzer.get_performance_summary()
print(summary)

# Plot portfolio performance over time
fig, _ = performance_analyzer.plot_portfolio_performance()
fig.show()
```

### 4. Visualization (`InvestmentVisualizer`)

This component creates visual representations of your portfolio data.

**Key Methods:**
- `plot_asset_allocation(by='cost')` - Plot asset allocation pie chart
- `plot_performance_comparison()` - Plot performance comparison of all assets
- `create_dashboard()` - Create an interactive dashboard with multiple visualizations

**Example:**
```python
from app.visualization import InvestmentVisualizer

# Initialize the visualizer
visualizer = InvestmentVisualizer(transaction_manager, data_fetcher, performance_analyzer)

# Plot asset allocation
allocation_fig = visualizer.plot_asset_allocation(by='value')
allocation_fig.show()

# Create dashboard
dashboard = visualizer.create_dashboard()
dashboard
```

### 5. Forecasting (`InvestmentForecaster`)

This component predicts future performance using various models.

**Key Methods:**
- `forecast_portfolio_value(years=10, monthly_contribution=0, annual_return_rate=0.07)` - Forecast future portfolio value
- `forecast_asset_prices(ticker, days=30, method='arima')` - Forecast future asset prices

**Example:**
```python
from app.forecasting import InvestmentForecaster

# Initialize the forecaster
forecaster = InvestmentForecaster(transaction_manager, data_fetcher, performance_analyzer)

# Forecast portfolio value
fig, _ = forecaster.forecast_portfolio_value(
    years=10,
    monthly_contribution=500,
    annual_return_rate=0.07,
    return_volatility=0.15,
    num_simulations=50
)
fig.show()

# Forecast asset prices
fig, _ = forecaster.forecast_asset_prices(
    ticker='AAPL',
    days=30,
    method='arima'
)
fig.show()
```

## Transaction CSV Format

The system uses a CSV file to store transaction data. The file should have the following columns:

- `Date` - Transaction date (YYYY-MM-DD format)
- `Ticker` - Ticker symbol
- `Type` - Transaction type ('Buy', 'Sell', or 'Dividend')
- `Quantity` - Number of shares (or dividend amount for 'Dividend' type)
- `Price` - Price per share (0 for 'Dividend' type)
- `Fee` - Transaction fee (optional, defaults to 0)
- `Total` - Total amount (calculated automatically if not provided)
- `Notes` - Additional notes (optional)

Example:
```
Date,Ticker,Type,Quantity,Price,Fee,Total,Notes
2023-01-15,AAPL,Buy,10,150.25,5.99,-1508.49,Initial purchase
2023-02-10,MSFT,Buy,5,280.50,5.99,-1408.49,Dollar-cost averaging
2023-03-01,AAPL,Dividend,5.75,0,0,5.75,Quarterly dividend
```

## Common Workflows

### 1. Adding New Transactions

```python
# Add a new transaction
transaction_manager.add_transaction(
    date=datetime.now().strftime('%Y-%m-%d'),
    ticker='NVDA',
    transaction_type='Buy',
    quantity=2,
    price=850.25,
    fee=5.99,
    notes='New position in NVIDIA'
)

# View updated transactions
transaction_manager.transactions
```

### 2. Analyzing Portfolio Performance

```python
# Get portfolio performance
performance = performance_analyzer.get_portfolio_performance()

# Get performance summary
summary = performance_analyzer.get_performance_summary()

# Calculate risk metrics
risk_metrics = performance_analyzer.calculate_risk_metrics()

# Compare to benchmark (S&P 500)
benchmark_fig, benchmark_metrics = performance_analyzer.compare_to_benchmark('^GSPC')
```

### 3. Forecasting Future Performance

```python
# Forecast portfolio value with monthly contributions
fig, _ = forecaster.forecast_portfolio_value(
    years=10,
    monthly_contribution=500,
    annual_return_rate=0.07,
    return_volatility=0.15,
    num_simulations=50
)

# Forecast asset prices
fig, _ = forecaster.forecast_asset_prices(
    ticker='AAPL',
    days=30,
    method='arima'
)
```

## Advanced Usage

### 1. Customizing Visualizations

All visualization methods return Plotly figures, which can be customized:

```python
fig = visualizer.plot_asset_allocation(by='value')
fig.update_layout(
    title='My Custom Asset Allocation',
    colorway=['#636EFA', '#EF553B', '#00CC96', '#AB63FA', '#FFA15A']
)
fig.show()
```

### 2. Implementing Custom Forecasting Models

You can extend the `InvestmentForecaster` class to implement custom forecasting models:

```python
class CustomForecaster(InvestmentForecaster):
    def forecast_with_custom_model(self, ticker, days=30):
        # Implement your custom forecasting logic here
        pass
```

### 3. Automating Data Updates

You can set up a script to automatically update market data:

```python
# update_data.py
from app.data_fetching import YahooFinanceDataFetcher

data_fetcher = YahooFinanceDataFetcher()
tickers = ['AAPL', 'MSFT', 'GOOGL', 'AMZN', 'VTI']
for ticker in tickers:
    data_fetcher.get_historical_data(ticker, use_cache=False)
```

Then set up a cron job to run this script daily.

## Troubleshooting

### Common Issues

1. **Yahoo Finance API Rate Limiting**
   - If you see errors when fetching data, it might be due to rate limiting
   - Solution: Add delays between requests or use cached data

2. **Missing Transaction Data**
   - If your portfolio analysis seems incorrect, check your transaction data
   - Solution: Verify the CSV format and ensure all required columns are present

3. **Forecasting Errors**
   - If you encounter errors in forecasting, it might be due to insufficient historical data
   - Solution: Use a longer period for historical data or try a different forecasting method

## Next Steps

Here are some ideas for further enhancing your investment tracker:

1. **Tax Reporting**: Add functionality to generate tax reports for realized gains/losses
2. **Portfolio Optimization**: Implement portfolio optimization algorithms
3. **Mobile App**: Create a mobile app interface for on-the-go portfolio tracking
4. **Email Alerts**: Set up email alerts for significant price movements
5. **Machine Learning**: Implement more sophisticated forecasting models
6. **API Integration**: Integrate with brokerage APIs for automatic transaction importing
