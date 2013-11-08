require "sqlite3"
require "rulers/sqlite_model"

class MyTable < Rulers::Model::SQLite; end
STDERR.puts MyTable.schema.inspect

# Create row, increased by 3
mt = MyTable.create "title" => "It happened!",
  "posted" => 1, "body" => "It did!"
mt = MyTable.create "title" => "I saw it!"
mt = MyTable.create "title" => "I saw it again!"
mt["title"] = "I really did!"
mt.save!

mt2 = MyTable.find mt["id"]

puts "Title: #{mt2["title"]}"

puts "Count: #{MyTable.count}"

puts "Integer: #{mt2["id"].class.to_s}"

top_id = mt["id"].to_i # explicit call of .to_i on the ID, value retrieved from SQL, no auto conversion
(1..top_id).each do |id|
  mt_id = MyTable.find(id)
  puts "Found title #{mt_id["title"]}."
end
