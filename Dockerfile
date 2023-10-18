# Используем официальный образ Python
FROM python:3.8

# Устанавливаем переменные среды для запуска Django в режиме "production"
ENV DJANGO_SETTINGS_MODULE=rekrutodjango.settings
ENV DEBUG=False


# Создаем директорию приложения и устанавливаем рабочий каталог
RUN mkdir /app
WORKDIR /app


# Копируем requirements.txt и устанавливаем зависимости
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Устанавливаем gunicorn
RUN pip install gunicorn

# Копируем все файлы из текущего каталога (кроме тех, указанных в .dockerignore) в контейнер
COPY . /app/

# Определяем порт, который будет слушать контейнер
EXPOSE 8000

# Запускаем сервер Django
CMD ["gunicorn", "rekrutodjango.wsgi:application", "--bind", "0.0.0.0:8000"]
