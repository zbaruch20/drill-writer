module UserHelper
  # Regex constants
  EMAIL_REGEX ||= URI::MailTo::EMAIL_REGEXP
  PASSWORD_REGEX ||= /\A(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%\^&*()\-=_+\[\]{}\\|;:'",.\/<>?`~])\S{8,}\z/.freeze
end
