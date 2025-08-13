# استخدم صورة CTFd الرسمية
FROM ghcr.io/ctfd/ctfd:latest

# داخل الصورة مسار عمل CTFd
WORKDIR /opt/CTFd

# انسخ الثيم/الإضافات إذا موجودة
# (احذف السطرين أو خلّي المجلدين موجودين حتى لو فاضيين)

# Railway يمرر PORT تلقائيًا
ENV PORT=8000

# شغّل السيرفر
CMD ["bash", "-lc", "exec gunicorn -w ${WORKERS:-2} -k gevent -b 0.0.0.0:${PORT} 'CTFd:create_app()'"]
