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

  def create_password_reset_token
    update(reset_password_token: token, reset_password_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    EmailWorker.perform_async(:reset_password, email, :deliver_later)
  end

  def password_reset_token_expired?
    reset_password_sent_at < Constant::RESET_TOKEN_EXPIRE_PERIOD.hours.ago
  end

  def authenticate?(password)
    authenticate(password)
  end

  private

  def assign_username
    self.username = email.split('@').first
  end

  def token
    loop do
      generated_token = SecureRandom.urlsafe_base64
      return generated_token unless User.exists?(reset_password_token: generated_token)
    end
  end
end
