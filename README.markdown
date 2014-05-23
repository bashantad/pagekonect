Installation Instructions Pagekonect.com
==================
1. git clone git@github.com:bashantad/pagekonect.git
2. Go to pagekonect directory and Checkout to develop branch (git checkout -t origin/develop) 
3. Bundle all gems(bundle install)
4. Create database(bundle exec rake db:create)
5. Create all table and run migrations(bundle exec rake db:migrate)
6. Start server( rails server) and browse in localhost:3000