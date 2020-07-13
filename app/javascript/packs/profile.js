require('jquery-validation');
require('jquery-validation/dist/additional-methods.js');

const CONSTANT = require('./lib/constant');

$('.edit-profile').validate({
  errorElement: 'span',
  rules: {
    'user[username]': {
      required: true,
      minlength: CONSTANT.MIN_USERNAME_LENGTH,
      pattern: CONSTANT.USERNAME_PATTERN,
    },
    'user[password]': {
      required: false,
      minlength: CONSTANT.MIN_PASSWORD_LENGTH
    },
    'user[password_confirmation]': {
      equalTo : '#user_password'
    },
  },
});
