
FROM python:3.13-alpine

RUN apk add --no-cache py3-requests build-base musl-dev linux-headers
RUN pip install requests nudenet

# Copy and enable your CRON task
COPY ./mycron /app/mycron
RUN crontab /app/mycron

# Create empty log (TAIL needs this)
RUN touch /tmp/out.log

# Start TAIL - as your always-on process (otherwise - container exits right after start)
CMD crond && tail -f /tmp/out.log
