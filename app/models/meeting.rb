class Meeting < ActiveRecord::Base
  extend SimpleCalendar
  has_calendar
  
  belongs_to :user
  delegate :name, to: :user, prefix: true, allow_nil: true
  
  validates :user, :starts_at, presence: true
  before_destroy :validate_destroy_permissions

  def can_destroy?
    current_session_user.present? && is_current_session_user_owned?
  end
  
  protected
  
    def current_session_user
      @current_user ||= SessionData.get_current_user
      @current_user
    end
    
    def is_current_session_user_owned?
      current_session_user == self.user || current_session_user.admin?
    end
  
    def validate_destroy_permissions
      return true if can_destroy?
      
      if current_session_user.blank?
        self.errors.add(:base, I18n.t('warnings.user_audit_required'))
      elsif !is_current_session_user_owned?
        self.errors.add(:base, :you_shall_not_pass)
      end
      
      return false
    end
end