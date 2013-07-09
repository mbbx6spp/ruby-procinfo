require 'test/unit'
require 'procinfo'

class ProcinfoTest < Test::Unit::TestCase
  def test_stats
    stats = Process.stats
    puts stats.inspect
    assert_equal Process::ProcStats, stats.class
    assert stats.user_time > 0
    assert stats.system_time > 0
    assert stats.max_rss > 0
  end
end
