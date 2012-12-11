[ -f /usr/share/katello/script/cli-tests/cli-system-test ] || yum -y install katello-cli-tests

/usr/share/katello/script/cli-tests/cli-system-test all
