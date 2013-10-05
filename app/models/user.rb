class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  has_many :timesheets
  serialize :authorised_tasks

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
