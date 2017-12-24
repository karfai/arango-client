require_relative './collection'

module Arango
  class Collections
    def initialize(conn)
      @conn = conn
    end

    def exists?(name)
      all.key?(name)
    end

    def create(name)
    end

    def maybe_create(name)
      if !all.key?(name)
        all[name] = create(name)
      end

      all[name]
    end

    def [](name)
      all.fetch(name, nil)
    end
    
    private

    def all
      @cache ||= gather
    end

    def gather
      resp = @conn.get('collection')
      resp.body['result'].inject({}) do |o, c|
        o.merge(c['name'] => Collection.new(@conn, c))
      end
    end
  end
end

