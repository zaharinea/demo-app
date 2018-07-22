local log = require "log"
local json = require("json")
local http_server = require("http.server")

local M = {
    http_ip = "127.0.0.1",
    http_port = 12345,
    httpd = nil
}
local app

function M.init(config)
    app = require "app"
    M.config = config
    if config.http_ip ~= nil then
        M.http_ip = config.http_ip or M.http_ip
    end
    if config.http_port ~= nil then
        M.http_port = config.http_port or M.http_port
    end
    M.httpd = http_server.new(M.http_ip, M.http_port, {log_requests = false, log_errors = false})
    M.httpd:route({path = "/demo", method = "GET"}, M.handler_demo_list)
    M.httpd:route({path = "/demo/:id", method = "GET"}, M.handler_demo_get)
    M.httpd:route({path = "/demo", method = "POST"}, M.handler_demo_add)
    M.httpd:route({path = "/demo/:id", method = "PUT"}, M.handler_demo_update)
    M.httpd:route({path = "/demo/:id", method = "DELETE"}, M.handler_demo_delete)
    M.httpd:start()
end

function M.error(code, message)
    return {
        status = code,
        headers = {["content-type"] = "application/json; charset=utf8"},
        body = json.encode(
            {
                code = code,
                message = message
            }
        )
    }
end

function M.response(status, body)
    return {
        status = status,
        headers = {["content-type"] = "application/json; charset=utf8"},
        body = json.encode(body)
    }
end

function M.handler_demo_list(req)
    local body = app.demo.list()
    return M.response(200, body)
end

function M.handler_demo_get(req)
    local id = tonumber(req:stash("id"))
    -- local res, err = app.demo.get(id)
    local ok, res, err = pcall(app.demo.get, id)
    if not ok then
        return M.error(500, "Internal Server Error")
    end
    if res == nil then
        return M.error(400, err)
    end
    return M.response(200, res)
end

function M.handler_demo_add(req)
    local params = req:param()
    -- local name = req:param('name')
    local ok, res, err = pcall(app.demo.add, params)
    if not ok then
        return M.error(500, "Internal Server Error")
    end
    if res == nil then
        return M.error(400, err)
    end
    return M.response(201, res)
end

function M.handler_demo_update(req)
    local params = req:param()
    params.id = tonumber(req:stash("id"))
    local ok, res, err = pcall(app.demo.update, params)
    if not ok then
        return M.error(500, "Internal Server Error")
    end
    if res == nil then
        return M.error(400, err)
    end
    return M.response(200, res)
end

function M.handler_demo_delete(req)
    local id = tonumber(req:stash("id"))
    local ok, res, err = pcall(app.demo.delete, id)
    if not ok then
        return M.error(500, "Internal Server Error")
    end
    if res == nil then
        return M.error(400, err)
    end
    return M.response(200, res)
end

function M.destroy()
    M.httpd:stop()
end

return M
