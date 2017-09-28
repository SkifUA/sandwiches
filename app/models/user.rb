class User < ApplicationRecord
  has_many :places
  has_many :purchases
  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  validates_presence_of :name

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

end
