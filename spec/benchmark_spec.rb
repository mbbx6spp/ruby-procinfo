require "minitest/benchmark"
require 'posix/spawn'

describe "Process information retrieval" do
  bench_performance_constant "System.uname" do
    System.uname
  end

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

  bench_performance_constant "POSIX::Spawn.popen4" do
    begin
      pid, stdin, stdout, stderr = POSIX::Spawn.popen4('ps', "-o rss= -p #{Process.pid}")
      stdin.close
      rss = stdout.read.to_i
    rescue => e
      # nothing right now.
    ensure 
      [stdin, stdout, stderr].each { |fd| fd.close unless fd.closed? }
      stat = Process::waitpid(pid)
    end
  end
end
