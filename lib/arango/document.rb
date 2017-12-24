require_relative './builder'

require 'active_support/core_ext/hash'

module Arango
  class Document
    include Builder
    
    def initialize(path)
      @conn = build_raw_connection(path)
    end

    def content
      resp = @conn.get
      resp.body.except('_key', '_id', '_rev') 
    end
  end
end
