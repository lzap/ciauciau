echo "katello" > /root/my-oauth-token-file
katello-configure --deployment=cfse $KATELLO_CONFIGURE_OPTIONS --oauth-token-file=/root/my-oauth-token-file
