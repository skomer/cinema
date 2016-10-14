require_relative("../db/sql_runner")

class Customer

  attr_accessor :name, :funds
  attr_reader :id

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
    sql = "
      SELECT * FROM customers;
    "
    return Customer.map_items(sql)
  end

  def self.delete_all
    sql = "
      DELETE FROM customers;
    "
    return SqlRunner.run(sql)
  end

  def self.map_items(sql)
    customers = SqlRunner.run(sql)
    result = customers.map { |customer| Customer.new(customer) }
  end

end


