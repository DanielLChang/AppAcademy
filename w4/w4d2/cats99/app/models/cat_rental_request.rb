class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: {in: %w(PENDING APPROVED DENIED), message: '%{value} is not valid'}
  validate :validates_no_two_dates

  before_validation :pending_status

  belongs_to :cat

  def approve!
    fail
    overlapping_pending_requests.each do |request|
      request.deny!
    end
    self.status = "APPROVED"
    self.save
  end

  def deny!
    self.status = "DENIED"
    self.save
  end

  def pending?
    self.status == 'PENDING'
  end

  def validates_no_two_dates
    errors[:base] << 'overlapping dates' unless overlapping_approved_requests.empty?
  end

  def overlapping_approved_requests
    overlapping_requests.select do |cat_rental|
      cat_rental.status == 'APPROVED'
    end
  end

  def overlapping_pending_requests
    overlapping_requests.select do |cat_rental|
      cat_rental.status == 'PENDING'
    end
  end

  def overlapping_requests
    overlap = []

    Cat.find_by(id: self.cat_id)
      .cat_rental_requests.each do |cat_rental|
        next if cat_rental.id == self.id

        if (self.start_date >= cat_rental.start_date && self.start_date <= cat_rental.end_date) || (self.end_date >= cat_rental.start_date && self.end_date <= cat_rental.end_date)
          overlap << cat_rental
        end
      end

    overlap
  end

  private

  def pending_status
    self.status ||= 'PENDING'
  end

end
