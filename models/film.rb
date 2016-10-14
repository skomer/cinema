require_relative("../db/sql_runner")

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i
    @title = options.fetch('title')
    @price = options.fetch('price')
  end

  def save
    sql = "
      INSERT INTO films (title, price)
      VALUES ('#{@title}', '#{@price}')
      RETURNING *;
    "
    film = SqlRunner.run(sql).first
    @id = film.fetch('id').to_i
  end

  def update
    sql = "
      UPDATE films
      SET title = '#{@title}',
        price = '#{@price}'
      WHERE id = #{@id};
    "
    return SqlRunner.run(sql)
  end

  def self.all
    sql = "
      SELECT * FROM films;
    "
    return Film.map_items(sql)
  end

  def self.delete_all
    sql = "
      DELETE FROM films;
    "
    return SqlRunner.run(sql)
  end

  def self.map_items(sql)
    films = SqlRunner.run(sql)
    return films.map { |film| Film.new(film) }
  end

end