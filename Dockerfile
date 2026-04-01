FROM alpine:latest

# تثبيت الحزم المطلوبة وتنزيل Xray وإعطائه صلاحية التشغيل
RUN apk add --no-cache ca-certificates jq tzdata && \
    wget -O /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/bin && \
    rm /tmp/xray.zip && \
    chmod +x /usr/bin/xray

COPY config.json /etc/xray/config.json

# استخدام sh -c لضمان قراءة منفذ Cloud Run وتطبيق الاستبدال قبل التشغيل
CMD sh -c 'sed -i "s/8080/$PORT/g" /etc/xray/config.json && xray run -config /etc/xray/config.json'
