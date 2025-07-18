FROM apache/airflow:2.9.2

COPY requirements.txt .

RUN pip3 install -r requirements.txt
