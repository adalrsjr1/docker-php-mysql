#!/bin/sh
mkdir -p /data/log/mysql
mkdir -p /data/db/mysql/
mkdir -p /data/conf
mkdir -p /var/run/mysqld

chown -R mysql: /data /var/run/mysqld

if [ ! -f /data/conf/my.cnf ]; then
    mv /etc/mysql/my.cnf  /data/conf/my.cnf
fi

ln -sf /data/conf/my.cnf /etc/mysql/my.cnf
chmod o-r /etc/mysql/my.cnf

if [ ! -f /data/db/mysql/ibdata1 ]; then
    mysql_install_db --user=mysql --datadir="/data/db/mysql"

    /usr/bin/mysqld_safe --defaults-file=/data/conf/my.cnf  --datadir="/data/db/mysql" &
    sleep 10s

    echo "DROP USER IF EXISTS ${DB_USER};" | mysql -u root --password=""
	echo "CREATE USER '${DB_USER}'@'%';" | mysql -u root --password=""
	echo "CREATE USER '${DB_USER}'@'localhost';" | mysql -u root --password=""


    echo "GRANT ALL ON *.* TO ${DB_USER}@'%' IDENTIFIED BY '${DB_PASS}' WITH GRANT OPTION; GRANT ALL ON *.* TO ${DB_USER}@'localhost' IDENTIFIED BY '${DB_PASS}' WITH GRANT OPTION; FLUSH PRIVILEGES;" | mysql -u root --password=""

    killall mysqld
    killall mysqld_safe
    sleep 10s
    killall -9 mysqld
    killall -9 mysqld_safe
fi

mysqld_safe --user=mysql --datadir="/data/db/mysql" &

#sleep 10s

#echo "GRANT USAGE ON *.* TO 'root'@'%' IDENTIFIED BY '';" | mysql -u root --password=""
#echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '' WITH GRANT OPTION;" | mysql -u root --password=""
#echo "SET PASSWORD FOR 'root'@'%' = PASSWORD('');" | mysql -u root --password=""

