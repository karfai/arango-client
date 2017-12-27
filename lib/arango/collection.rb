require_relative './document'

module Arango
  class Collection
    def initialize(conn, info, opts)
      @conn = conn
      @info = info
      @opts = opts
    end

    def documents
      @cache || gather
    end

    def add(content)
      resp = @conn.post("document/#{@info['name']}", content)
      Document.new(@opts.merge(path: resp.headers['location']))
    end

    def by_example(o)
      resp = @conn.put('simple/by-example', { collection: @info['name'], example: o })
      resp.body['result'].map do |res|
        Document.new(@opts.merge(content: res, path: "#{@conn.url_prefix.path}/#{res['_key']}"))
      end
    end

    private

    def gather
      resp = @conn.put('simple/all-keys', collection: @info['name'], type: 'path')
      resp.body['result'].map { |path| Document.new(@opts.merge(path: path)) }
    end
  end
end
