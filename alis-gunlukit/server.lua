-- AYARLAR
local KIT_ITEM = "kit" -- Verilecek item adı (Örn: bread, water, bandage)
local KIT_ADET = 10      -- Kaç tane verilecek
local COOLDOWN = 86400   -- 24 saat (Saniye cinsinden)

RegisterCommand('gunlukit', function(source, args, rawCommand)
    local src = source
    
    -- Konsol kullanımı engelle
    if src == 0 then return end 

    -- Oyuncu lisansını al (Identifier)
    local identifier = GetPlayerIdentifierByType(src, 'license')
    local currentTime = os.time()

    if not identifier then return end

    -- Veritabanından kontrol et
    exports.oxmysql:scalar('SELECT last_claim FROM daily_kits_standalone WHERE identifier = ?', {identifier}, function(lastClaim)
        
        if lastClaim and (currentTime - lastClaim) < COOLDOWN then
            -- Kalan süreyi hesapla
            local remainingSeconds = COOLDOWN - (currentTime - lastClaim)
            local hours = math.floor(remainingSeconds / 3600)
            local minutes = math.floor((remainingSeconds % 3600) / 60)
            
            -- Ox_lib bildirimi (Eğer yüklü değilse chat mesajı gönderir)
            TriggerClientEvent('ox_lib:notify', src, {
                title = 'Günlük Kit',
                description = 'Zaten kitini aldın! Tekrar almak için ' .. hours .. ' saat ' .. minutes .. ' dakika beklemelisin.',
                type = 'error'
            })
        else
            -- Ox Inventory: Eşyayı taşıyabilir mi kontrolü
            if exports.ox_inventory:CanCarryItem(src, KIT_ITEM, KIT_ADET) then
                
                -- Eşyayı ver
                exports.ox_inventory:AddItem(src, KIT_ITEM, KIT_ADET)

                TriggerClientEvent('ox_lib:notify', src, {
                    title = 'Başarılı',
                    description = KIT_ADET .. ' adet ' .. KIT_ITEM .. ' envanterine eklendi.',
                    type = 'success'
                })

                -- Veritabanını güncelle
                exports.oxmysql:execute('INSERT INTO daily_kits_standalone (identifier, last_claim) VALUES (?, ?) ON DUPLICATE KEY UPDATE last_claim = ?', 
                {identifier, currentTime, currentTime})
            else
                TriggerClientEvent('ox_lib:notify', src, {
                    title = 'Envanter Dolu',
                    description = 'Üzerinde yeterli yer yok!',
                    type = 'error'
                })
            end
        end
    end)
end, false) -- 'false' herkesin kullanabileceği anlamına gelir.