FEDORA_VERSION=$(rpm -q --queryformat '%{VERSION}' fedora-release)
REDHAT_VERSION=$(rpm -q --queryformat '%{VERSION}' redhat-release-server)

if [ -f /etc/fedora-release ]; then
cat > /etc/yum.repos.d/candlepin.repo <<EOF
[candlepin]
name=candlepin
baseurl=$CANDLEPIN_REPO_BASEURL/Fedora/\$releasever/\$basearch/
enabled=1
gpgcheck=0
EOF
cat > /etc/yum.repos.d/pulp.repo <<EOF
[pulp]
name=pulp
baseurl=$PULP_REPO_BASEURL/Fedora/\$releasever/\$basearch/
enabled=1
gpgcheck=0
EOF
cat > /etc/yum.repos.d/foreman.repo <<EOF
[foreman]
name=foreman
baseurl=$FOREMAN_REPO_BASEURL/Fedora/\$releasever/\$basearch/
enabled=1
gpgcheck=0
EOF
cat > /etc/yum.repos.d/katello.repo <<EOF
[katello]
name=katello
baseurl=$KATELLO_REPO_BASEURL/Fedora/\$releasever/\$basearch/
enabled=1
gpgcheck=0
EOF
fi

if [ "$REDHAT_VERSION" == "6Server" ]; then
cat > /etc/yum.repos.d/candlepin.repo <<EOF
[candlepin]
name=candlepin
baseurl=$CANDLEPIN_REPO_BASEURL/RHEL/6/\$basearch/
enabled=1
gpgcheck=0
EOF
cat > /etc/yum.repos.d/pulp.repo <<EOF
[pulp]
name=pulp
baseurl=$PULP_REPO_BASEURL/RHEL/6/\$basearch/
enabled=1
gpgcheck=0
EOF
cat > /etc/yum.repos.d/foreman.repo <<EOF
[foreman]
name=foreman
baseurl=$FOREMAN_REPO_BASEURL/RHEL/6/\$basearch/
enabled=1
gpgcheck=0
EOF
cat > /etc/yum.repos.d/katello.repo <<EOF
[katello]
name=katello
baseurl=$KATELLO_REPO_BASEURL/RHEL/6/\$basearch/
enabled=1
gpgcheck=0
EOF
fi

yum makecache
