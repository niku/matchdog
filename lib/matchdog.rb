require "matchdog/version"

module Matchdog
  class Error < StandardError; end

  refine Hash do
    def deconstruct_keys(keys)
      {}.tap do |h|
        keys.each do |key|
          h[key] = self[key.to_s]
        end
      end
    end
  end
end
