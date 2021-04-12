# Aria

[Aria2](https://aria2.github.io) API lib for [Nim](https://nim-lang.org) using JSON-RPC over HTTP for any backend.

* https://aria2.github.io
* https://aria2.github.io/manual/en/html/aria2c.html#methods


# Use

```nim
import aria
import std/httpclient

aria:
  ## You need any HTTP Client, you can use std/fetch for JavaScript.
  let client = newHttpClient()
  ## These are just Aria API calls, same naming as from Aria Documentation.
  echo client.getContent(getVersion())
  ## See also addTorrent(), addMetalink(), addUrl(), etc
```
