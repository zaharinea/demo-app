local log = require 'log'

local M = {}
local app

function M.init(config)
    app = require 'app'
    M.config = config
end

function M.list()
    local res = {}
    for _, demo_ref in box.space.demo:pairs() do
        table.insert(res, T.demo.dict(demo_ref))
    end
    -- collectgarbage('collect') --  25x speed
    return res
end

function M.get(id) 
    local demo_ref = box.space.demo:get(id)
    if demo_ref == nil then
        return nil, string.format("Entity with id=%s not found", id)
    end
    return T.demo.dict(demo_ref)
end 

function M.add(obj) 
    local demo_ref = box.space.demo:insert({
        [F.demo.name] = nil,
        [F.demo.name] = obj.name
    })
    return T.demo.dict(demo_ref)
end 

function M.replace(obj) 
    local demo_ref = box.space.demo:replace({
        [F.demo.name] = obj.id,
        [F.demo.name] = obj.name
    })
    if demo_ref == nil then
        return nil, string.format("Entity with id=%s not found", obj.id)
    end
    return T.demo.dict(demo_ref)
end 

function M.update(obj) 
    local demo_ref = box.space.demo:update({obj.id}, {{'=', F.demo.name, obj.name}})
    if demo_ref == nil then
        return nil, string.format("Entity with id=%s not found", obj.id)
    end
    return T.demo.dict(demo_ref)
end 

function M.delete(id) 
    local demo_ref = box.space.demo:delete(id)
    if demo_ref == nil then
        return nil, string.format("Entity with id=%s not found", id)
    end
    return T.demo.dict(demo_ref)
end
    
function M.destroy()

end

return M
