if [ -f /etc/fedora-release ]; then
  systemctl stop firewalld.service
  systemctl disable firewalld.service
else
  service iptables stop
  chkconfig iptables off
fi
