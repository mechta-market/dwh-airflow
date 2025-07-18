FROM apache/airflow:2.9.2

#RUN apt-get update && apt-get install -y \
#    wget unzip xvfb libxi6 libgconf-2-4 libnss3 libxss1 libappindicator1 libindicator7 libu2f-udev

COPY requirements.txt .

RUN pip3 install -r requirements.txt
