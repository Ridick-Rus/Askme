class User < ApplicationRecord
  has_secure_password

  include Gravtastic
  gravtastic(secure: true, filetype: :png, size: 100, default: 'retro')

  has_many :questions, dependent: :destroy

  before_validation :downcase_userdata

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :nickname, presence: true, uniqueness: true, length: { maximum: 40 },
            format: { with: /\A\w+\z/ }

  validates :headcolor, format: { with: /\A#(\h{3}){1,2}\z/ }

  def downcase_userdata
    nickname&.downcase!
    email&.downcase!
  end

  def to_param
    nickname
  end
end
