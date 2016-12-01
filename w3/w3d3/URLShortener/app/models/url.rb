class Url < ActiveRecord::Base
  validates :short_url, :long_url, :user_id, presence: true

  def self.random_code
    loop do
      short_url = SecureRandom.urlsafe_base64(16 * 3 / 4)
      return short_url unless Url.exists?(short_url)
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    Url.create(user_id: user.id, long_url: long_url, short_url: Url.random_code)
  end

  def num_clicks
    visitors.count
  end

  def num_uniques
    visits.select(:user_id).distinct.count
  end

  def num_recent_uniques
    visits.select(:user_id).where('created_at >= ?', 10.minutes.ago).distinct.count
  end

  belongs_to :submitter,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User

  has_many :visits,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :Visit

  has_many(
  :visitors,
  through: :visits,
  source: :user_visited
  )

end
