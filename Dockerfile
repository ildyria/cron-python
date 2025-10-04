
FROM tensorflow/tensorflow:latest

#Install Cron
RUN apt-get update && \
    apt-get install -y cron && \
    rm -fr /var/lib/apt/lists/* && \
    pip install --break-system-packages requests nudenet>=3.4.2

# Copy and enable your CRON task
# Add crontab file in the cron directory
ADD ./mycron /etc/cron.d/hello-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/hello-cron && \
    crontab -u root /etc/cron.d/hello-cron && \
    touch /var/log/cron.log

# Start TAIL - as your always-on process (otherwise - container exits right after start)
CMD cron && tail -f /var/log/cron.log