class Song < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: {
    scope: %i[release_year artist_name],
    message: 'Must be unique to the artist and the year'
  }

  validates :released, inclusion: [true, false]

  with_options if: :released? do |released|
    released.validates :release_year, presence: true
    released.validates :release_year, numericality: {
      less_than_or_equal_to: Date.today.year
    }
  end

  validates :artist_name, presence: true

  validates :genre, presence: true
end
