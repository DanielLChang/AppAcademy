require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @col_names if @col_names

    cols = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL

    @col_names = cols.first.map(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |col|
      define_method(col) do
        self.attributes[col]
      end

      define_method("#{col}=") do |value|
        self.attributes[col] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.name.underscore.pluralize
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
    SQL

    self.parse_all(results)
  end

  def self.parse_all(results)
    results.map do |result|
      self.new(result)
    end
  end

  def self.find(id)
    results = DBConnection.execute(<<-SQL, id)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
      WHERE
        #{table_name}.id = ?
    SQL

    self.parse_all(results).first
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      attr_name = attr_name.to_sym
      #self.class = to use class methods
      if self.class.columns.include?(attr_name)
        self.send("#{attr_name}=", value)
      else
        raise "unknown attribute '#{attr_name}'"
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map do |value|
      self.send(value)
    end
  end

  def insert
    col_names = self.class.columns.drop(1).map(&:to_sym).join(", ")
    question_marks = (["?"] * (self.class.columns.length - 1)).join(", ")

    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    set_string = self.class.columns.map do |value|
      "#{value} = ?"
    end.join(", ")

    DBConnection.execute(<<-SQL, *attribute_values, id)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_string}
      WHERE
        #{self.class.table_name}.id = ?
    SQL
  end

  def save
    id.nil? ? insert : update
  end
end
