class Project < ActiveRecord::Base

  has_many :tasks
  belongs_to :customer

  validates :name, presence: true

end
