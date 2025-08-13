# استخدم صورة CTFd الرسمية
FROM ghcr.io/ctfd/ctfd:latest

# مسار عمل CTFd داخل الصورة
WORKDIR /opt/CTFd

# انسخ الثيمات/الإضافات (لو ما عندك هالمجلدات بيمشي الحال)


# Railway يمرّر PORT تلقائيًا (الافتراضي 8000)
ENV PORT=8000

# شغّل السيرفر
CMD ["bash", "-lc", "exec gunicorn -w ${WORKERS:-2} -k gevent -b 0.0.0.0:${PORT} 'CTFd:create_app()'"]
