require "validator/email_validator"

class User < ApplicationRecord
  before_validation :downcase_email
  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
  # gem bcrypt
  has_secure_password

  validates :name, presence: true,
                   length: { maximum: 30, allow_blank: true }
  validates :password, presence: true,
                   length: { minimum: 8 },
                   format: {
                     with: VALID_PASSWORD_REGEX,
                     message: :invalid_password 	# 追加
                   },
                   allow_blank: true
  validates :email, presence: true,
                   email: { allow_blank: true }

  private

    # email小文字化
    def downcase_email
      self.email.downcase! if email
    end
end
