ENV["REDISTOGO_URL"] ||= "redis://localhost/"

uri = URI.parse(ENV["REDISTOGO_URL"])
$redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)
