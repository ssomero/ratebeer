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
    save_and_open_page
  end

  it "user can delete own ratings and they are removed from database" do



  end


end

def create_beer_with_rating(score, user)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
end