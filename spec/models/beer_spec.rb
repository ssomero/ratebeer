require 'rails_helper'

describe Beer do

  it "is saved if it has name and style" do
    beer = Beer.create name:"Test", style:"Lager"

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved without a name" do
    beer = Beer.create style:"Lager"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.create name:"Test"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end



end