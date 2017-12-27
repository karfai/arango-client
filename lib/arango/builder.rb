require 'faraday'
require 'faraday_middleware'

module Arango
  module Builder
    def build_connection(opts)
      path = '/_api'
      if opts.key?(:path)
        path = opts[:path]
      elsif opts.key?(:db)
        path = "/_db/#{opts[:db]}/_api"
      end

      url = "http://#{opts[:host]}:#{opts[:port]}#{path}"
      Faraday.new(url) do |f|
        f.request(:json) 
        f.response(:json, :content_type => /\bjson$/)
        f.adapter(Faraday.default_adapter)
      end
    end
  end
end
