#!/usr/bin/env sh
set -e

GERRIT_HOME=/var/gerrit
GERRIT_SITE=${GERRIT_HOME}/review_site
GERRIT_WAR=${GERRIT_HOME}/gerrit.war
GERRIT_VERSION=2.14.6
GERRIT_USER=root
GERRIT_INIT_ARGS=""
AUTH_TYPE=HTTP
GERRIT_INIT_ARGS='--install-plugin=download-commands'
GITWEB_TYPE=gitiles
SMTP_CONNECT_TIMEOUT=10sec
SMTP_ENCRYPTION=ssl
SMTP_FROM=tyson.zhang@citybrandhk.com
SMTP_PASS=Cbjiejin264
SMTP_SERVER=smtp.citybrandhk.com
SMTP_SERVER_PORT=465
SMTP_USER=tyson.zhang@citybrandhk.com
WEBURL=https://code.lordyung.com/
HTTPD_LISTENURL=proxy-https://127.0.0.1:8080/
USER_NAME=lordyung
USER_EMAIL=jiejin264@qq.com
LISTEN_ADDR=*:22
ADVERTISED_ADDR=code.lordyung.com
PASSWORD_FILE=/etc/nginx/gerrit_password


set_gerrit_config() {
    git config -f "${GERRIT_SITE}/etc/gerrit.config" "$@"
}

set_secure_config() {
    git config -f "${GERRIT_SITE}/etc/secure.config" "$@"
}

wait_for_database() {
    echo "Waiting for database connection $1:$2 ..."
    until nc -z $1 $2; do
        sleep 1
    done

    # Wait to avoid "panic: Failed to open sql connection pq: the database system is starting up"
    sleep 1
}

# Add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
# adduser -D -h "${GERRIT_HOME}" -g "Gerrit User" -s /sbin/nologin "${GERRIT_USER}"

# apt update
# apt install -y gitweb procmail

# mkdir /docker-entrypoint-init.d

# Download gerrit.war

if [ ! -f $password_file  ]; then
    touch $password_file
fi

htpasswd -bm $password_file lordyung jiejin264
htpasswd -bm $password_file gerrit grjiejin264

if [ ! -f  $GERRIT_WAR ];then
    echo  Downloading gerrit.war...
    echo curl -fSsL  http://ot2jmekaj.bkt.clouddn.com/gerrit-${GERRIT_VERSION}.war -o $GERRIT_WAR
fi
# Download Plugins

[ ! -f ${GERRIT_HOME}/delete-project.jar ] \
    && curl -fSsL http://ot2jmekaj.bkt.clouddn.com/delete-project.jar -o ${GERRIT_HOME}/delete-project.jar
[ ! -f ${GERRIT_HOME}/events-log.jar ] \
    && curl -fSsL http://ot2jmekaj.bkt.clouddn.com/events-log.jar -o ${GERRIT_HOME}/events-log.jar
[ ! -f ${GERRIT_HOME}/gitiles.jar ] \
    && curl -fSsL http://ot2jmekaj.bkt.clouddn.com/gitiles.jar -o ${GERRIT_HOME}/gitiles.jar
[ ! -f ${GERRIT_HOME}/gerrit-oauth-provider.jar ] \
    && curl -fSsL http://ot2jmekaj.bkt.clouddn.com/gerrit-oauth-provider.jar -o ${GERRIT_HOME}/gerrit-oauth-provider.jar
[ ! -f ${GERRIT_HOME}/importer.jar ] \
    && curl -fSsL http://ot2jmekaj.bkt.clouddn.com/importer.jar -o ${GERRIT_HOME}/importer.jar

if [ -f ${GERRIT_SITE}/bin/gerrit.sh ]; then
    ${GERRIT_SITE}/bin/gerrit.sh stop
fi

rm -rf ${GERRIT_SITE}
mkdir -p $GERRIT_SITE

if [ -n "${JAVA_HEAPLIMIT}" ]; then
    JAVA_MEM_OPTIONS="-Xmx${JAVA_HEAPLIMIT}"
fi

# If you're mounting ${GERRIT_SITE} to your host, you this will default to root.
# This obviously ensures the permissions are set correctly for when gerrit starts.
find "${GERRIT_SITE}/" ! -user `id -u ${GERRIT_USER}` -exec chown ${GERRIT_USER} {} \;

