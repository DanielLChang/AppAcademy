class Tagging < ActiveRecord::Base
  validates :topic, :user_id

  def self.add_tag(user, url)
    Tagging.create(user_id: user.id, url: url)
  end

  belongs_to :url_topic,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :Url

  belongs_to :user_topic,
  primary_key: :id,
  foreign_key: :user_id
  class_name: :User

end
