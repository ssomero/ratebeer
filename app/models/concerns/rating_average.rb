module RatingAverage
  extend ActiveSupport::Concern
  def rating_average
    ratings.average(:score)
  end
end