# Initialize Gerrit if ${GERRIT_SITE}/git is empty.
if [ ! -d ${GERRIT_SITE}/git/All-Projects.git ]; then
    echo "First time initialize gerrit..."
    java ${JAVA_OPTIONS} ${JAVA_MEM_OPTIONS} -jar "${GERRIT_WAR}" init --batch --no-auto-start -d "${GERRIT_SITE}" ${GERRIT_INIT_ARGS}
    [ ${#DATABASE_TYPE} -gt 0 ] && rm -rf "${GERRIT_SITE}/git"
fi

# Install external plugins
cp -f ${GERRIT_HOME}/delete-project.jar ${GERRIT_SITE}/plugins/delete-project.jar
cp -f ${GERRIT_HOME}/events-log.jar ${GERRIT_SITE}/plugins/events-log.jar
cp -f ${GERRIT_HOME}/importer.jar ${GERRIT_SITE}/plugins/importer.jar

#Customize gerrit.config

#Section gerrit
[ -z "${WEBURL}" ] || set_gerrit_config gerrit.canonicalWebUrl "${WEBURL}"
[ -z "${GITHTTPURL}" ] || set_gerrit_config gerrit.gitHttpUrl "${GITHTTPURL}"

#Section sshd
[ -z "${LISTEN_ADDR}" ] || set_gerrit_config sshd.listenAddress "${LISTEN_ADDR}"
[ -z "${ADVERTISED_ADDR}" ] || set_gerrit_config sshd.advertisedAddress "${ADVERTISED_ADDR}"



#Section database
if [ "${DATABASE_TYPE}" = 'mysql' ]; then
    set_gerrit_config database.type "${DATABASE_TYPE}"
    [ -z "${DB_PORT_3306_TCP_ADDR}" ] || set_gerrit_config database.hostname "${DB_PORT_3306_TCP_ADDR}"
    [ -z "${DB_PORT_3306_TCP_PORT}" ] || set_gerrit_config database.port "${DB_PORT_3306_TCP_PORT}"
    [ -z "${DB_ENV_MYSQL_DB}" ]       || set_gerrit_config database.database "${DB_ENV_MYSQL_DB}"
    [ -z "${DB_ENV_MYSQL_USER}" ]     || set_gerrit_config database.username "${DB_ENV_MYSQL_USER}"
    [ -z "${DB_ENV_MYSQL_PASSWORD}" ] || set_secure_config database.password "${DB_ENV_MYSQL_PASSWORD}"
fi

#Section auth
[ -z "${AUTH_TYPE}" ]                  || set_gerrit_config auth.type "${AUTH_TYPE}"
[ -z "${AUTH_HTTP_HEADER}" ]           || set_gerrit_config auth.httpHeader "${AUTH_HTTP_HEADER}"
[ -z "${AUTH_EMAIL_FORMAT}" ]          || set_gerrit_config auth.emailFormat "${AUTH_EMAIL_FORMAT}"
if [ -z "${AUTH_GIT_BASIC_AUTH_POLICY}" ]; then
    case "${AUTH_TYPE}" in
        LDAP|LDAP_BIND)
            set_gerrit_config auth.gitBasicAuthPolicy "LDAP"
            ;;
        HTTP|HTTP_LDAP)
            set_gerrit_config auth.gitBasicAuthPolicy "${AUTH_TYPE}"
            ;;
        *)
    esac
else
    set_gerrit_config auth.gitBasicAuthPolicy "${AUTH_GIT_BASIC_AUTH_POLICY}"
fi

# Set OAuth provider
if [ "${AUTH_TYPE}" = 'OAUTH' ]; then
    [ -z "${AUTH_GIT_OAUTH_PROVIDER}" ] || set_gerrit_config auth.gitOAuthProvider "${AUTH_GIT_OAUTH_PROVIDER}"
fi

if [ -z "${AUTH_TYPE}" ] || [ "${AUTH_TYPE}" = 'OpenID' ] || [ "${AUTH_TYPE}" = 'OpenID_SSO' ]; then
    [ -z "${AUTH_ALLOWED_OPENID}" ] || set_gerrit_config auth.allowedOpenID "${AUTH_ALLOWED_OPENID}"
    [ -z "${AUTH_TRUSTED_OPENID}" ] || set_gerrit_config auth.trustedOpenID "${AUTH_TRUSTED_OPENID}"
    [ -z "${AUTH_OPENID_DOMAIN}" ]  || set_gerrit_config auth.openIdDomain "${AUTH_OPENID_DOMAIN}"
fi

