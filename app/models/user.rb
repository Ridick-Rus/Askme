class User < ApplicationRecord
  has_secure_password

  has_many :questions, dependent: :destroy

  before_validation :downcase_userdata

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 40 },
  format: { with: /\A\w+\z/ }
  validates :headcolor, allow_blank: true, format: { with: /\A#[0-9a-f]{6}\z/i }

  private

  def downcase_userdata
    nickname.downcase!
    email.downcase!
  end
end
