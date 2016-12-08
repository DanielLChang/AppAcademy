class Album < ActiveRecord::Base

  validates :name, :year, :band, presence: true
  validates :name, uniqueness: { scope: :band_id }
  validates :live, inclusion: { in: [true, false] }

  belongs_to :band
  has_many :tracks, dependent: :destroy

end
