FROM debian:bullseye-slim

# تثبيت الحزم الأساسية المطلوبة
RUN apt-get update && apt-get install -y wget unzip ca-certificates jq && rm -rf /var/lib/apt/lists/*

# تنزيل Xray وفك الضغط وإعطاء الصلاحيات
RUN wget -O /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/local/bin && \
    rm /tmp/xray.zip && \
    chmod +x /usr/local/bin/xray

# إنشاء مجلد الإعدادات ونسخ الملف
RUN mkdir -p /etc/xray
COPY config.json /etc/xray/config.json

# أمر التشغيل (يقوم بتحديث المنفذ ثم تشغيل Xray)
CMD sed -i "s/8080/$PORT/g" /etc/xray/config.json && xray run -config /etc/xray/config.json
