FROM alpine:latest

# تثبيت Xray-core بأحدث نسخة مستقرة
RUN apk add --no-cache ca-certificates jq && \
    wget -O /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/bin && \
    rm /tmp/xray.zip

COPY config.json /etc/xray/config.json

# إعداد المنفذ ليتوافق مع Google Cloud (تعديل رقم المنفذ داخل الملف عند التشغيل)
CMD sed -i "s/8080/$PORT/g" /etc/xray/config.json && xray run -config /etc/xray/config.json
