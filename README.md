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

```
# Running benchmarks:


Process information retrieval            1              10             100            1000           10000
+bench_POSIX_Spawn_popen4         0.005980        0.025996        0.004227        0.002901        0.002780
bench_Process_stats               0.000048        0.000041        0.000034        0.000035        0.000036
bench_Process_stats_children      0.000042        0.000038        0.000034        0.000031        0.000032
bench_Process_stats_self          0.000048        0.000046        0.000032        0.000033        0.000035
bench_Spawn_ps_rss                0.050123        0.020579        0.043924        0.058219        0.064938
bench_System_uname                0.000042        0.000031        0.000027        0.000027        0.000026


Finished benchmarks in 0.673457s, 8.9093 tests/s, 8.9093 assertions/s.

6 tests, 6 assertions, 0 failures, 0 errors, 0 skips
```

The above was running on my personal Macbook Pro development laptop
instead of one of the target Linux systems, but similar orders of magnitude
differences were recorded for our intended target too (I no longer work
there so I can't run on that target host type now).

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
