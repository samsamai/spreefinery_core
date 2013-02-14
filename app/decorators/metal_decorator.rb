ActionController::Metal.class_eval do
  def current_refinery_user
    @current_refinery_user ||= env['warden'].user
  end
end