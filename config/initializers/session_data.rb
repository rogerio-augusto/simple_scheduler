module SessionData  
  def self.set_current_user(current_user)
    Thread.current[:user] = current_user
  end
  
  def self.get_current_user
    Thread.current[:user]
  end
end