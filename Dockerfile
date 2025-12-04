FROM python:3.11-slim

WORKDIR /application

# copy only requirements first for better build cache
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# copy app code
COPY . .

# expose container port (app listens on 8000 in your app.py)
EXPOSE 8000

# Exec form - correct JSON array (no NBSPs)
CMD ["python", "app.py"]
