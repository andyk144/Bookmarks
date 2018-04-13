require "capybara/rspec"
require "./app/app"

feature "deleting a bookmark" do
  scenario "A user can enter a URL and add a new bookmark" do

    connection = PG.connect(dbname: 'bookmark_manager_test')

    connection.exec("INSERT INTO bookmarks VALUES(1, 'http://facebook.com', 'Facebook');")
    connection.exec("INSERT INTO bookmarks VALUES(2, 'http://twitter.com', 'Twitter');")
    connection.exec("INSERT INTO bookmarks VALUES(3, 'http://instagram.com', 'Instagram');")

    visit "/"
    click_button 'Bookmarks'
    find_button('Delete Facebook').click

    expect(page).not_to have_content "Facebook"
  end
end
