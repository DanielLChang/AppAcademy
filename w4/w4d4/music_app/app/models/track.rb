class Track < ActiveRecord::Base

  validates :name, :album, :ord, :lyrics, presence: true
  validates :bonus, inclusion: { in: [true, false] }
  validates :ord, uniqueness: { scope: :album_id }

  belongs_to :album

  has_one :band,
          through: :album,
          source: :band

end
