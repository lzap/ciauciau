puppet apply --modulepath /usr/share/foreman-installer --verbose <<'EOS'
yumrepo { "foreman-nightly":
  baseurl  => "http://koji.katello.org/releases/yum/foreman-nightly/RHEL/6/x86_64/",
    gpgcheck => 0,
  } ->
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
