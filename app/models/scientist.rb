class Scientist < ApplicationRecord
    has_many :missions, dependent: :destroy
    has_many :planets, through: :missions

    validates :name, presence: true, uniqueness: true
end
