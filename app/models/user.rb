class User < ApplicationRecord
  has_many :places
  has_many :purchases
  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  before_destroy :admin_protection

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: { in: 6..50 }

  validates :password,
            presence: true,
            confirmation: true,
            length: { in: 6..32 },
            if: -> (m) { !m.password.nil? }
  validates :email,
            presence: true,
            length: { in: 6..250 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  scope :cooks, -> () { where(cook: true) }

  def first_name
    name.split.ferst
  end

  def last_name
    name.split.last
  end

  def self.find_from_omniauth(auth)
    return false unless auth.info.email

    user = User.find_or_initialize_by(email: auth.info.email)

    user.email = auth.info.email
    user.name ||= auth.info.name

    user.google_access_token = auth.credentials.token
    user.google_refresh_token = auth.credentials.refresh_token
    user.password = user.password_confirmation = SecureRandom.base64(12) if user.id.nil?

    user.save!
    user
  end

  def admin_protection
    throw(:abort) if self.admin?
  end

end
