require_relative './db'

module Arango
  class DBs
    def initialize(conn, opts)
      @conn = conn
      @opts = opts
    end

    def exists?(name)
      all.key?(name)
    end

    def maybe_create(name)
      if !all.key?(name)
        all[name] = create(name)
      end

      all[name]
    end

    def create(name)
      resp = @conn.post('database', name: name)
      DB.new(name, @opts)
    end
    
    def [](name)
      all.fetch(name, nil)
    end
    
    private

    def all
      @cache ||= gather
    end

    def gather
      resp = @conn.get('database/user')
      p resp
      resp.body['result'].inject({}) do |o, n|
        o.merge(n => DB.new(n, @opts))
      end
    end
  end
end

