class Section < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :event

  validates :title, :content, :status, :icon, :index, :event_id, presence: true
  validates :alternative_text, presence: true, if: -> { :status == 'O' }

  enum status: { active: 'A', inactive: 'I', other: 'O' }, _prefix: :status

  def self.human_status_types
    hash = {}
    statuses.each { |key, value| hash[I18n.t("enums.status_types.#{key}")] = value }
    hash
  end
end