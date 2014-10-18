Dir["/app/app/jobs/*.rb"].each { |file| require file }

Resque.redis = $redis
