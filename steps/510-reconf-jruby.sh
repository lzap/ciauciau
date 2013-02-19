VERSION=1.7.2
wget http://jruby.org.s3.amazonaws.com/downloads/$VERSION/jruby-bin-$VERSION.tar.gz
tar -xzf jruby-bin-$VERSION.tar.gz
echo "export PATH=/root/jruby-$VERSION/bin:\$PATH" >> .bashrc
source .bashrc
jruby -S gem install bundler bundler_ext activerecord-jdbcpostgresql-adapter regin
pushd /usr/share/katello
cp Gemfile.in Gemfile    
jruby -S bundle install
popd
sed "s/use_ssl:.*/use_ssl: false/" -i /etc/katello/katello.yml
echo 'pushd /usr/share/katello; RAILS_ENV=production jruby -S script/rails s -p 5000; popd' > katello-jruby.sh
chmod +x katello-jruby.sh
service katello stop
