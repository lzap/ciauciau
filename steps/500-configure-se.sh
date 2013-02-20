echo "katello" > /root/my-oauth-token-file

KATELLO_VER=$(rpm -q --queryformat '%{VERSION}' katello)

# various se versions support different parameters
if [[ $KATELLO_VER =~ ^0.1.311 ]]; then
  katello-configure --deployment=cfse
elif [[ $KATELLO_VER =~ ^1.1.12 ]]; then
  katello-configure --deployment=cfse $KATELLO_CONFIGURE_OPTIONS --oauth-token-file=/root/my-oauth-token-file
else
  katello-configure --deployment=cfse $KATELLO_CONFIGURE_OPTIONS --oauth-token-file=/root/my-oauth-token-file --user-pass=admin
fi