#Section ldap
if [ "${AUTH_TYPE}" = 'LDAP' ] || [ "${AUTH_TYPE}" = 'LDAP_BIND' ] || [ "${AUTH_TYPE}" = 'HTTP_LDAP' ]; then
    [ -z "${LDAP_SERVER}" ]                   || set_gerrit_config ldap.server "${LDAP_SERVER}"
    [ -z "${LDAP_SSLVERIFY}" ]                || set_gerrit_config ldap.sslVerify "${LDAP_SSLVERIFY}"
    [ -z "${LDAP_GROUPSVISIBLETOALL}" ]       || set_gerrit_config ldap.groupsVisibleToAll "${LDAP_GROUPSVISIBLETOALL}"
    [ -z "${LDAP_USERNAME}" ]                 || set_gerrit_config ldap.username "${LDAP_USERNAME}"
    [ -z "${LDAP_PASSWORD}" ]                 || set_secure_config ldap.password "${LDAP_PASSWORD}"
    [ -z "${LDAP_REFERRAL}" ]                 || set_gerrit_config ldap.referral "${LDAP_REFERRAL}"
    [ -z "${LDAP_READTIMEOUT}" ]              || set_gerrit_config ldap.readTimeout "${LDAP_READTIMEOUT}"
    [ -z "${LDAP_ACCOUNTBASE}" ]              || set_gerrit_config ldap.accountBase "${LDAP_ACCOUNTBASE}"
    [ -z "${LDAP_ACCOUNTSCOPE}" ]             || set_gerrit_config ldap.accountScope "${LDAP_ACCOUNTSCOPE}"
    [ -z "${LDAP_ACCOUNTPATTERN}" ]           || set_gerrit_config ldap.accountPattern "${LDAP_ACCOUNTPATTERN}"
    [ -z "${LDAP_ACCOUNTFULLNAME}" ]          || set_gerrit_config ldap.accountFullName "${LDAP_ACCOUNTFULLNAME}"
    [ -z "${LDAP_ACCOUNTEMAILADDRESS}" ]      || set_gerrit_config ldap.accountEmailAddress "${LDAP_ACCOUNTEMAILADDRESS}"
    [ -z "${LDAP_ACCOUNTSSHUSERNAME}" ]       || set_gerrit_config ldap.accountSshUserName "${LDAP_ACCOUNTSSHUSERNAME}"
    [ -z "${LDAP_ACCOUNTMEMBERFIELD}" ]       || set_gerrit_config ldap.accountMemberField "${LDAP_ACCOUNTMEMBERFIELD}"
    [ -z "${LDAP_FETCHMEMBEROFEAGERLY}" ]     || set_gerrit_config ldap.fetchMemberOfEagerly "${LDAP_FETCHMEMBEROFEAGERLY}"
    [ -z "${LDAP_GROUPBASE}" ]                || set_gerrit_config ldap.groupBase "${LDAP_GROUPBASE}"
    [ -z "${LDAP_GROUPSCOPE}" ]               || set_gerrit_config ldap.groupScope "${LDAP_GROUPSCOPE}"
    [ -z "${LDAP_GROUPPATTERN}" ]             || set_gerrit_config ldap.groupPattern "${LDAP_GROUPPATTERN}"
    [ -z "${LDAP_GROUPMEMBERPATTERN}" ]       || set_gerrit_config ldap.groupMemberPattern "${LDAP_GROUPMEMBERPATTERN}"
    [ -z "${LDAP_GROUPNAME}" ]                || set_gerrit_config ldap.groupName "${LDAP_GROUPNAME}"
    [ -z "${LDAP_LOCALUSERNAMETOLOWERCASE}" ] || set_gerrit_config ldap.localUsernameToLowerCase "${LDAP_LOCALUSERNAMETOLOWERCASE}"
    [ -z "${LDAP_AUTHENTICATION}" ]           || set_gerrit_config ldap.authentication "${LDAP_AUTHENTICATION}"
    [ -z "${LDAP_USECONNECTIONPOOLING}" ]     || set_gerrit_config ldap.useConnectionPooling "${LDAP_USECONNECTIONPOOLING}"
    [ -z "${LDAP_CONNECTTIMEOUT}" ]           || set_gerrit_config ldap.connectTimeout "${LDAP_CONNECTTIMEOUT}"
fi

