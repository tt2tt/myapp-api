class User < ApplicationRecord
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
end
