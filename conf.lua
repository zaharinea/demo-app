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
    http_ip = "127.0.0.1",
    http_port = 12345,
}
