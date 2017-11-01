Rails.application.configure do
  config.lograge.enabled   = true

  config.lograge.formatter = Lograge::Formatters::Json.new

  config.lograge.custom_options = lambda do |event|
    params = event.payload[:params].reject do |k|
      ['controller', 'action'].include? k
    end

    base = {
      uid:    event.payload[:uid],
      ip:     event.payload[:ip],
      host:   event.payload[:host],
      pid:    event.payload[:pid],
      sql:    event.payload[:db_query_count],
      params: params
    }
  end
end

# Mute everything but the "perform_start event for ActiveJob"
ActiveSupport.on_load :active_job do
  class ActiveJob::Logging::LogSubscriber
    def enqueue_at(job)
    end

    def enqueue(job)
    end

    def perform(job)
    end
  end
end
