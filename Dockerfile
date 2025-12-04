FROM python:3.4-alpine
ADD . /application
WORKDIR /application
RUN pip install -r requirements.txt
CMD ["python", "app.py"]
