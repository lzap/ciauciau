ST=/usr/share/katello/script/cli-tests/cli-system-test
[ -f $ST ] || yum -y install katello-cli-tests

$ST all
