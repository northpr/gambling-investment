.ONESHELL:
SHELL := /bin/bash

.PHONY: help install setup_env build clean_nbs notebook lab streamlit_run test clean_pyc clean_build

# Default target
help:
	@echo "Available commands:"
	@echo "  install        - Install project dependencies using conda and pip"
	@echo "  setup_env      - (Placeholder) Setup virtual environment (e.g., python -m venv venv && source venv/bin/activate)"
	@echo "  build          - Build Python library from notebooks using nbdev and clean notebooks"
	@echo "  notebook       - Start Jupyter Notebook server in ./nbs"
	@echo "  lab            - Start JupyterLab server in ./nbs"
	@echo "  streamlit_run  - (Example) Run a Streamlit app (e.g., streamlit run app/dashboard.py)"
	@echo "  test           - (Placeholder for nbdev_test_nbs or other test runners)"
	@echo "  clean_pyc      - Remove Python file artifacts"
	@echo "  clean_build    - Remove build artifacts"

install:
	# If you're managing your base Python with conda, this is fine.
	# Ensure your conda environment is already activated when running make.
	conda install -y pip
	pip install -r requirements.txt

# nbdev specific build process
build:
	nbdev_build_lib
	nbdev_clean_nbs # Cleans notebooks after building lib

# If you use nbdev tests
# test:
#	nbdev_test_nbs

notebook:
	jupyter notebook --notebook-dir=./nbs

lab:
	jupyter lab --notebook-dir=./nbs

# Example: Assuming you'll have a Streamlit app in app/dashboard.py
# streamlit_run:
#	streamlit run app/dashboard.py

clean_pyc:
	find . -name "*.pyc" -exec rm -f {} +
	find . -name "*.pyo" -exec rm -f {} +
	find . -name "*~" -exec rm -f {} +

clean_build:
	rm -rf build/
	rm -rf dist/
	rm -rf .eggs/
	find . -name "*.egg-info" -exec rm -rf {} +
	find . -name "*.egg" -exec rm -rf {} +