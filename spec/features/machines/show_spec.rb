require 'rails_helper'

RSpec.describe "When a user visits the vending machine show", type: :feature do
  scenario "they see the name of all of the snacks associated with that vending machine along with their price" do
    sam = Owner.create!(name: "Sam's Snacks")
    drinks = sam.machines.create!(location: "Don's Mixed Drinks")
    snack1 = Snack.create!(name: "Kool-Aid", price: 1)
    snack2 = Snack.create!(name: "Fruit Punch", price: 1.5)
    snack3 = Snack.create!(name: "Sweet Tea", price: 2)

    SnackMachine.create!(snack_id: snack1.id, machine_id: drinks.id)
    SnackMachine.create!(snack_id: snack2.id, machine_id: drinks.id)
    SnackMachine.create!(snack_id: snack3.id, machine_id: drinks.id)

    visit machine_path(drinks)

    expect(current_path).to eq("/machines/#{drinks.id}")
    expect(page).to have_content(snack1.name)
    expect(page).to have_content(snack1.price)
    expect(page).to have_content(snack2.name)
    expect(page).to have_content(snack2.price)
    expect(page).to have_content(snack3.name)
    expect(page).to have_content(snack3.price)
  end
end
