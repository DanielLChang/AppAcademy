class Contact < ActiveRecord::Base

  validates :name, :email, :owner, presence: true
  validates :email, uniqueness: { scope: :user_id }

  belongs_to   :owner,
  foreign_key: :user_id,
  class_name:  :User

  has_many :contact_shares

  has_many :shared_users,
  through: :contact_shares,
  source: :user

  def self.owned_and_shared(user_id)
    join_string = <<-SQL
      LEFT JOIN
        contact_shares ON contact_shares.contact_id = contacts.id
    SQL

    where_string = <<-SQL
        ((contact_shares.user_id = :user_id) OR
        (contacts.user_id = :user_id))
    SQL

    Contact
      .joins(join_string)
      .where(where_string, user_id: user_id)
      .uniq
  end

end
