require_relative 'customer.rb'
require_relative 'film.rb'
require_relative '../db/sql_runner'

require 'pry-byebug'

class Ticket

  attr_reader :id, :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i
    @customer_id = options.fetch('customer_id')
    @film_id = options.fetch('film_id')
    # binding.pry
    # check_customer_funds()
  end

  def check_customer_funds
    # binding.pry
    sql = "
      SELECT funds
      FROM customers
      WHERE id = #{@customer_id};
    "
    return Ticket.map_items(sql)
  end

  def save
    sql = "
      INSERT INTO tickets (customer_id, film_id)
      VALUES (#{@customer_id}, #{@film_id})
      RETURNING *;
    "
    ticket = SqlRunner.run(sql).first
    @id = ticket.fetch('id').to_i
  end

  def update
    sql = "
      UPDATE tickets
      SET customer_id = #{@customer_id},
        film_id = #{@film_id}
      WHERE id = #{@id}
    "
    return SqlRunner.run(sql)
  end

  def self.all
    sql = "
      SELECT * FROM tickets;
    "
    return Ticket.map_items(sql)
  end

  def self.delete_all
    sql = "
      DELETE FROM tickets;
    "
    return SqlRunner.run(sql)
  end

  def self.map_items(sql)
    # binding.pry
    tickets = SqlRunner.run(sql)
    # binding.pry
    return tickets.map { |ticket| Ticket.new(ticket) }
  end

  def self.map_item(sql)
    result = Ticket.map_items(sql)
    return result[0]
  end

end








