class Export < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  validates :status, inclusion: {in: %w[pending processing completed failed]}
end
