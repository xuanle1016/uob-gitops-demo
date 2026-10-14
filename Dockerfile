FROM python:3.11-slim

WORKDIR /app

# 1. 显式升级有漏洞的系统级/构建级 Python 包 (修复 CVE-2026-23949 与 CVE-2026-24049)
RUN pip install --no-cache-dir --upgrade "jaraco.context>=6.1.0" "wheel>=0.46.2"

# 2. 复制依赖并安装
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 3. 复制应用代码
COPY app.py .

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]