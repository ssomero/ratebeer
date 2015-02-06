require 'rails_helper'

describe "Beer" do

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

