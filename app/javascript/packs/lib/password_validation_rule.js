const CONSTANT = require('./constant');

const passwordValidationRule = {
  'user[password]': {
    required: true,
    minlength: CONSTANT.MIN_PASSWORD_LENGTH
  },
  'user[password_confirmation]': {
    equalTo : '#user_password'
  },
}

module.exports = passwordValidationRule;
