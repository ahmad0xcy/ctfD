FROM ghcr.io/ctfd/ctfd:latest
RUN pip install --no-cache-dir psycopg2-binary
WORKDIR /opt/CTFd

ENV PORT=8000
ENV DATABASE_URL=postgresql+psycopg2://postgres:cyIPcYtDdfLUVnaLpmaywDTdcjOBDkoj@postgres.railway.internal:5432/railway
ENV SQLALCHEMY_DATABASE_URI=${DATABASE_URL}

# حيلة صغيرة لكسر الكاش وإجبار rebuild عند كل دفع
ARG CACHE_BUST=1

CMD ["bash","-lc","exec gunicorn -w ${WORKERS:-2} -k gevent -b 0.0.0.0:${PORT} 'CTFd:create_app()'"]
