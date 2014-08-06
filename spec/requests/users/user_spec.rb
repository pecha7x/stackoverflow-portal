require "request_helper"

describe "user questions", js: true do
  it "username is required and need dispalay error about emplty it" do
    visit root_path

    within '.username-input' do
      fill_in "username of StackOverflow", with: ""
      click_button 'Check questions'
    end

    page.should have_content("Please enter a valid username")
  end

  it "after fill right username it's displayed some questions for STOw" do
    visit root_path

    within '.username-input' do
      fill_in "username of StackOverflow", with: "Artem Pecherin"
      click_button 'Check questions'
    end

    page.should have_selector('.question')
  end
end