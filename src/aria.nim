## Aria2 API lib for Nim using local JSON-RPC over HTTP GET for any backend.
## * https://aria2.github.io
## * https://aria2.github.io/manual/en/html/aria2c.html#methods
from std/base64 import encode

type Aria* = object
  ip*: string
  port*: uint16

func newAria*(ip = "127.0.0.1"; port = 6800.uint16): Aria =
  if not ip.len > 1: raise newException(ValueError, "IP argument must not be empty string")
  if not(port > 1024.uint16 and port < 65535.uint16): raise newException(ValueError, "Port argument must be uint16, >1024 and <65535")
  result.ip = ip
  result.port = port

when defined(js):
  import std/[jsfetch, asyncjs, jsffi]

  proc getVersion*(self: Aria): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.getVersion")))

  proc tellActive*(self: Aria): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.tellActive")))

  proc listNotifications*(self: Aria): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=system.listNotifications")))

  proc pauseAll*(self: Aria): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.pauseAll")))

  proc forcePauseAll*(self: Aria): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.forcePauseAll")))

  proc unpauseAll*(self: Aria): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.unpauseAll")))

  proc getGlobalOption*(self: Aria): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.getGlobalOption")))

  proc getGlobalStat*(self: Aria): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.getGlobalStat")))

  proc purgeDownloadResult*(self: Aria): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.purgeDownloadResult")))

  proc getSessionInfo*(self: Aria): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.getSessionInfo")))

  proc shutdown*(self: Aria): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.shutdown")))

  proc forceShutdown*(self: Aria): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.forceShutdown")))

  proc saveSession*(self: Aria): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.saveSession")))

  proc remove*(self: Aria; gid: string): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.remove&params=" & encode($([[gid]])))))

  proc forceRemove*(self: Aria; gid: string): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.forceRemove&params=" & encode($([[gid]])))))

  proc pause*(self: Aria; gid: string): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.pause&params=" & encode($([[gid]])))))

  proc forcePause*(self: Aria; gid: string): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.forcePause&params=" & encode($([[gid]])))))

  proc unpause*(self: Aria; gid: string): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.unpause&params=" & encode($([[gid]])))))

  proc tellStatus*(self: Aria; gid: string): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.tellStatus&params=" & encode($([[gid]])))))

  proc getUris*(self: Aria; gid: string): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.getUris&params=" & encode($([[gid]])))))

  proc getFiles*(self: Aria; gid: string): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.getFiles&params=" & encode($([[gid]])))))

  proc getPeers*(self: Aria; gid: string): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.getPeers&params=" & encode($([[gid]])))))

  proc getServers*(self: Aria; gid: string): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.getServers&params=" & encode($([[gid]])))))

  proc getOption*(self: Aria; gid: string): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.getOption&params=" & encode($([[gid]])))))

  proc removeDownloadResult*(self: Aria; gid: string): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.removeDownloadResult&params=" & encode($([[gid]])))))

  proc addUrl*(self: Aria; url: string): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.addUri&params=" & encode($([[url]])))))

  proc addTorrent*(self: Aria; torrent: string): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.addTorrent&params=" & encode($([[torrent]])))))

  proc addMetalink*(self: Aria; metalink: string): Future[JsObject] {.async.} =
    json(await fetch(cstring("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.addMetalink&params=" & encode($([[metalink]])))))
else:
  import std/[osproc, httpclient, json, os]

  template clientify(url: string): JsonNode =
    let
      client = newHttpClient()
      results = parseJson(client.getContent(url))
    client.close()
    results

  proc getVersion*(self: Aria): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.getVersion")

  proc tellActive*(self: Aria): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.tellActive")

  proc listNotifications*(self: Aria): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=system.listNotifications")

  proc pauseAll*(self: Aria): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.pauseAll")

  proc forcePauseAll*(self: Aria): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.forcePauseAll")

  proc unpauseAll*(self: Aria): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.unpauseAll")

  proc getGlobalOption*(self: Aria): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.getGlobalOption")

  proc getGlobalStat*(self: Aria): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.getGlobalStat")

  proc purgeDownloadResult*(self: Aria): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.purgeDownloadResult")

  proc getSessionInfo*(self: Aria): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.getSessionInfo")

  proc shutdown*(self: Aria): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.shutdown")

  proc forceShutdown*(self: Aria): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.forceShutdown")

  proc saveSession*(self: Aria): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.saveSession")

  proc remove*(self: Aria; gid: string): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.remove&params=" & encode($([[gid]])))

  proc forceRemove*(self: Aria; gid: string): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.forceRemove&params=" & encode($([[gid]])))

  proc pause*(self: Aria; gid: string): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.pause&params=" & encode($([[gid]])))

  proc forcePause*(self: Aria; gid: string): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.forcePause&params=" & encode($([[gid]])))

  proc unpause*(self: Aria; gid: string): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.unpause&params=" & encode($([[gid]])))

  proc tellStatus*(self: Aria; gid: string): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.tellStatus&params=" & encode($([[gid]])))

  proc getUris*(self: Aria; gid: string): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.getUris&params=" & encode($([[gid]])))

  proc getFiles*(self: Aria; gid: string): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.getFiles&params=" & encode($([[gid]])))

  proc getPeers*(self: Aria; gid: string): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.getPeers&params=" & encode($([[gid]])))

  proc getServers*(self: Aria; gid: string): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.getServers&params=" & encode($([[gid]])))

  proc getOption*(self: Aria; gid: string): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.getOption&params=" & encode($([[gid]])))

  proc removeDownloadResult*(self: Aria; gid: string): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.removeDownloadResult&params=" & encode($([[gid]])))

  proc addUrl*(self: Aria; url: string): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.addUri&params=" & encode($([[url]])))

  proc addTorrent*(self: Aria; torrent: string): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.addTorrent&params=" & encode($([[torrent]])))

  proc addMetalink*(self: Aria; metalink: string): JsonNode =
    clientify("http://" & self.ip & ':' & $self.port & "/jsonrpc?id=nim&method=aria2.addMetalink&params=" & encode($([[metalink]])))

  template aria*(code: untyped): untyped =
    var proces: Process
    try:
      proces = startProcess("aria2c --no-conf=true --enable-color=false --daemon=true --enable-rpc=true --rpc-allow-origin-all=true --rpc-listen-all=false --interface='127.0.0.1' --check-certificate=false --rpc-secure=false", options = {poStdErrToStdOut, poEvalCommand, poDaemon})
      sleep 2_000  # Maybe the sleeps can be removed?.
      code
    finally:
      proces.terminate()
      sleep 1_000
      proces.close()


runnableExamples:
  import std/[json, osproc]  ## json.$, startProcess
  ## "aria" template activates an Aria process daemon.
  ## "aria" template does NOT work in JavaScript, because browser cant run processes,
  ## but you can use the Aria API from the browser on a running Aria process daemon.
  let client: Aria = newAria(ip = "127.0.0.1", port = 6800.uint16)
  aria:
    ## These are just Aria API calls, same naming as from Aria Documentation.
    echo client.getVersion()
    echo client.listNotifications()
    echo client.getSessionInfo()
    echo client.getGlobalStat()
    echo client.getGlobalOption()
    echo client.tellActive()
    ## echo client.addUrl("http://nim-lang.org")
    ## See also addTorrent() and addMetalink()

runnableExamples("-r:off -b:js -d:nimExperimentalJsfetch -d:nimExperimentalAsyncjsThen"):
  import std/jsfetch  ## fetch()
  let client: Aria = newAria(ip = "127.0.0.1", port = 6800.uint16)
  echo client.getVersion().repr
