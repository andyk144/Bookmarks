require './lib/bookmark'

describe Bookmark do

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

  let(:subject) { described_class.new(id: 1, url: 'http://google.com', name: 'google')}

  describe 'url' do
    it 'shows the url' do
      expect(subject.url).to eq 'http://google.com'
    end
  end

  describe 'name' do
    it 'shows the name of given to the bookmark' do
      expect(subject.name).to eq 'google'
    end
  end

  describe 'id' do
    it 'shows the id of given to the bookmark' do
      expect(subject.id).to eq 1

    end
  end




  # describe ".all" do
  #   it 'returns all bookmarks' do
  #     Bookmark.create('http://facebook.com', 'Facebook')
  #     Bookmark.create('http://twitter.com', 'Twitter')
  #
  #     # expected_list = {'http://facebook.com' 'Facebook', 'http://twitter.com', 'Twitter'}
  #
  #     expect(Bookmark.all).to include 'Facebook'
  #   end
  # end
  #
  # describe ".create" do
  #   it 'adds a bookmark' do
  #     connection = PG.connect(dbname: 'bookmark_manager_test')
  #
  #     connection.exec("INSERT INTO bookmarks (url, name) VALUES('http://facebook.com', 'Facebook');")
  #     connection.exec("INSERT INTO bookmarks (url, name) VALUES('http://twitter.com', 'Twitter');")
  #     connection.exec("INSERT INTO bookmarks (url, name) VALUES('http://instagram.com', 'Instagram');")
  #
  #     Bookmark.create("http://stackoverflow.com", "StackOverflow")
  #     expected_list = ['http://facebook.com', 'http://twitter.com', 'http://instagram.com', 'http://stackoverflow.com']
  #
  #     expect(Bookmark.all).to eq expected_list
  #
  #   end
  # end


end
