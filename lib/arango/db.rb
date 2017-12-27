require_relative './builder'
require_relative './collections'

module Arango
  class DB
    include Builder
    
    def initialize(name, opts)
      @conn = build_connection(opts.merge(db: name))
      @opts = opts
    end

    def collections
      Collections.new(@conn, @opts)
    end
  end
end

