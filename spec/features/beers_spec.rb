require 'rails_helper'

describe "Beer" do

  describe "when user is signed in" do

    before :each do
      user = FactoryGirl.create :user
      sign_in(username:"Pekka", password:"Foobar1")
    end

    it "is added if name is valid" do
      visit new_beer_path
      fill_in('beer_name', with:'Koff')


      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(1)
    end

    it "is not added if name is empty" do
      visit new_beer_path
      fill_in('beer_name', with:'')

      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(0)

      expect(page).to have_content "Name can't be blank"
      # expect(current_path).to eq(new_beer_path)
    end
  end

  describe "when user is not signed in" do
    it "is not added" do
      visit new_beer_path
      expect(page).to have_content "You should be signed in"
    end

  end
end