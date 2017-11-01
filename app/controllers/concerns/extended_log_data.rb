module Concerns::ExtendedLogData
  extend ActiveSupport::Concern

  def append_info_to_payload(payload)
    super
    payload[:host]       = ENV.fetch('HOST', Socket.gethostname)
    payload[:ip]         = request.remote_ip
    payload[:pid]        = Process.pid
    payload[:uid]        = nil # No devise/warden
    payload[:ua]         = request.user_agent
  end
end
