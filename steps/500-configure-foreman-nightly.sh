# this file is installed by foreman-release rpm
rm -f /etc/yum.repos.d/foreman.repo

# there is a bug in puppet - must configure this manually
if [ -f /etc/fedora-release ]; then
cat > /etc/yum.repos.d/foreman-nightly.repo <<EOS
[foreman-nightly]
baseurl=$MIRROR/releases/yum/foreman-nightly/Fedora/\$releasever/x86_64/
gpgcheck=0
EOS
else
cat > /etc/yum.repos.d/foreman-nightly.repo <<EOS
[foreman-nightly]
baseurl=$MIRROR/releases/yum/foreman-nightly/RHEL/6/x86_64/
gpgcheck=0
EOS
fi

puppet apply --modulepath /usr/share/foreman-installer --verbose <<EOS
class {'puppet':
} ->
class {'puppet::server':
} ->
class {'foreman_proxy':
  custom_repo => true,
} ->
class {'foreman':
  custom_repo => true,
}
EOS
