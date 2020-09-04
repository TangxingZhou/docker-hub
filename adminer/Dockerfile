FROM adminer

# https://github.com/FrancoisCapon/LoginToASqlite3DatabaseWithoutCredentialsWithAdminer
COPY  fc-sqlite-connection-without-credentials.php /var/www/html/plugins
RUN mkdir -p sqlite/db
COPY adminer-4.7.7--pluginsqlite3-1.0.php sqlite/index.php

EXPOSE 8080
