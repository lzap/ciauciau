ST=/usr/share/katello/script/cli-tests/cli-system-test
[ -f $ST ] || yum -y install katello-cli-tests

# execute few test without cleaning database to fill it
$ST -c all
