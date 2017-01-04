class Step < ActiveRecord::Base

  validates :title, :todo, presence: true
  validates :done, inclusion: [true, false], default: false

  belongs_to :todo

end
