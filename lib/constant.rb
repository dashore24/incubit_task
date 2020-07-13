# frozen_string_literal: true

# Constant file
class Constant
  USERNAME_REGEX = /\A[a-zA-Z0-9\_]+\Z/.freeze
  MIN_USERNAME_LENGTH = 5
  MIN_PASSWORD_LENGTH = 8
  RESET_TOKEN_EXPIRE_PERIOD = 6
end
