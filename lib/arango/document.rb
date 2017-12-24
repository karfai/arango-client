require_relative './builder'

module Arango
  class Document
    include Builder
    
    def initialize(path)
      @conn = build_raw_connection(path)
    end
  end
end
