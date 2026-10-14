
FROM python:3.11-alpine

WORKDIR /app

COPY requirements.txt .

# Upgrade build tools to patched versions
RUN pip install --no-cache-dir --upgrade \
    "setuptools>=80" \
    "wheel>=0.46.2"

RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
