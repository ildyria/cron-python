
FROM tensorflow/tensorflow:latest


#Install Cron
RUN apt-get update
RUN pip install --break-system-packages requests nudenet>=3.4.2
# RUN apk add --no-cache py3-requests build-base musl-dev linux-headers
# RUN pip install requests nudenet>=3.4.2
# RUN pip install tensorflow>=2.14.0
# Copy and enable your CRON task
# Add crontab file in the cron directory
ADD ./mycron /etc/cron.d/hello-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/hello-cron

# Create empty log (TAIL needs this)
RUN touch /var/log/cron.log

RUN apt-get -y install cron

# Start TAIL - as your always-on process (otherwise - container exits right after start)
CMD cron && tail -f /var/log/cron.log