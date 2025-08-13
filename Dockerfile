# استخدم صورة CTFd الرسمية
FROM ghcr.io/ctfd/ctfd:latest
WORKDIR /opt/CTFd

# انسخ الثيم/الإضافات إذا موجودة
# (احذف السطر إذا ما عندك المجلد)
COPY ./themes/ /opt/CTFd/CTFd/themes/
COPY ./plugins/ /opt/CTFd/CTFd/plugins/

# (اختياري) متطلبات إضافاتك
# COPY requirements.txt /opt/CTFd/requirements.txt
# RUN pip install --no-cache-dir -r /opt/CTFd/requirements.txt

# Railway يمرر PORT تلقائيًا
ENV PORT=8000
CMD ["bash", "-lc", "exec gunicorn -w ${WORKERS:-2} -k gevent -b 0.0.0.0:${PORT} 'CTFd:create_app()'"]
