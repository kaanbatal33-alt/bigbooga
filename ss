-- BIG BOOGA DIG | YÜKSEKLİK AYARLI AUTO-FARM
local SellPos = Vector3.new(-95, 12, 59) -- Y (Yükseklik) 6 yapıldı (Satışı algılaması için)
local DigPos = Vector3.new(-63, 6, 92)  -- Y (Yükseklik) 6 yapıldı (Kumda takılmaması için)

-- AYARLAR
local KazmaSuresi = 100 -- 30 saniye kazış
local SatisSuresi = 10  -- Satış alanında bekleme süresi (1 saniye artırıldı garanti olsun)
local TiklamaHizi = 0.5     

local Player = game.Players.LocalPlayer
local HRP = Player.Character:WaitForChild("HumanoidRootPart")
local VU = game:GetService("VirtualUser")

_G.AutoFarm = true

task.spawn(function()
    while _G.AutoFarm do
        -- 1. KAZMAYA GİT VE KAZ
        print("Kazmaya gidiliyor...")
        HRP.CFrame = CFrame.new(DigPos)
        task.wait(1)
        
        local startTime = tick()
        while tick() - startTime < KazmaSuresi and _G.AutoFarm do
            -- Tıklama Komutları
            VU:CaptureController()
            VU:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(TiklamaHizi)
            VU:Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end
        
        -- 2. SATIŞA GİT VE BEKLE
        print("Satışa gidiliyor...")
        -- Karakteri tam havadan satış alanına bırakıyoruz
        HRP.CFrame = CFrame.new(SellPos)
        task.wait(SatisSuresi) 
    end
end)
