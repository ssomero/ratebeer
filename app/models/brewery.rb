class Brewery < ActiveRecord::Base
  has_many :beers, :dependent => :destroy

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
end
