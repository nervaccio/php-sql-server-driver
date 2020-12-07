#!/bin/bash
echo DOC: https://docs.microsoft.com/it-it/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver15#ubuntu17

# TODO: Choose distro release
# read -p 'Ubuntu release (ex. 16.04, 18.04, 20.04): ' ubunturelease

# TODO: Choose php release
# read -p 'PHP release (ex. 7.2, 7.3, 7.4): ' phprelease

curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

#Ubuntu 16.04
#curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

#Ubuntu 18.04
curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

#Ubuntu 20.04
#curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install msodbcsql17
# optional: for bcp and sqlcmd
sudo ACCEPT_EULA=Y apt-get install mssql-tools
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc
# optional: for unixODBC development headers
sudo apt-get install unixodbc-dev php-pear php7.4 php7.4-dev php7.4-xml

sudo pecl install sqlsrv
sudo pecl install pdo_sqlsrv
sudo printf "; priority=20\nextension=sqlsrv.so\n" > /etc/php/7.4/mods-available/sqlsrv.ini
sudo printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php/7.4/mods-available/pdo_sqlsrv.ini
sudo phpenmod -v 7.4 sqlsrv pdo_sqlsrv
