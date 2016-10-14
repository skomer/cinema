require_relative("../db/sql_runner")

class Film

  attr_reader :id, :title, :price

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
    pass

  end

  def self.delete
    pass

  end



end