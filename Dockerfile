FROM python:3.11-slim

# set working dir
WORKDIR /app

# copy dependency manifest and install first (cache-friendly)
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# copy app code
COPY . .

# ensure Flask listens on 0.0.0.0 (see note below)
ENV FLASK_ENV=production

# expose internal port (Flask default is 5000)
EXPOSE 5000

# exec form - recommended
CMD ["python", "app.py"]
