#!/bin/bash

cat > /etc/stunnel/stunnel.conf <<EOF
[rsync]
accept = 873
client = yes
connect = $WEDOS_SERVER
EOF


while true
do
  service stunnel4 restart
  mysqldump -u$MYSQL_ENV_DB_USER -p$MYSQL_ENV_DB_PASS -h $MYSQL_PORT_3306_TCP_ADDR $MYSQL_ENV_DB_NAME | gzip > /backup.sql.gz
  gpg --keyserver pgp.mit.edu --recv-key 892D3F52
  gpg --encrypt --recipient stanislav.stipl@gmail.com --yes --always-trust backup.sql.gz
  rsync -a -R /backup.sql.gz.gpg rsync://$WEDOS_USER@localhost/$WEDOS_USER/$WEDOS_FILENAME-`date +%Y-%m-%d_%H:%M`.sql.gz
  sleep +$WEDOS_INTERVAL
done
