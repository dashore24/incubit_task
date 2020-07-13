class User < ApplicationRecord
  has_secure_password

  # callbacks
  before_create :assign_username
  after_create :process_welcome_email

  # validations
  validates :username, length: { minimum: Constant::MIN_USERNAME_LENGTH },
                       format: { with: Constant::USERNAME_REGEX },
                       on: :update, if: :username_changed?

  validates :email, uniqueness: true, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password, presence: true,
                       length: { minimum: Constant::MIN_PASSWORD_LENGTH }, if: :password_digest_changed?

  def process_welcome_email
    EmailWorker.perform_async(:welcome_user, email, :deliver_later)
  end

  private

  def assign_username
    self.username = email.split('@').first
  end
end
