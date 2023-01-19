class User < ApplicationRecord
  has_secure_password

  before_validation :downcase_userdata

  private

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 40 },
            format: { with: /\A\w+\z/ }
  validates :headcolor, format: { with: /\A#([[:xdigit:]]{3}){1,2}\z/i }

  def downcase_userdata
    nickname.downcase!
    email.downcase!
  end
end
