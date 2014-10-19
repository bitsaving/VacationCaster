Dir["/app/app/jobs/*.rb"].each { |file| require file }

Resque.redis = $redis
Resque.redis.namespace = "vacaycaster"
Resque.schedule = YAML.load_file(Rails.root.join('config', 'resque_schedule.yml'))
