FROM python:3.9-slim-buster

WORKDIR /app
COPY . .

# cài đặt các thư viện từ file requirements.txt
RUN pip install -r requirements.txt

# Mở port 5000 cho ứng dụng
EXPOSE 5000

# biến môi trường
ENV FLASK_APP='hello_flask.py'

# Command để khởi chạy app
CMD ["flask", "run", "--host", "0.0.0.0"]
