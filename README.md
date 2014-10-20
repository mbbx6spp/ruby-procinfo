# procinfo

![Travis CI build status](https://api.travis-ci.org/mbbx6spp/ruby-procinfo.png)

A Ruby/C extension packaged as a gem that provides a more uniform interface
to \*NIX process, system, and socket information.


At the moment it only implements process information retrieved from the
`getrusage` POSIX system call for the current process (`SELF`) and children
processes (`CHILDREN`) plus uname system information.

This is compatible with POSIX-compatible OSes.

## Example Usage

Retrieve rusage stats for all children processes:

```ruby
stats = Process.stats(:children)
puts stats.user_time, stats.system_time
# some useful fields, but few others supported
puts stats.max_rss
puts stats.page_faults
puts stats.msgs_sent
puts stats.msgs_recvd
puts stats.signals_recvd
puts stats.shared_text_size
puts stats.swaps
puts stats.block_input_ops
puts stats.block_output_ops
```

You can also get uname information about the system your process is running
on:

```ruby
sysinfo = System.uname
puts sysinfo.sysname
puts sysinfo.nodename
puts sysinfo.release
puts sysinfo.version
puts sysinfo.machine
```

## Microbenchmarks

The reason I even bothered writing this tiny, focused gem is because while on 
vacation at a Rails shop I used to work at someone added a `ps ef | awk ...`
shell from the Rails app ever 10th request to get the RSS and decide if we
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

The above was running on my personal Macbook Pro development laptop instead of one of the 
target Linux systems, but similar orders of magnitude differences were recorded for our 
intended target too (I no longer work there so I can't run on that target host type now).

The point of the above isn't to pat myself on the back rather just to ensure I'm not smoking
crack when I introduce new APIs and/or fix any bugs.

You should always sanity check your assumption. Some assumptions are completely flawed, but
even ones that seem reasonable should be validated in some scope and form.

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
