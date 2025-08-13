FROM ghcr.io/ctfd/ctfd:latest
RUN pip install --no-cache-dir psycopg2-binary
WORKDIR /opt/CTFd

ENV PORT=8000
# احتياط لو Railway ما مرّر المتغيّر
ENV DATABASE_URL=postgresql+psycopg2://postgres:cyIPcYtDdfLUVnaLpmaywDTdcjOBDkoj@postgres.railway.internal:5432/railway
ENV SQLALCHEMY_DATABASE_URI=${DATABASE_URL}

# اطبع القيم قبل التشغيل للتأكد أنها واصلة
CMD ["bash","-lc","echo DATABASE_URL=$DATABASE_URL && echo SQLALCHEMY_DATABASE_URI=$SQLALCHEMY_DATABASE_URI && exec gunicorn -w ${WORKERS:-2} -k gevent -b 0.0.0.0:${PORT} 'CTFd:create_app()'"]
