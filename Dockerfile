# Беремо мінімальний офіційний образ Python
FROM python:3.12-slim

# Створюємо непривілейованого користувача (НЕ root) — принцип найменших привілеїв
RUN useradd --create-home --shell /bin/bash appuser

# Робоча директорія
WORKDIR /app

# Спочатку копіюємо лише залежності (кешування шарів Docker)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копіюємо код застосунку
COPY app.py .

# Передаємо власність застосунку непривілейованому користувачу
RUN chown -R appuser:appuser /app

# Перемикаємось на непривілейованого користувача
USER appuser

# Відкриваємо порт
EXPOSE 8080

# Запускаємо застосунок
CMD ["python", "app.py"]
