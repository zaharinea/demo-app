local spacer = require 'spacer'

spacer.create_space('demo', {
        { name = 'id', type = 'unsigned' },
        { name = 'name', type = 'string', is_nullable = true },
    }, {
        { name = 'primary', type = 'tree', unique = true, parts = {'id'}, sequence = true },
        { name = 'name', type = 'tree', unique = false, parts = {'name', 'id'} },
    }
)