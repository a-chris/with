# frozen_string_literal: true

require_relative "with/version"
require_relative "with/extensions"

#
# Emulating Elixir with statement in Ruby.
#
class With
  def self.call
    new
  end

  def initialize
    @ok = true
    @steps = {}
  end

  def if_ok(key)
    return self unless @ok

    begin
      result = yield(@steps || {})

      case result
      in [:ok, value]
        @steps.merge!(key => value)
        @ok = true
      in [:error, e]
        @ok = false
        @error = e
      else
        @ok = false
        @error = [:error, result]
      end
    rescue => e
      @ok = false
      @error = e
    end

    self
  end

  def else
    yield(@steps, @error)

    self
  end

  def collect
    [@steps, @error]
  end
end
