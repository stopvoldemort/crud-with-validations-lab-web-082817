class Song < ActiveRecord::Base
  validates :title, :artist_name, presence: true
  validates :title, uniqueness: {scope: [:artist_name, :release_year]}
  validate :release_year_test

  def release_year_test
    if self.released && !self.release_year
      errors.add(:release_year, "if released, must have a release date")
    elsif self.release_year && self.release_year > Time.now.year
      errors.add(:release_year, "must have been released in the past")
    else
      true
    end
  end

end
