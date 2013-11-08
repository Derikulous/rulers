require "sqlite3"
require "rulers/util"

DB = SQLite3::Database.new "test.db"

module Rulers
  module Model
    class SQLite
      def save!
        unless @hash["id"]
          self.class.create
          return true
        end

        fields = @hash.map do |k, v|
          "#{k}=#{self.class.to_sql(v)}"
        end.join ","

        DB.execute <<SQL

UPDATE #{self.class.table}
SET #{fields}
WHERE id = #{@hash["id"]}
SQL
        true
      end

      def save
        self.save! rescue false #returns false if there's an exception
      end

      def initialize(data = nil)
        @hash = data
      end

      def self.find(id) # query columns on an object
        row = DB.execute <<SQL
select #{schema.keys.join ","} from #{table}
where id = #{id};
SQL
        data = Hash[schema.keys.zip row[0]]
        self.new data
      end

      def [](name)
        @hash[name.to_s]
      end

      def []=(name, value)
        @hash[name.to_s] = value
      end

      def self.to_sql(val)
        case val
        when Numeric
          val.to_s
        when String
          "'#{val}'" # what is "'#{}'"?
         else
          raise "Can't change #{val.class} to SQL"
        end
      end

      def self.create(values)
        values.delete "id" # id is INTEGER PRIMARY KEY field, auto increments to unused ID
        keys = schema.keys - ["id"]
        vals = keys.map do |key|
          values[key] ? to_sql(values[key]) :
            "null"
        end

        DB.execute <<SQL
INSERT INTO #{table} (#{keys.join ","})
  VALUES (#{vals.join ","});
SQL
        data = Hash[keys.zip vals]
        sql = "SELECT last_insert_rowid();"
        data["id"] = DB.execute(sql)[0][0] # declares a here document, substitutes string in for <<SQL
        self.new data
      end

      def self.count
    DB.execute(<<SQL)[0][0]
SELECT COUNT(*) FROM #{table}
SQL
      end

      def self.table # self method defined on SQlite
        Rulers.to_underscore name #make sure we have table name from class name "name"
      end

      def self.schema
        return @schema if @schema
        @schema = {}
        DB.table_info(table) do |row| # table_info gets schema
          @schema[row["name"]] = row["type"]
        end
        @schema #instance variable of the class SQlite
      end
    end
  end
end
