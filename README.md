Chinese School System (cclswalnut)
----------------
based on Ruby on Rails



<h3>Heroku</h3>
<h5>Precompile Assets</h5>
`````
$ RAILS_ENV=production bundle exec rake assets:precompile
`````
<h5>Git</h5>
`````
git init
git add .
git commit -m "comment"
heroku git:remote -a [AppName]
git push heroku master
heroku run rake db:migrate
heroku restart
heroku open
`````
