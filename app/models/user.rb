class User < ActiveRecord::Base
  has_secure_password

  has_many :events, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :attends, dependent: :destroy
  has_many :attending, through: :attends, source: :event

  email_validate = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :city, presence: true
  validates :email, presence: true, uniqueness: true, format: {with: email_validate}

  before_save :downcase_email
  
  def downcase_email
      self.email.downcase!
  end
end
