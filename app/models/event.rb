class Event < ApplicationRecord
  include ActiveModel::Validations
  include DateFormatter
  include VirtualState::Model

  belongs_to :city

  has_many :sections, dependent: :restrict_with_error

  validates :name, :state_id, :city_id, :beginning_date, presence: true
  validates :color, :end_date, :initials, :local, :address, presence: true
  validates_with EventDateValidator, on: :create
  validates_with EventUpdateDateValidator, on: :update

  def full_address
    "#{address} - #{city.name}/#{city.state.acronym}"
  end

  def self.current_color
    date = Time.now.utc
    e = find_by(['beginning_date >= :beginning_year and end_date <= :end_year',
                 { beginning_year: date.beginning_of_year, end_year: date.end_of_year }])

    return e.color if e

    '#000'
  end

  def sections_to_sort?
    sections.length > 1
  end
end
