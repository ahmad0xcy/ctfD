# استخدم صورة CTFd الرسمية
FROM ghcr.io/ctfd/ctfd:latest

# تثبيت psycopg2 لدعم PostgreSQL (احتياطيًا)
RUN pip install --no-cache-dir psycopg2-binary

# داخل الصورة مسار عمل CTFd
WORKDIR /opt/CTFd

# Railway يمرر PORT تلقائيًا (الافتراضي 8000)
ENV PORT=8000

# إعداد قاعدة البيانات PostgreSQL
ENV DATABASE_URL=postgresql+psycopg2://postgres:cyIPcYtDdfLUVnaLpmaywDTdcjOBDkoj@postgres.railway.internal:5432/railway

# (اختياري) طباعة قيمة متغير قاعدة البيانات للتأكد
RUN echo "DATABASE_URL=$DATABASE_URL"

# شغّل السيرفر
CMD ["bash", "-lc", "echo Using DB: $DATABASE_URL && exec gunicorn -w ${WORKERS:-2} -k gevent -b 0.0.0.0:${PORT} 'CTFd:create_app()'"]
