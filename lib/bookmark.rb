require 'pg'
require 'database'

class Bookmark
  attr_reader :id, :url, :name

  def initialize(id, url, name)
    @id = id
    @url = url
    @name = name
  end

  def self.all
    connection = Database::connect
    results = connection.exec("SELECT * FROM bookmarks")
    results.map { |bookmark| Bookmark.new(bookmark['id'], bookmark['url'], bookmark['name'])}
  end

  def self.create(url,name)
    connection = Database::connect
    if valid_url?(url)
      connection.exec("INSERT INTO bookmarks (url,name) VALUES('#{url}', '#{name}')")
    else
      false
    end
  end

  def self.valid_url?(url)
    url_regexp = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
    url =~ url_regexp ? true : false
  end

end
