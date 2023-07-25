FROM python:3.9-slim

WORKDIR /app

# Install required dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    git \
    && rm -rf /var/lib/apt/lists/*

# Clone the repository
RUN git clone https://github.com/nagaraju-developer/BANK_LOAN_PREDICTION.git .

# Add the Model_ml.pkl file from the model directory to the working directory
COPY model/Model_ml.pkl /app/

# Install Python dependencies
RUN pip3 install -r requirements.txt

# Expose the Streamlit port
EXPOSE 8501

# Healthcheck for Streamlit app
HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

# Run the Streamlit app
ENTRYPOINT ["streamlit", "run", "Bank_Loan_Prediction.py", "--server.port=8501", "--server.address=0.0.0.0"]
