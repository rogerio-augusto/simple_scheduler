class Meeting < ActiveRecord::Base
  extend SimpleCalendar
  has_calendar
  
  belongs_to :user
  delegate :name, to: :user, prefix: true, allow_nil: true
  
  validates :user, :starts_at, presence: true
  before_destroy :validate_destroy_permissions

  def can_destroy?
    @current_user = SessionData.get_current_user
    @current_user.present? && (@current_user == self.user || @current_user.admin?)
  end
  
  protected
  
    def validate_destroy_permissions
      return true if can_destroy?
      
      if @current_user.blank?
        self.errors.add(:base, I18n.t('warnings.user_audit_required'))
      elsif @current_user != self.user && !@current_user.admin?
        self.errors.add(:base, :you_shall_not_pass)
      end
      
      return false
    end
end