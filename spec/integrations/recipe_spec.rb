require 'rails_helper'

RSpec.describe 'Recipes index', type: :feature do
  before(:each) do
    @user = User.create!(email: 'test@example.com', password: 'password', password_confirmation: 'password')
    @user.confirm # Confirm user's email
    @recipe1 = Recipe.create(name: 'Pasta', user: @user)

    visit new_user_session_path
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit recipes_path
  end

  it 'displays "Add new recipe" link when logged in' do
    expect(page).to have_link('Add new recipe', href: new_recipe_path)
  end

  it 'displays "My Recipes" when logged in' do
    expect(page).to have_content('My Recipes')
  end
end
