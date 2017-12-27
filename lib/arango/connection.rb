require_relative './builder'
require_relative './dbs'

module Arango
  class Connection
    include Builder

    DEFAULT_OPTS = {
      host: 'localhost',
      port: 8529,
    }
    
    def initialize(opts=DEFAULT_OPTS)
      @opts = opts
      @conn = build_connection(opts)
    end
    
    def databases
      DBs.new(@conn, @opts)
    end
  end
end
