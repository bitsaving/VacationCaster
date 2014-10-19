VacationCaster
============

***VacationCaster scans airbnb for last minute cancellations***

[VacationCaster](http://dry-cove-4518.herokuapp.com/) helps AirBnB guests by finding them potential deals from hosts who are dealing with potentially lost revenue. The goal of this project is to bring aspects of yield management to the vacation rental marketplace. 

The heavy lifting of finding last minute cancellations is handled by background jobs. Background jobs and scheduling jobs are handled by resque and resque-scheduler, respectively. User, search, and AirBnB data is persisted with Postgres.


##Getting Started

1. Start Postgres and Redis
2. run `bundle install` to install gems
3. run `rake db:migrate` to set up Postgres
4. run `rake db:seed` to get some users, and a search of Kingman, AZ. 
5. run `rake resque:scheduler` to process schedules
6. run `rake resque:work QUEUE=*` to run background jobs
7. run `rails s` to start the server. 8. When testing the bookmarklet, use `thin start --ssl -p 3000` to enable https.


##Production

1. Deploy to Heroku.
2. Install the Redis To Go, and SendGrid addons.
3. Run `heroku run rake db:migrate` to get the DB serviceable.
5. Scale workers as needed.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request