FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    unzip \
    espeak-ng \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

COPY arabic_step_by_step_render_ready.zip /tmp/app.zip

RUN unzip -q /tmp/app.zip -d /tmp/extracted \
    && cp -a /tmp/extracted/arabic_step_by_step_learning/. /app/ \
    && rm -rf /tmp/extracted /tmp/app.zip

RUN pip install --no-cache-dir -r requirements.txt

ENV PORT=10000

EXPOSE 10000

CMD ["sh", "-c", "reflex run --env prod --single-port --frontend-port ${PORT:-10000}"]

