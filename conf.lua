local bg
local logger
if os.getenv('FG') then
    bg = false
    logger = '| tee'
end

box = {
    listen = os.getenv("LISTEN") or "127.0.0.1:3301",
    memtx_memory = 256 * 1024 * 1024, -- 256 MB
    background = bg,
    log = logger,
}

app = {
    http_ip = os.getenv("HTTP_IP") or "0.0.0.0",
    http_port = os.getenv("HTTP_PORT") or 12345,
}
