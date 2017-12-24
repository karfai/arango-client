require_relative './builder'
require_relative './dbs'

module Arango
  class Connection
    include Builder
    
    def initialize()
      @conn = build_connection
    end
    
    def databases
      DBs.new(@conn)
    end
  end
end
