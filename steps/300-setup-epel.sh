REDHAT_VERSION=$(rpm -q --queryformat '%{VERSION}' redhat-release-server)

if [ "$REDHAT_VERSION" == "6Server" ]; then
cat > /etc/yum.repos.d/epel.repo <<EOF
[epel]
name=epel
baseurl=$EPEL/6/\$basearch
enabled=1
gpgcheck=0
EOF
fi
