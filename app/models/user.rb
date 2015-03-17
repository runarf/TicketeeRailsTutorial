class User < ActiveRecord::Base
  before_create :generate_token
  
  has_secure_password
  validates :email, presence: true
  has_many :permissions
  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end

  private

  def generate_token
    self.token = SecureRandom.uuid
  end
end