#Section OAUTH general
if [ "${AUTH_TYPE}" = 'OAUTH' ]  ; then
    cp -f ${GERRIT_HOME}/gerrit-oauth-provider.jar ${GERRIT_SITE}/plugins/gerrit-oauth-provider.jar
    [ -z "${OAUTH_ALLOW_EDIT_FULL_NAME}" ] \
        || set_gerrit_config oauth.allowEditFullName "${OAUTH_ALLOW_EDIT_FULL_NAME}"
    [ -z "${OAUTH_ALLOW_REGISTER_NEW_EMAIL}" ] \
        || set_gerrit_config oauth.allowRegisterNewEmail "${OAUTH_ALLOW_REGISTER_NEW_EMAIL}"

    # Google
    [ -z "${OAUTH_GOOGLE_RESTRICT_DOMAIN}" ] \
        || set_gerrit_config plugin.gerrit-oauth-provider-google-oauth.domain "${OAUTH_GOOGLE_RESTRICT_DOMAIN}"
    [ -z "${OAUTH_GOOGLE_CLIENT_ID}" ] \
        || set_gerrit_config plugin.gerrit-oauth-provider-google-oauth.client-id "${OAUTH_GOOGLE_CLIENT_ID}"
    [ -z "${OAUTH_GOOGLE_CLIENT_SECRET}" ] \
        || set_gerrit_config plugin.gerrit-oauth-provider-google-oauth.client-secret "${OAUTH_GOOGLE_CLIENT_SECRET}"
    [ -z "${OAUTH_GOOGLE_LINK_OPENID}" ] \
        || set_gerrit_config plugin.gerrit-oauth-provider-google-oauth.link-to-existing-openid-accounts "${OAUTH_GOOGLE_LINK_OPENID}"
    [ -z "${OAUTH_GOOGLE_USE_EMAIL_AS_USERNAME}" ] \
        || set_gerrit_config plugin.gerrit-oauth-provider-google-oauth.use-email-as-username "${OAUTH_GOOGLE_USE_EMAIL_AS_USERNAME}"

    # Github
    [ -z "${OAUTH_GITHUB_CLIENT_ID}" ] \
        || set_gerrit_config plugin.gerrit-oauth-provider-github-oauth.client-id "${OAUTH_GITHUB_CLIENT_ID}"
    [ -z "${OAUTH_GITHUB_CLIENT_SECRET}" ] \
        || set_gerrit_config plugin.gerrit-oauth-provider-github-oauth.client-secret "${OAUTH_GITHUB_CLIENT_SECRET}"

    # GitLab
    [ -z "${OAUTH_GITLAB_ROOT_URL}" ] \
        || set_gerrit_config plugin.gerrit-oauth-provider-gitlab-oauth.root-url "${OAUTH_GITLAB_ROOT_URL}"
    [ -z "${OAUTH_GITLAB_CLIENT_ID}" ] \
        || set_gerrit_config plugin.gerrit-oauth-provider-gitlab-oauth.client-id "${OAUTH_GITLAB_CLIENT_ID}"
    [ -z "${OAUTH_GITLAB_CLIENT_SECRET}" ] \
        || set_gerrit_config plugin.gerrit-oauth-provider-gitlab-oauth.client-secret "${OAUTH_GITLAB_CLIENT_SECRET}"
    # Bitbucket
    [ -z "${OAUTH_BITBUCKET_CLIENT_ID}" ] \
        || set_gerrit_config plugin.gerrit-oauth-provider-bitbucket-oauth.client-id "${OAUTH_BITBUCKET_CLIENT_ID}"
    [ -z "${OAUTH_BITBUCKET_CLIENT_SECRET}" ] \
        || set_gerrit_config plugin.gerrit-oauth-provider-bitbucket-oauth.client-secret "${OAUTH_BITBUCKET_CLIENT_SECRET}"
    [ -z "${OAUTH_BITBUCKET_FIX_LEGACY_USER_ID}"] \
        || set_gerrit_config plugin.gerrit-oauth-provider-bitbucket-oauth.fix-legacy-user-id "${OAUTH_BITBUCKET_FIX_LEGACY_USER_ID}"
fi

#Section container
[ -z "${JAVA_HEAPLIMIT}" ] || set_gerrit_config container.heapLimit "${JAVA_HEAPLIMIT}"
[ -z "${JAVA_OPTIONS}" ]   || set_gerrit_config container.javaOptions "${JAVA_OPTIONS}"
[ -z "${JAVA_SLAVE}" ]     || set_gerrit_config container.slave "${JAVA_SLAVE}"

#Section sendemail
if [ -z "${SMTP_SERVER}" ]; then
    set_gerrit_config sendemail.enable false
