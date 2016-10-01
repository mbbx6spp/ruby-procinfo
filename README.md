# procinfo

![Travis CI build status](https://api.travis-ci.org/mbbx6spp/ruby-procinfo.png)
![Latest Github Tag](https://img.shields.io/github/tag/mbbx6spp/ruby-procinfo.svg)
![Licensed under BSD-3-Clause](https://img.shields.io/github/license/mbbx6spp/ruby-procinfo.svg?maxAge=2592000?style=plastic)

A Ruby/C extension packaged as a gem that provides a more uniform interface
to \*NIX process, system, and socket information.

At the moment it only implements process information retrieved from the
`getrusage` POSIX system call for the current process (`SELF`) and children
processes (`CHILDREN`) plus uname system information.

This is compatible with POSIX-compatible OSes.

## Getting Started

Install it from the command-line via:

```bash
$ gem install ruby-procinfo
Successfully installed ruby-procinfo-0.2.1-x86_64-linux
1 gem installed
```

Or add it to your Ruby project at the end of your Gemfile like so:

```ruby
gem 'ruby-procinfo', '~>0.2.1'
```

## Example Usage

Require `'procinfo'`:

```ruby
irb(main):001:0> require 'procinfo'
=> true
```

Retrieve rusage stats for all children processes:

```ruby
irb(main):002:0>
irb(main):003:0* stats = Process.stats(:self)
=> #<struct Struct::ProcStats user_time=0.185, system_time=0.017, max_rss=30652, shared_text_size=0, unshared_data_size=0, unshared_stack_size=0, page_reclaims=5954, page_faults=0, swaps=0, block_input_ops=0, block_output_ops=0, msgs_sent=0, msgs_recvd=0, signals_recvd=0, voluntary_switches=2, involuntary_switches=3>
irb(main):004:0> stats.user_time
=> 0.185
irb(main):005:0> stats.system_time
=> 0.017
irb(main):006:0> stats.max_rss
=> 30652
irb(main):007:0> stats.page_faults
=> 0
irb(main):008:0> stats.msgs_sent
=> 0
irb(main):009:0> stats.msgs_recvd
=> 0
irb(main):010:0> stats.signals_recvd
=> 0
irb(main):011:0> stats.shared_text_size
=> 0
irb(main):012:0> stats.swaps
=> 0
irb(main):013:0> stats.block_input_ops
=> 0
irb(main):014:0> stats.block_output_ops
=> 0
```

You can also get uname information about the system your process is running
on:

```ruby
irb(main):021:0> sysinfo = System.uname
=> #<struct Struct::SystemInfo sysname="Linux", nodename="durga", release="4.7.2", version="#1-NixOS SMP Sat Aug 20 16:11:18 UTC 2016", machine="x86_64">
irb(main):022:0> sysinfo.sysname
=> "Linux"
irb(main):023:0> sysinfo.nodename
=> "durga"
irb(main):024:0> sysinfo.release
=> "4.7.2"
irb(main):025:0> sysinfo.version
=> "#1-NixOS SMP Sat Aug 20 16:11:18 UTC 2016"
irb(main):026:0> sysinfo.machine
=> "x86_64"
```

## Microbenchmarks

The reason I even bothered writing this tiny, focused gem is because while on
vacation at a Rails shop I used to work at someone added a `ps ef | awk ...`
shell from the Rails app every tenth request to get the RSS and decide if we
should kill the worker. Needless to say this was a crazy idea. As a consequence
efficiency of this library was paramount so we could use it in the Rails app
Unicorn worker hook as needed.

So here are some microbenchmarks for this APIs usage:


### Ruby 1.9.2 (ruby-procinfo v0.2.1)

```
# Running benchmarks:
Process information retrieval          1        10         100      1000     10000
bench_Process_stats             0.000013  0.000010    0.000008  0.000011  0.000009
bench_Process_stats_children    0.000012  0.000009    0.000007  0.000007  0.000007
bench_Process_stats_self        0.000011  0.000010    0.000009  0.000009  0.000007
bench_System_uname              0.000016  0.000011    0.000006  0.000006  0.000008
bench_Spawn_ps_rss              0.004176  0.004099    0.004035  0.003807  0.004230
bench_POSIX_Spawn_popen4        0.001312  0.000916    0.000854  0.000826  0.000881

Finished benchmarks in 0.128492s, 46.6957 tests/s, 46.6957 assertions/s.
```

### Ruby 1.9.3 (ruby-procinfo v0.2.1)

```
# Running benchmarks:
Process information retrieval          1        10         100      1000     10000
bench_Process_stats             0.000016  0.000012    0.000007  0.000013  0.000008
bench_Process_stats_children    0.000011  0.000008    0.000007  0.000021  0.000019
bench_Process_stats_self        0.000013  0.000009    0.000008  0.000008  0.000008
bench_System_uname              0.000014  0.000019    0.000006  0.000006  0.000006
bench_Spawn_ps_rss              0.004153  0.003816    0.003519  0.003595  0.003377
bench_POSIX_Spawn_popen4        0.001194  0.000802    0.000759  0.000808  0.000766

Finished benchmarks in 0.093692s, 64.0394 tests/s, 64.0394 assertions/s.
```

### Ruby 2.0.0 (ruby-procinfo v0.2.1)

```
# Running benchmarks:
Process information retrieval        1          10         100      1000     10000
bench_Process_stats           0.000023    0.000019    0.000017  0.000017  0.000018
bench_Process_stats_children  0.000021    0.000016    0.000015  0.000014  0.000015
bench_Process_stats_self      0.000020    0.000016    0.000013  0.000013  0.000013
bench_System_uname            0.000022    0.000015    0.000013  0.000013  0.000012
bench_Spawn_ps_rss            0.004301    0.003980    0.004084  0.003990  0.004178
bench_POSIX_Spawn_popen4      0.001334    0.001059    0.001082  0.001121  0.001034

Finished benchmarks in 0.215114s, 27.8922 tests/s, 27.8922 assertions/s.
```

### Ruby 2.1.10 (ruby-procinfo v0.2.1)

```
# Running benchmarks:
Process information retrieval       1         10           100      1000     10000
bench_Process_stats          0.000012   0.000009      0.000008  0.000007  0.000007
bench_Process_stats_children 0.000024   0.000008      0.000007  0.000016  0.000006
bench_Process_stats_self     0.000010   0.000009      0.000007  0.000007  0.000007
bench_System_uname           0.000015   0.000009      0.000006  0.000006  0.000006
bench_Spawn_ps_rss           0.004606   0.003659      0.003500  0.003288  0.003414
bench_POSIX_Spawn_popen4     0.001241   0.000906      0.000842  0.000798  0.000809

Finished benchmarks in 0.118000s, 50.8476 tests/s, 50.8476 assertions/s.
```

### Ruby 2.2.5 (ruby-procinfo v0.2.1)

```
# Running benchmarks:
Process information retrieval       1         10           100      1000     10000
bench_Process_stats          0.000014   0.000010      0.000008  0.000008  0.000008
bench_Process_stats_children 0.000011   0.000011      0.000009  0.000007  0.000007
bench_Process_stats_self     0.000011   0.000009      0.000008  0.000007  0.000008
bench_System_uname           0.000010   0.000008      0.000006  0.000006  0.000006
bench_Spawn_ps_rss           0.003457   0.002694      0.002744  0.002686  0.002616
bench_POSIX_Spawn_popen4     0.001106   0.001408      0.000792  0.000753  0.000844

Finished benchmarks in 0.109760s, 54.6649 tests/s, 54.6649 assertions/s.
```

### Ruby 2.3.0 (ruby-procinfo v0.2.1)

```
# Running benchmarks:
Process information retrieval       1         10           100      1000     10000
bench_Process_stats          0.000016   0.000011      0.000010  0.000008  0.000008
bench_Process_stats_children 0.000012   0.000009      0.000083  0.000007  0.000007
bench_Process_stats_self     0.000016   0.000010      0.000007  0.000011  0.000010
bench_System_uname           0.000014   0.000010      0.000008  0.000006  0.000009
bench_Spawn_ps_rss           0.003747   0.003267      0.003297  0.003118  0.003217
bench_POSIX_Spawn_popen4     0.001312   0.000996      0.000897  0.000895  0.000857

Finished benchmarks in 0.140802s, 42.6129 tests/s, 42.6129 assertions/s.
```

The above ran on my personal Macbook Pro development laptop running NixOS.

The point of the above isn't to pat myself on the back rather just to ensure
I'm not smoking crack when I introduce new APIs and/or fix any bugs. It
should also warn you of not running the microbenchmark test suite on your
target systems. You can do this by running the following:

    bundle exec rake test

You should always sanity check your assumptions. Some assumptions are completely
flawed, but even ones that seem reasonable should be validated in some scope and
form.

## Motivation

I really needed to be able to get current RSS and max RSS information (and
related process information) for a given process (which may or may not be
the current running process). No Ruby library (as far as I found) offered a
consistent view of this information across the most \*NIX OSes and were
currently maintained with tests.

Plus this is a great exercise for me after forgetting C after 11 years of
not developing with it. It's a breath of fresh air.

## Related Works

`sys-proctable` is Ruby/C extension library that provides this to some
degree. I wanted to use a different approach to this library and lower
overhead, and compatibility of APIs exposed for all the supporting OSes.

However, the above mentioned library may offer what you need.

## TODO

Lots to do still.

Longer-term I would like to do the following:

* Add socket/connection retrieval from the system based on state (e.g. `CLOSE_WAIT`)

## License

This code is shared under the BSD 3-clause license. See LICENSE for
more information.

## Author(s)

* [Susan Potter](http://susanpotter.net) <me at susanpotter do net> (mbbx6spp on GitHub)

## Contributor(s)

N/A
