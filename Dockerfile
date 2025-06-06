# Используем минимальный Python-образ
FROM python:3.12-alpine

# Устанавливаем рабочую директорию внутри контейнера
WORKDIR /app

# Копируем файлы
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Открываем порт
EXPOSE 5000

# Запускаем сайт
CMD ["python", "app.py"]
