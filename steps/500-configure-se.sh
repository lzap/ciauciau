echo "katello" > /root/my-oauth-token-file

# se 1.0 does not support many configuration options
if [ "$(rpm -q --queryformat '%{VERSION}' katello)" == "0.1.311" ]; then
  katello-configure --deployment=cfse
else
  # for all other versions use generic configuration
  katello-configure --deployment=cfse $KATELLO_CONFIGURE_OPTIONS --oauth-token-file=/root/my-oauth-token-file
fi

