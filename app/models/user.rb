class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  enum role: { administrator: 0, manager: 1, user: 2 }

  before_create :create_admin

  def create_admin
    return unless User.count.zero?
    self.role = 0
  end
end
