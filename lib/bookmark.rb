require 'pg'

class Bookmark
  attr_reader :id, :url, :name

  def initialize(id, url, name)
    @id = id
    @url = url
    @name = name
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    results = connection.exec("SELECT * FROM bookmarks")
    results.map { |bookmark| Bookmark.new(bookmark['id'], bookmark['url'], bookmark['name'])}
  end

  def self.create(url,name)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    if valid_url?(url)
      result = connection.exec("INSERT INTO bookmarks (url,name) VALUES('#{url}', '#{name}') RETURNING id, url, name")
      Bookmark.new(result.first['id'], result.first['url'], result.first['name'])
    else
      false
    end
  end

  def self.valid_url?(url)
    url_regexp = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
    url =~ url_regexp ? true : false
  end

  # def add_to_db(url, name)
  #   if ENV['ENVIRONMENT'] == 'test'
  #     connection = PG.connect(dbname: 'bookmark_manager_test')
  #   else
  #     connection = PG.connect(dbname: 'bookmark_manager')
  #   end
  #   if valid_url?(url)
  #     results = db.exec("INSERT INTO bookmarks (url,name) VALUES ('#{url}', '#{name}')")
  #   else
  #     false
  #   end
end
