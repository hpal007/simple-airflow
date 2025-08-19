#!/bin/bash
# setup-airflow.sh

# Run this script at location where you want to set up Airflow
# It will create a virtual environment and install Airflow with specific version
# run this line first to provide permission: chmod +x ./airflow-setup.sh

# Create virtual environment
# pip3 install uv   # Uncomment if uv is not installed
uv venv
source .venv/bin/activate

current_dir=$(pwd)
# Set Airflow home
mkdir -p "${current_dir}/airflow"

export AIRFLOW_HOME="${current_dir}/airflow"

echo "AIRFLOW_HOME: $AIRFLOW_HOME"
# Install specific Airflow version with constraints
AIRFLOW_VERSION=3.0.4
PYTHON_VERSION="$(python3 --version | cut -d " " -f 2 | cut -d "." -f 1-2)"
CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"

echo "Installing Airflow version: ${AIRFLOW_VERSION} with constraints from ${CONSTRAINT_URL}"

uv pip install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"
uv pip install playwright aiofiles python-dotenv tenacity beautifulsoup4 requests black
uv pip freeze > requirements.txt


echo "Setup complete!"
echo "To start Airflow, run:"
echo "export AIRFLOW_HOME=$AIRFLOW_HOME"
echo "source .venv/bin/activate"
echo "airflow standalone"