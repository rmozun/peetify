class User < ActiveRecord::Base
  has_many :pets

  validates :name, :email, presence: true
  validates :email, uniqueness: true

  after_create :send_welcome_mail

  protected
    def send_welcome_mail
      self.update_attributes(token: SecureRandom.hex(20))
      UserMailer.welcome_email(self).deliver_now
    end

end
