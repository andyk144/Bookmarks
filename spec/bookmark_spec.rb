require './lib/bookmark'

describe Bookmark do

  describe ".all" do
    it 'returns all bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      connection.exec("INSERT INTO bookmarks (url, name) VALUES('http://facebook.com', 'Facebook');")
      connection.exec("INSERT INTO bookmarks (url, name) VALUES('http://twitter.com', 'Twitter');")
      connection.exec("INSERT INTO bookmarks (url, name) VALUES('http://instagram.com', 'Instagram');")

      expected_list = ['http://facebook.com', 'http://twitter.com', 'http://instagram.com']
      expect(Bookmark.all).to eq expected_list
    end
  end

  describe ".create" do
    it 'adds a bookmark' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      connection.exec("INSERT INTO bookmarks (url, name) VALUES('http://facebook.com', 'Facebook');")
      connection.exec("INSERT INTO bookmarks (url, name) VALUES('http://twitter.com', 'Twitter');")
      connection.exec("INSERT INTO bookmarks (url, name) VALUES('http://instagram.com', 'Instagram');")

      Bookmark.create("http://stackoverflow.com", "StackOverflow")
      expected_list = ['http://facebook.com', 'http://twitter.com', 'http://instagram.com', 'http://stackoverflow.com']

      expect(Bookmark.all).to eq expected_list

    end
  end

  describe ".url_valid?" do
    it 'accepts a vaild url' do
      url = "http://test.co.uk"
      expect(Bookmark.valid_url?(url)).to be_truthy
    end

    it 'rejects a invalid url' do
      url = "http://dsfkjbfvkhjbdfv"
      expect(Bookmark.valid_url?(url)).to be_falsy
    end
  end
end
