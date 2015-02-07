require 'rails_helper'


describe "User's page" do

  before :each do

    user = FactoryGirl.create :user
    create_beer_with_rating(10, user)
    create_beer_with_rating(20, user)
    sign_in(username:"Pekka", password:"Foobar1")
    visit user_path(user)
    end

  it "has only those ratings that user has done" do

    user2 = FactoryGirl.create(:user, username:"Matti", password:"Matt1", password_confirmation:"Matt1")
    create_beer_with_rating(15, user2)

    expect(page).to have_content "has made 2 ratings"

  end

  it "user can delete own ratings and they are removed from database" do
    # find the right link with xpath, a means that it's a link, content
    # inside [] is the conditions which is now link to rating_id 2.
    find(:xpath, "//a[@href='/ratings/2']").click

    expect(page).to have_content "has made 1 rating"
  end

  it "has favorite beer, brewery and style if rated" do
    user = FactoryGirl.create(:user, username:"Topi", password:"Top1", password_confirmation:"Top1")
    brewery = FactoryGirl.create(:brewery)
    brewery2 = FactoryGirl.create(:brewery2)
    beer1 = FactoryGirl.create(:beer, brewery:brewery)
    beer2 = FactoryGirl.create(:beer_two, brewery:brewery2)
    beer3 = FactoryGirl.create(:beer_two, brewery:brewery2)
    rating1 = FactoryGirl.create(:rating, beer:beer1, user:user)
    rating2 = FactoryGirl.create(:rating, score:40, beer:beer2, user:user)
    rating3 = FactoryGirl.create(:rating, beer:beer3, user:user)
    visit user_path(user)

    expect(page).to have_content "favorite style is IPA"
    expect(page).to have_content "favorite brewery is anonymous2"
    expect(page).to have_content "favorite beer is anonymous2 "
  end

end

def create_beer_with_rating(score, user)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
end