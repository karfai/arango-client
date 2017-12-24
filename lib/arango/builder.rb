require 'faraday'
require 'faraday_middleware'

module Arango
  module Builder
    def build_connection(db=nil)
      build_raw_connection(db ? "/_db/#{db}/_api" : '/_api')
    end

    def build_raw_connection(path)
      Faraday.new("http://localhost:8529#{path}") do |f|
        f.request(:json) 
        f.response(:json, :content_type => /\bjson$/)
        f.adapter(Faraday.default_adapter)
      end
    end
  end
end
