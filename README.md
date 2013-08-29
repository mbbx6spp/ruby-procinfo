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
