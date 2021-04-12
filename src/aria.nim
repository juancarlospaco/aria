## Aria2 API lib for Nim using local JSON-RPC over HTTP GET for any backend.
## * https://aria2.github.io
## * https://aria2.github.io/manual/en/html/aria2c.html#methods
from std/base64 import encode

template getVersion*(): string = "http://127.0.0.1:6800/jsonrpc?id=nim&method=aria2.getVersion"

template tellActive*(): string = "http://127.0.0.1:6800/jsonrpc?id=nim&method=aria2.tellActive"

template listNotifications*(): string = "http://127.0.0.1:6800/jsonrpc?id=nim&method=system.listNotifications"

template pauseAll*(): string = "http://127.0.0.1:6800/jsonrpc?id=nim&method=aria2.pauseAll"

template forcePauseAll*(): string = "http://127.0.0.1:6800/jsonrpc?id=nim&method=aria2.forcePauseAll"

template unpauseAll*(): string = "http://127.0.0.1:6800/jsonrpc?id=nim&method=aria2.unpauseAll"

template getGlobalOption*(): string = "http://127.0.0.1:6800/jsonrpc?id=nim&method=aria2.getGlobalOption"

template getGlobalStat*(): string = "http://127.0.0.1:6800/jsonrpc?id=nim&method=aria2.getGlobalStat"

template purgeDownloadResult*(): string = "http://127.0.0.1:6800/jsonrpc?id=nim&method=aria2.purgeDownloadResult"

template getSessionInfo*(): string = "http://127.0.0.1:6800/jsonrpc?id=nim&method=aria2.getSessionInfo"

template shutdown*(): string = "http://127.0.0.1:6800/jsonrpc?id=nim&method=aria2.shutdown"

template forceShutdown*(): string = "http://127.0.0.1:6800/jsonrpc?id=nim&method=aria2.forceShutdown"

template saveSession*(): string = "http://127.0.0.1:6800/jsonrpc?id=nim&method=aria2.saveSession"

template urlify(endpoint: static[string]; gid: string): string =
  when not defined(danger):
    if not gid.len > 0:
      raise newException(ValueError, "GID argument must not be empty string")
  "http://127.0.0.1:6800/jsonrpc?id=nim&method=aria2." & endpoint & "&params=" & encode($([[gid]]))

template remove*(gid: string): string = urlify("remove", gid)

template forceRemove*(gid: string): string = urlify("forceRemove", gid)

template pause*(gid: string): string = urlify("pause", gid)

template forcePause*(gid: string): string = urlify("forcePause", gid)

template unpause*(gid: string): string = urlify("unpause", gid)

template tellStatus*(gid: string): string = urlify("tellStatus", gid)

template getUris*(gid: string): string = urlify("getUris", gid)

template getFiles*(gid: string): string = urlify("getFiles", gid)

template getPeers*(gid: string): string = urlify("getPeers", gid)

template getServers*(gid: string): string = urlify("getServers", gid)

template getOption*(gid: string): string = urlify("getOption", gid)

template removeDownloadResult*(gid: string): string = urlify("removeDownloadResult", gid)

template addUrl*(url: string): string =
  when not defined(danger):
    if not url.len > 0:
      raise newException(ValueError, "url argument must not be empty string")
  "http://127.0.0.1:6800/jsonrpc?id=nim&method=aria2.addUri&params=" & encode($([[url]]))

template addTorrent*(torrent: string): string =
  when not defined(danger):
    if not torrent.len > 0:
      raise newException(ValueError, "torrent argument must not be empty string")
  "http://127.0.0.1:6800/jsonrpc?id=nim&method=aria2.addTorrent&params=" & encode($([[torrent]]))

template addMetalink*(metalink: string): string =
  when not defined(danger):
    if not metalink.len > 0:
      raise newException(ValueError, "metalink argument must not be empty string")
  "http://127.0.0.1:6800/jsonrpc?id=nim&method=aria2.addMetalink&params=" & encode($([[metalink]]))

when not defined(js):
  import std/osproc
  from std/os import sleep
  export Process, terminate, close

  template aria*(code: untyped): untyped =
    var proces: Process
    try:
      proces = startProcess("aria2c --no-conf=true --enable-color=false --daemon=true --enable-rpc=true --rpc-allow-origin-all=true --rpc-listen-all=false --interface='127.0.0.1' --check-certificate=false --rpc-secure=false", options = {poStdErrToStdOut, poEvalCommand, poDaemon})
      sleep 2_000  # Maybe the sleeps can be removed?, I havent tested much.
      code
    finally:
      proces.terminate()
      sleep 1_000
      proces.close()


runnableExamples:
  import std/httpclient
  ## "aria" template activates an Aria process daemon.
  ## "aria" template does NOT work in JavaScript, because browser cant run processes,
  ## but you can use the Aria API from the browser on a running Aria process daemon.
  ##
  ## IP is 127.0.0.1 because is not safe to expose RPC to Internet.
  ## Port is 6800 because is Default, you only need 1 Aria process.
  aria:
    ## You need any HTTP Client, you can use std/fetch for JavaScript.
    let client = newHttpClient()
    ## These are just Aria API calls, same naming as from Aria Documentation.
    echo client.getContent(getVersion())
    ## Just 1 simple HTTP GET, no Headers, no Body, no Form-data.
    echo client.getContent(listNotifications())
    ## The lib only uses std/base64.encode() so is very future-proof.
    echo client.getContent(getSessionInfo())
    ## The lib is only a few simple template, works everywhere with good performance.
    echo client.getContent(getGlobalStat())
    echo client.getContent(getGlobalOption())
    echo client.getContent(tellActive())
    ## echo client.getContent(addUrl("http://nim-lang.org"))
    ## See also addTorrent() and addMetalink()
