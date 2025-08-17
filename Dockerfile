# syntax=docker/dockerfile:1
FROM python:3.12-slim

# Ensure predictable Python behavior
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Install system packages needed for building common DB drivers
# - If using SQLite only, you can omit build-essential and libpq-dev
RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential \
      libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Set work directory
WORKDIR /app

# Install Python dependencies first (better layer caching)
COPY requirements.txt /app/
RUN python -m ensurepip --upgrade || true \
 && pip install --upgrade pip setuptools wheel \
 && pip install -r requirements.txt

# Copy project files
COPY . /app

# Expose Django dev server port
EXPOSE 8000

# Run migrations and start the dev server by default
# For production, replace with a proper WSGI/ASGI server (gunicorn/uvicorn)
CMD ["bash", "-lc", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