else
    set_gerrit_config sendemail.enable true
    set_gerrit_config sendemail.smtpServer "${SMTP_SERVER}"
    [ -z "${SMTP_SERVER_PORT}" ] || set_gerrit_config sendemail.smtpServerPort "${SMTP_SERVER_PORT}"
    [ -z "${SMTP_USER}" ]        || set_gerrit_config sendemail.smtpUser "${SMTP_USER}"
    [ -z "${SMTP_PASS}" ]        || set_secure_config sendemail.smtpPass "${SMTP_PASS}"
    [ -z "${SMTP_ENCRYPTION}" ]      || set_gerrit_config sendemail.smtpEncryption "${SMTP_ENCRYPTION}"
    [ -z "${SMTP_CONNECT_TIMEOUT}" ] || set_gerrit_config sendemail.connectTimeout "${SMTP_CONNECT_TIMEOUT}"
    [ -z "${SMTP_FROM}" ]            || set_gerrit_config sendemail.from "${SMTP_FROM}"
fi

#Section user
[ -z "${USER_NAME}" ]             || set_gerrit_config user.name "${USER_NAME}"
[ -z "${USER_EMAIL}" ]            || set_gerrit_config user.email "${USER_EMAIL}"
[ -z "${USER_ANONYMOUS_COWARD}" ] || set_gerrit_config user.anonymousCoward "${USER_ANONYMOUS_COWARD}"

#Section plugins
set_gerrit_config plugins.allowRemoteAdmin true

#Section plugin events-log
set_gerrit_config plugin.events-log.storeUrl "jdbc:h2:${GERRIT_SITE}/db/ChangeEvents"

# Section httpd
[ -z "${HTTPD_LISTENURL}" ] || set_gerrit_config httpd.listenUrl "${HTTPD_LISTENURL}"

# Section gitweb

if [ ${GITWEB_TYPE} = 'gitiles' ]; then
    cp -f $GERRIT_HOME/gitiles.jar $GERRIT_SITE/plugins/gitiles.jar
else
    export GITWEB_TYPE=gitweb
fi

set_gerrit_config gitweb.cgi "/usr/share/gitweb/gitweb.cgi"
set_gerrit_config gitweb.type "$GITWEB_TYPE"


case "${DATABASE_TYPE}" in
    postgresql) wait_for_database ${DB_PORT_5432_TCP_ADDR} ${DB_PORT_5432_TCP_PORT} ;;
    mysql)      wait_for_database ${DB_PORT_3306_TCP_ADDR} ${DB_PORT_3306_TCP_PORT} ;;
    *)          ;;
esac

echo "Upgrading gerrit..."
java ${JAVA_OPTIONS} ${JAVA_MEM_OPTIONS} -jar "${GERRIT_WAR}" init --batch -d "${GERRIT_SITE}" ${GERRIT_INIT_ARGS}
if [ $? -eq 0 ]; then
    GERRIT_VERSIONFILE="${GERRIT_SITE}/gerrit_version"

    if [ -n "${IGNORE_VERSIONCHECK}" ]; then
        echo "Don't perform a version check and never do a full reindex"
        NEED_REINDEX=0
    else
        # check whether its a good idea to do a full upgrade
        NEED_REINDEX=1
        echo "Checking version file ${GERRIT_VERSIONFILE}"
        if [ -f "${GERRIT_VERSIONFILE}" ]; then
            OLD_GERRIT_VER="V$(cat ${GERRIT_VERSIONFILE})"
            GERRIT_VER="V${GERRIT_VERSION}"
            echo " have old gerrit version ${OLD_GERRIT_VER}"
            if [ "${OLD_GERRIT_VER}" == "${GERRIT_VER}" ]; then
                echo " same gerrit version, no upgrade necessary ${OLD_GERRIT_VER} == ${GERRIT_VER}"
                NEED_REINDEX=0
            else
                echo " gerrit version mismatch #${OLD_GERRIT_VER}# != #${GERRIT_VER}#"
            fi
        else
            echo " gerrit version file does not exist, upgrade necessary"
        fi
    fi
    if [ ${NEED_REINDEX} -eq 1 ]; then
        echo "Reindexing..."
        java ${JAVA_OPTIONS} ${JAVA_MEM_OPTIONS} -jar "${GERRIT_WAR}" reindex --verbose -d "${GERRIT_SITE}"
        if [ $? -eq 0 ]; then
            echo "Upgrading is OK. Writing versionfile ${GERRIT_VERSIONFILE}"
            echo "${GERRIT_VERSION}" > "${GERRIT_VERSIONFILE}"
            echo "${GERRIT_VERSIONFILE} written."
        else
            echo "Upgrading fail!"
        fi
    fi
else
    echo "Something wrong..."
    cat "${GERRIT_SITE}/logs/error_log"
fi

${GERRIT_SITE}/bin/gerrit.sh start
