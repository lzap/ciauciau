echo "katello" > /root/my-oauth-token-file

#KATELLO_VER=$(rpm -q --queryformat '%{VERSION}' katello)

katello-configure $KATELLO_CONFIGURE_OPTIONS --oauth-token-file=/root/my-oauth-token-file --user-pass=admin
