# Aria

[Aria2](https://aria2.github.io) API lib for [Nim](https://nim-lang.org) using JSON-RPC over HTTP for any backend.

* https://aria2.github.io
* https://aria2.github.io/manual/en/html/aria2c.html#methods
* https://juancarlospaco.github.io/aria/index.html


# Use

```nim
import aria
import std/json  # $

let client: Aria = newAria(ip = "127.0.0.1", port = 6800.uint16)
aria:
  ## These are just Aria API calls, same naming as from Aria Documentation.
  echo client.getVersion()
  ## See also addTorrent(), addMetalink(), addUrl(), etc
```

Aria in the Browser, JavaScript target:

```nim
import aria
import std/[jsffi, jsfetch]  ## fetch()

let client: Aria = newAria(ip = "127.0.0.1", port = 6800.uint16)
echo client.getVersion().repr
```
