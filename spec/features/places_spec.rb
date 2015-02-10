require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
                                 [ Place.new( name:"Oljenkorsi", id: 1 ) ]
                             )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if several are returned by the API, they are shown at the page" do
  allow(BeermappingApi).to receive(:places_in).with("helsinki").and_return(
                                                                     [Place.new( name:"Bruuveri", id:1),
                                                                     Place.new( name:"Teerenpeli", id:2),
                                                                     Place.new( name:"SportsAcademy", id:3)]
                             )

    visit places_path
    fill_in('city', with: "helsinki")
    click_button "Search"

  expect(page).to have_content "Bruuveri"
  expect(page).to have_content "Teerenpeli"
  expect(page).to have_content "SportsAcademy"
  end

  it "if nothing is returned by the API, there is a message about it" do
    allow(BeermappingApi).to receive(:places_in).with("helsinki").and_return(
                                 []
                             )

    visit places_path
    fill_in('city', with: 'helsinki')
    click_button "Search"

    expect(page).to have_content "No locations in helsinki"
  end
end
