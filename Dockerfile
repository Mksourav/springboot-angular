FROM mysql:5.7

# Installing Crontab
RUN apt-get update && apt-get -y install -qq --force-yes cron
#Installing Supervisor
RUN apt-get update && apt-get -y install -qq --force-yes supervisor

# Copying supervisord.conf file as the supervisor config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add shell script which contains mysqldump command and grant execution rights
ADD dbdump.sh /opt/lakj/dbdump.sh
RUN chmod +x /opt/lakj/dbdump.sh

# Folling entries will be added to the Crontab file. PATH entry should be available to execute the commands.
# Log entries related to the backup process will be added to lakj-backup.log file.
RUN echo "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" >> lakjcron
RUN echo "45 23 * * * sh /opt/lakj/dbdump.sh >> /home/lakj-backups/lakj-backup.log 2>&1\n" >> lakjcron

RUN crontab lakjcron
RUN rm lakjcron

# DB dumps will be created in this folder.
RUN mkdir /home/lakj-backups

# Command to execute Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
