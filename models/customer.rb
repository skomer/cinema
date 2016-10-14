require_relative("../db/sql_runner")

class Customer

  attr_reader :id, :name, :funds

  def initialize(options)
    @id = options['id'].to_i
    @name = options.fetch('name')
    @funds = options.fetch('funds')
  end

  def save
    sql = "
      INSERT INTO customers (name, funds)
      VALUES ('#{@name}', '#{@funds}')
      RETURNING *;
    "
    customer = SqlRunner.run(sql)[0]
    @id = customer.fetch('id')
  end

  def update
    sql = "
      UPDATE customers
      SET name = '#{@name}',
        funds = '#{@funds}'
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