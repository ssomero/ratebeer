require 'rails_helper'



describe User do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.rating_average).to eq(15.0)
    end
  end

  it "is not saved if password is too short" do
    user = User.create username:"Pekka", password:"Mo1", password_confirmation:"Mo1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved if password is contains only letters" do
    user = User.create username:"Pekka", password:"Secret", password_confirmation:"Secret"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beer_with_rating(10, user)
      best = create_beer_with_rating(25, user)
      create_beer_with_rating(7, user)

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let!(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings does not have a favorite style" do

      expect(user.favorite_style).to eq(nil)
    end

    it "is the only style if only one beer" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_style).to eq(beer.style)
    end

    it "is the one with the highest average if several rated" do
      beer1 = FactoryGirl.create(:beer)
      beer2 = FactoryGirl.create(:beer_two)
      beer3 = FactoryGirl.create(:beer_two)
      rating1 = FactoryGirl.create(:rating, beer:beer1, user:user)
      rating2 = FactoryGirl.create(:rating, score:40, beer:beer2, user:user)
      rating3 = FactoryGirl.create(:rating, beer:beer3, user:user)

      expect(user.favorite_style).to eq(beer2.style)
    end
  end

  describe "favorite brewery" do
    let!(:user){FactoryGirl.create(:user) }
    let!(:brewery){FactoryGirl.create(:brewery)}
    let!(:brewery2){FactoryGirl.create(:brewery2)}

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_brewery)
    end

    it "without ratings does not have a favorite brewery" do

      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the only brewery if only one beer" do
      beer = FactoryGirl.create(:beer, brewery:brewery)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_brewery).to eq(beer.brewery)
    end

    it "is the one with the highest average if several rated" do
      beer1 = FactoryGirl.create(:beer, brewery:brewery)
      beer2 = FactoryGirl.create(:beer_two, brewery:brewery2)
      beer3 = FactoryGirl.create(:beer_two, brewery:brewery2)
      rating1 = FactoryGirl.create(:rating, beer:beer1, user:user)
      rating2 = FactoryGirl.create(:rating, score:40, beer:beer2, user:user)
      rating3 = FactoryGirl.create(:rating, beer:beer3, user:user)

      expect(user.favorite_brewery).to eq(beer2.brewery)
    end
  end

  def create_beer_with_rating(score, user)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
  end

  def create_beers_with_ratings(*scores, user)
  scores.each do |score|
    create_beer_with_rating(score, user)
  end
  end

end
