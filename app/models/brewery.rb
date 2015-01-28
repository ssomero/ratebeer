class Brewery < ActiveRecord::Base
  include RatingAverage
  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers

  validates :year, :numericality => {:greater_than_or_equal_to => 1042,
                                     :less_than_or_equal_to => 2015}
  validates :name, :presence => true



  def print_report
    puts self.name
    puts "established at year #{self.year}"
    puts "number of beers #{self.beers.count}"
  end

  def restart
    self.year = 2015
    puts "changed year to #{year}"
  end

  def to_s
    "#{self.name} (#{self.year})"
  end

  #def average_rating
  #  self.ratings.average(:score)
  #end
end
