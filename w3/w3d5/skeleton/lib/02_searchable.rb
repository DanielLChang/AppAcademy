require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    #params is hash
    where_line = params.keys.map do |param|
      "#{param} = ?"
    end.join(" AND ")

    results = DBConnection.execute(<<-SQL, *params.values)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{where_line}
    SQL

    parse_all(results)
  end
end

class SQLObject
  extend Searchable
end
