class User < ActiveRecord::Base
  include RatingAverage
  has_secure_password
  has_many :ratings, :dependent => :destroy
  has_many :beers, :through => :ratings
  has_many :memberships, :dependent => :destroy
  has_many :beer_clubs, :through => :memberships

  validates :username, :uniqueness => true,
            :length => {minimum: 3,
      maximum: 15}

  validates :password, :length => {minimum: 4}
  validates :password, :format => {with: /[A-Z]+/}
  validates :password, :format => {with: /\d/}

  scope :active, -> { where active:true }
  scope :inactive, -> { where active:[nil, false]}

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    score = Hash.new(0)
    amount = Hash.new(0)
    ratings.each do |rating|
      amount[rating.beer.style] = amount[rating.beer.style] + 1
      score[rating.beer.style] = score[rating.beer.style] + rating.score
    end

    style_average = Hash.new(0)
    score.each do |key, value|
      style_average[key] = score[key]/amount[key]
    end

    style_average.max_by{|key, value| value}[0]

  end

  def is_frozen
    unless active == true
      return true
    else
      return false
    end
  end

  def favorite_brewery
    return nil if ratings.empty?
    score = Hash.new(0)
    amount = Hash.new(0)
    ratings.each do |rating|
      amount[rating.beer.brewery] = amount[rating.beer.brewery] + 1
      score[rating.beer.brewery] = score[rating.beer.brewery] + rating.score
    end

    brewery_average = Hash.new(0)
    score.each do |key, value|
      brewery_average[key] = score[key]/amount[key]
    end

    brewery_average.max_by{|key, value| value}[0]
  end


end

