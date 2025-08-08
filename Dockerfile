FROM apache/airflow:2.9.2

USER root

RUN apt-get update && apt-get install -f -y \
    wget unzip xvfb libxi6 libgconf-2-4 libnss3 libxss1 libappindicator1 libu2f-udev gnupg \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем Google Chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && apt-get install -y google-chrome-stable

# Узнаем версию Chrome и ставим соответствующий ChromeDriver
RUN wget https://storage.googleapis.com/chrome-for-testing-public/139.0.7258.66/linux64/chromedriver-linux64.zip && \
    unzip chromedriver-linux64.zip && \
    sudo mv chromedriver-linux64 /usr/local/bin/chromedriver && \
    sudo chmod +x /usr/local/bin/chromedriver

USER airflow

COPY requirements.txt .

RUN pip3 install -r requirements.txt

# Переменные окружения для Selenium
ENV PATH="/usr/local/bin:${PATH}"
ENV CHROME_BIN="/usr/bin/google-chrome"
ENV CHROMEDRIVER_PATH="/usr/local/bin/chromedriver"
