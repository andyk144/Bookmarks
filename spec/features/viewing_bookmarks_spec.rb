require "capybara/rspec"
require "./app/app"


feature "View a list of bookmarks" do
  scenario "A user sees a list of their bookmarks" do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    connection.exec("INSERT INTO bookmarks (url, name) VALUES('http://facebook.com', 'Facebook');")
    connection.exec("INSERT INTO bookmarks (url, name) VALUES('http://twitter.com', 'Twitter');")
    connection.exec("INSERT INTO bookmarks (url, name) VALUES('http://instagram.com', 'Instagram');")

    visit "/"

    click_button 'Bookmarks'

    expect(page).to have_content "Facebook"
    expect(page).to have_content "Twitter"
    expect(page).to have_content "Instagram"
  end
end
