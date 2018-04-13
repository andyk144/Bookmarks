require 'pg'
require_relative 'database'

class Bookmark
  attr_reader :id, :url, :name

  def initialize(options)
    @id = options[:id]
    @url = options[:url]
    @name = options[:name]
  end

  def self.all
    connection = Database::connect
    results = connection.exec("SELECT * FROM bookmarks")
    results.map { |bookmark| Bookmark.new(id: bookmark['id'], url: bookmark['url'], name: bookmark['name'])}
  end

  def self.create(options)
    connection = Database::connect
    if valid_url?(options[:url])
      connection.exec("INSERT INTO bookmarks (url,name) VALUES('#{options[:url]}', '#{options[:name]}')")
    else
      false
    end
  end

  def self.valid_url?(url)
    url_regexp = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
    url =~ url_regexp ? true : false
  end

  def self.delete(id)
    connection = Database::connect
    connection.exec("DELETE FROM bookmarks WHERE id='#{id}'")
  end

  def self.find(name)
    connection = Database::connect
    row = connection.exec("SELECT * FROM bookmarks")
    if row.column_values(2).include?(name)
      connection.exec("SELECT * FROM bookmarks WHERE name='#{name}'")
    else
      return false
    end
  end


end
