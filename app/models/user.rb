class User < ApplicationRecord
  has_many :places
  has_many :purchases
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name

  def first_name
    name.split.ferst
  end

  def last_name
    name.split.last
  end

end
