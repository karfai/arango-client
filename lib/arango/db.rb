require_relative './builder'
require_relative './collections'

module Arango
  class DB
    include Builder
    
    def initialize(name)
      @conn = build_connection(name)
      @name = name
    end

    def collections
      Collections.new(@conn)
    end
  end
end

