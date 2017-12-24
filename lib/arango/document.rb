require_relative './builder'

require 'active_support/core_ext/hash'

module Arango
  class Document
    include Builder

    def initialize(opts)
      @conn = build_raw_connection(opts[:path]) if opts.key?(:path)
      @content = opts.fetch(:content, nil)
    end

    def content
      @content ||= load
      @content.except('_key', '_id', '_rev')
    end

    private

    def load
      resp = @conn.get
      resp.body
    end
  end
end
