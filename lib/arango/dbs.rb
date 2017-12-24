require_relative './db'

module Arango
  class DBs
    def initialize(conn)
      @conn = conn
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
      DB.new(name)
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
      resp.body['result'].inject({}) do |o, n|
        o.merge(n => DB.new(n))
      end
    end
  end
end

