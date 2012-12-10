cat >> /root/.bashrc <<'EOF'
alias v=vim
KATELLO_CLI=$(type -P katello || type -P headpin)
alias paste="curl -F 'sprunge=<-' http://sprunge.us"
alias kconf='katello-configure -b'
alias kconf-reset='katello-configure -b --reset-data=YES'
alias cdk='cd /usr/share/katello'
alias cdf='cd /usr/share/foreman'
alias kconsole='pushd /usr/share/katello; RAILS_ENV=production rails c; popd'
alias rst='service katello restart; service katello-jobs restart'
alias rsta='katello-service restart'
alias psql-katello='sudo -u postgres psql katelloschema'
alias psql-candlepin='sudo -u postgres psql candlepin'
alias psql-foreman='sudo -u postgres psql foreman'
alias kk="$KATELLO_CLI -u admin -p admin"
alias k="$KATELLO_CLI -u admin -p admin"
alias ee="grep -iE '(err:|error|fatal|AVC)' /var/log/audit/audit.log /var/log/pulp/*log /var/log/tomcat6/catalina.out /var/log/httpd/*log /var/log/katello/katello-configure/*log /var/log/katello/*log | grep -viE '(msgid|msgstr|resteasy)'"
alias pp="$KATELLO_CLI -u admin -p admin ping"
alias gk='cd /usr/share/katello'
alias gf='cd /usr/share/foreman'
alias gkl='cd /var/log/katello'
alias gfl='cd /var/log/foreman'
alias gpl='cd /var/log/pulp'
alias gklc='cd /var/log/katello/katello-configure'
alias kst='/usr/share/katello/script/cli-tests/cli-system-test'
alias tailprod='tail -f -n400 /var/log/katello/production.log'
alias tailtom='tail -f -n400 /var/log/tomcat6/catalina.out'
alias tailpulp='tail -f -n400 /var/log/pulp/pulp.log'
alias tailgrind='tail -f -n400 /var/log/pulp/grinder.log'
alias versions='rpm -q katello katello-cli katello-agent pulp candlepin subscription-manager python-rhsm yum'

# This may not exist yet on the system because Katello might not be installed
if [ -f /etc/bash_completion.d/katello ]; then
    source /etc/bash_completion.d/katello
fi
complete -F _katello kk
complete -F _katello k
EOF

source /root/.bashrc
