
FROM python:3.12-alpine

RUN apk add --no-cache py3-requests
RUN pip install requests nudeset

# Copy and enable your CRON task
COPY ./mycron /app/mycron
RUN crontab /app/mycron

# Create empty log (TAIL needs this)
RUN touch /tmp/out.log

# Start TAIL - as your always-on process (otherwise - container exits right after start)
CMD crond && tail -f /tmp/out.log
