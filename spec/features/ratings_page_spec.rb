require 'rails_helper'

describe "Ratings page" do






describe "when ratings exist" do

  before :each do

    user = FactoryGirl.create :user
    create_beer_with_rating(10, user)
    create_beer_with_rating(20, user)

    visit ratings_path
  end

  it "lists ratings and the total number of ratings" do

    Rating.all.each do |score|
      expect(page).to have_content score
    end
    expect(page).to have_content "Number of ratings: #{Rating.count}"
  end
end

def create_beer_with_rating(score, user)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
end
end