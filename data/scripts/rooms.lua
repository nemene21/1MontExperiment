
ROOM_TILESET = newSpritesheet("data/graphics/images/tileset.png", 16, 16)

function newRoom(y, layout)

    local room = {

        y = y,

        drawBg = drawRoomBg,
        drawFg = drawRoomFg,
        
        enemies     = {},
        enemySpawns = {}

    }

    room.bgTilemap = newTilemap(ROOM_TILESET, 48, {}, newVec(0, y)) -- Background

    for Tx=0, 16 do

        for Ty=0, 11 do

            local tileToPlace = math.floor(math.abs(love.math.noise(Tx * 0.2, (Ty + y / WS[2] * 12) * 0.2)) * 3)

            room.bgTilemap:setTile(Tx, Ty, {1 + tileToPlace, 1})

        end

    end

    room.tilemap = newTilemap(ROOM_TILESET, 48, layout, newVec(0, y)) -- Foreground
    room.tilemap:buildColliders()

    return room

end

function drawRoomBg(this)

    this.bgTilemap:draw()

end

function drawRoomFg(this)

    local kill = {}
    for id, enemySpawn in ipairs(this.enemySpawns) do

        enemySpawn:process()

        enemySpawn.timer = enemySpawn.timer - dt

        if enemySpawn.timer < 0 then

            enemySpawn.ticks = 0

            table.insert(this.enemies, enemySpawn.enemy)
            table.insert(kill, id)
            table.insert(particleSystems, enemySpawn)

        end

    end this.enemySpawns = wipeKill(kill, this.enemySpawns)

    this.tilemap:draw()

end