require './lib/bookmark'

describe Bookmark do

  describe ".all" do
    it 'returns all bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      connection.exec("INSERT INTO bookmarks (url) VALUES('http://facebook.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('http://twitter.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('http://instagram.com');")

      expected_list = ['http://facebook.com', 'http://twitter.com', 'http://instagram.com']
      expect(Bookmark.all).to eq expected_list
    end
  end

  describe ".create" do
    it 'adds a bookmark' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      connection.exec("INSERT INTO bookmarks (url) VALUES('http://facebook.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('http://twitter.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('http://instagram.com');")

      Bookmark.create("http://stackoverflow.com")
      expected_list = ['http://facebook.com', 'http://twitter.com', 'http://instagram.com', 'http://stackoverflow.com']

      expect(Bookmark.all).to eq expected_list

    end
  end
end
