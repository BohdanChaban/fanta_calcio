class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :team

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  enum status: { newbie: 0,
                 approved: 1,
                 admin: 2
  }
end
