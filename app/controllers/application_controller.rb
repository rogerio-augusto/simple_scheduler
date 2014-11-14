class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :authenticate_user!, unless: :devise_controller?
  
  layout 'admin'

  # Helper to extract model errors formatted for flash messages
  def error_list_from(model_obj)
    model_errors = model_obj.errors.to_a.uniq
    if model_errors.present?
      if model_errors[0].is_a? Hash
        error_list = model_errors.inject("") { |message, error| message << "<li>#{error.keys.first + ' ' + error[error.keys.first].first}</li>" }
      else
        error_list = model_errors.inject("") { |message, error| message << "<li>#{error}</li>" }
      end
    end

    error_block = "<ul>#{error_list ||= ''}</ul>".html_safe
  end
end
