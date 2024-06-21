class Array
  def ok? = self.first == :ok

  def error? = self.first == :error

  def value = self.last

  def value!
    case self
    in :ok, value
      value
    in :error, StandardError => e
      raise e
    in :error, e
      raise StandardError, e
    end
  end
end

class NilClass
  def ok? = false
  def error? = false
end

# TODO: understand if needed
#
# class Hash
#   def ok? = self.first == :ok
#   def error? = self.first == :error
# end

# class Symbol
#   def ok? = self == :ok
#   def error? = self == :error
# end

# class TrueClass
#   def ok? = true
#   def error? = false
# end

# class FalseClass
#   def ok? = false
#   def error? = true
# end
