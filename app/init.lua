local conf = require 'config'
local log = require 'log'

box.once('access:v1', function()
    box.schema.user.grant('guest', 'read,write,execute', 'universe')
    -- Uncomment this to create user demo-app_user
    -- box.schema.user.create('demo-app_user', { password = 'demo-app_pass' })
    -- box.schema.user.grant('demo-app_user', 'read,write,execute', 'universe')
end)

local app = {
    models = require 'models',
    http = require 'http',
    demo = require 'demo',
}

function app.init(config)
    log.info('app "demo-app" init')


    for k, mod in pairs(app) do if type(mod) == 'table' and mod.init ~= nil then mod.init(config) end end
end

function app.destroy()
    log.info('app "demo-app" destroy')

    for k, mod in pairs(app) do if type(mod) == 'table' and mod.destroy ~= nil then mod.destroy() end end
end

package.reload:register(app)
rawset(_G, 'app', app)
return app
