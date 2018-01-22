#!/bin/sh

# Atribuição de crédito!
# Arquivo baseado no original startup.sh de wangxian/alpine-mysql (Github)

if [ ! -d /var/lib/mysql/mysql ]; then

  echo "=> Criando diretório de dados..."

  mysql_install_db --user=root > /dev/null

  MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-"root"}
  MYSQL_DATABASE=${MYSQL_DATABASE:-""}
  MYSQL_USER=${MYSQL_USER:-""}
  MYSQL_PORT=${MYSQL_PORT:-"3306"}
  MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}
  CHARACTER_SET_SERVER=${CHARACTER_SET_SERVER:-"utf8"}
  COLLATION_SERVER=${COLLATION_SERVER:-"utf8_unicode_ci"}

  sed -i "s/3306/$MYSQL_PORT/" /etc/mysql/my.cnf
  sed -i "s/utf8/$CHARACTER_SET_SERVER/" /etc/mysql/my.cnf
  sed -i "s/utf8_unicode_ci/$COLLATION_SERVER/" /etc/mysql/my.cnf

  tfile=`mktemp`

  cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY "$MYSQL_ROOT_PASSWORD" WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
UPDATE user SET password=PASSWORD("") WHERE user='root' AND host='localhost';
EOF

  if [ "$MYSQL_DATABASE" != "" ]; then
    echo "=> Criando banco: $MYSQL_DATABASE"
    echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile

    if [ "$MYSQL_USER" != "" ]; then
      echo "=> Criando usuário: $MYSQL_USER com a senha: $MYSQL_PASSWORD"
      echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
    fi
  fi

  /usr/bin/mysqld --user=root --bootstrap --verbose=0 < $tfile
  rm -f $tfile
fi

exec /usr/bin/mysqld --user=root --console