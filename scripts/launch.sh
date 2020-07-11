bundle exec rake db:migrate
cp -rf /tmp/public/* /Tokai-Onair_DB/public/
mkdir -p tmp/sockets
mkdir -p tmp/pids && bundle exec puma -C config/puma.rb
# bundle exec puma -C config/puma.rb