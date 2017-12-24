require_relative './document'

module Arango
  class Collection
    def initialize(conn, info)
      @conn = conn
      @info = info
    end

    def documents
      @cache || gather
    end

    def add(content)
      resp = @conn.post("document/#{@info['name']}", content)
      Document.new(resp.headers['location'])
    end

    private

    def gather
      resp = @conn.put('simple/all-keys', collection: @info['name'], type: 'path')
      resp.body['result'].map { |path| Document.new(path) }
    end
  end
end
