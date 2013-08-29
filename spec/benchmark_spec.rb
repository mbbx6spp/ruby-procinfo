require "minitest/benchmark"

describe "Process information retrieval" do
  bench_performance_constant "Process.stats" do
    Process.stats
  end

  bench_performance_constant "Process.stats_self" do
    Process.stats(:self)
  end

  bench_performance_constant "Process.stats_children" do
    Process.stats(:children)
  end

  bench_performance_constant "Spawn_ps_rss", 0.9 do
    `ps -o rss= -p #{Process.pid}`.to_i
  end
end
