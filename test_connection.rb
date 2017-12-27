require_relative './lib/arango/connection'

cl = Arango::Connection.new(host: 'localhost', port: 8529)
db = cl.databases['lichen']
coll = db.collections['documents']
p '> all'
coll.documents.each do |doc|
  p doc.content
end

p '> by_example'
p coll.by_example(id: '5e4f7b50-ccfd-0135-e385-2cbc32ca21f1')

p '> add'
doc = coll.add({ x: 11111 })
p doc.content
  
