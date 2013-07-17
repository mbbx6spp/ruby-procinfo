# procinfo

A Ruby/C extension packaged as a gem that provides a more uniform interface
to \*NIX process, system, and socket information.


At the moment it only implements process information retrieved from the
`getrusage` POSIX system call for the current process (`SELF`). Therefore,
this is compatible with POSIX-compatible OSes.

More is coming.

## Motivation

I really needed to be able to get current RSS and max RSS information (and
related process information) for a given process (which may or may not be
the current running process). No Ruby library (as far as I found offered a
consistent view of this information across the most \*NIX OSes).

## Related Works

`sys-proctable` is Ruby/C extension library that provides this to some
degree. I wanted to use a different approach to this library and lower
overhead, and compatibility of APIs exposed for all the supporting OSes.

However, the above mentioned library may offer what you need.

## License

This code is shared under the BSD 3-clause license. See LICENSE for
more information.

## Author(s)

* [Susan Potter](http://susanpotter.net) <me at susanpotter do net> (mbbx6spp on GitHub)

## Contributor(s)

N/A
