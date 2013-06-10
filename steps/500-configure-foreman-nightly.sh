puppet apply --modulepath /usr/share/foreman-installer --verbose <<EOS
\$osmajor = regsubst(\$::operatingsystemrelease, '\..*', '')
yumrepo { "foreman-nightly":
  baseurl => \$::operatingsystem ? {
    fedora  => "$MIRROR/releases/yum/foreman-nightly/Fedora/\${::operatingsystemrelease}/x86_64/",
    default => "$MIRROR/releases/yum/foreman-nightly/RHEL/\${osmajor}/x86_64/",
  },
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
