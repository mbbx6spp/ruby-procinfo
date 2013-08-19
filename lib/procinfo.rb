require 'procinfo/procinfo'

module Process
  def self.stats(type = :self)
    case type
    when :self
      stats_for_self
    when :children
      stats_for_children
    else
      raise ArgumentError.new("Unknown type: #{type}")
    end
  end

  class << self
    private :stats_for_self, :stats_for_children
  end
end
