# required parameters:
# THE_REPO_UPGRADE

VER="$(rpm -q --queryformat '%{VERSION}' katello)"

# UPDATE REPO FILE

cat > "/etc/yum.repos.d/$THE_REPO_NAME.repo" <<EOF
[$THE_REPO_NAME]
name=$THE_REPO_NAME
baseurl=$THE_REPO_UPGRADE
enabled=1
gpgcheck=0
EOF
yum makecache

# PRE-UPGRADE STEPS

# se 1.0 - flush elasit search index
[ "$VER" == "0.1.311" ] && curl http://localhost:9200/_flush >/dev/null

# STOP THE INSTANCE

if which katello-service >/dev/null; then
  katello-service stop
else
  service katello stop 
  service katello-jobs stop 
  service httpd stop 
  service mongod stop
  service tomcat6 stop 
  service elasticsearch stop
fi

# UPGRADE RPMS

yum -y update

# PROCEED WITH UPGRADE

# se 1.0
if [ "$VER" == "0.1.311" ]; then
  yes | katello-upgrade
else
  katello-upgrade -y
fi
