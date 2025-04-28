-- i made this for my alts to farm, so not all functions were made to be retard proof or amazing, most guis will have more stuff as well.
-- but feel free to use or skid this. 🙂👍

-- v1.4 ; loadstring(game:HttpGet("https://raw.githubusercontent.com/s-eths/bubble-gum-simulator-infinity/refs/heads/main/main.lua", true))();

getgenv().Functions = {
    AutoBlowBubbles = false;
    AutoSell = false;
    AutoCollectPickups = false;
    FasterEggs = false;

    AutoClaimPlaytimeRewards = false;
    AutoClaimSeasonRewards = false;
    AutoClaimWheelSpin = false;
    AutoClaimChests = false;
    AutoBuyFromMarkets = false;
    AutoOpenMysteryBox = false;
    AutoGenieQuest = false;

    UseGoldenKeys = false;
    UseRoyalKeys = false;
    
    Disable3DRendering = false;
    BlackOutScreen = false;
    FixFPSCap = false;
};

for i, v in next, getconnections(game:GetService("Players").LocalPlayer.Idled) do
    v:Disable();
end;

local function CollectPickups()
    for i, v in next, game:GetService("Workspace").Rendered:GetChildren() do
        if v.Name == "Chunker" then
            for i2, v2 in next, v:GetChildren() do
                local Part, HasMeshPart = v2:FindFirstChild("Part"), v2:FindFirstChildWhichIsA("MeshPart");
                local HasStars = Part and Part:FindFirstChild("Stars");
                local HasPartMesh = Part and Part:FindFirstChild("Mesh");
                if HasMeshPart or HasStars or HasPartMesh then
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Pickups"):WaitForChild("CollectPickup"):FireServer(v2.Name);
                    v2:Destroy();
                end;
            end;
        end;
    end;
end;

local function TweenTo(Position, Speed)
    local CFrameValue = Instance.new("CFrameValue");

    CFrameValue.Value = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame;
    CFrameValue:GetPropertyChangedSignal("Value"):Connect(function()
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameValue.Value;
    end);

    game:GetService("TweenService"):Create(CFrameValue, TweenInfo.new(Speed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Value = Position}):Play();
end;

local function FancyNumberTranslator(FancyNumber)
    local FancyNumbers = {
        ["I"] = 1;
        ["II"] = 2;
        ["III"] = 3;
        ["IV"] = 4;
        ["V"] = 5;
        ["VI"] = 6;
    };

    return FancyNumbers[FancyNumber];
end;

local function GetTimerText(Text)
    local Hour, Minute, Second = string.match(Text, "^(%d+):(%d%d):(%d%d)$");

    if Hour and Minute and Second then
        return string.format("%02d:%02d:%02d", tonumber(Hour), tonumber(Minute), tonumber(Second));
    end;

    local Minute, Second = string.match(Text, "^(%d+):(%d%d)$");

    if Minute and Second then
        return string.format("00:%02d:%02d", tonumber(Minute), tonumber(Second));
    end;

    local Second = string.match(Text, "^(%d+)$");

    if Second then
        return string.format("00:00:%02d", tonumber(Second));
    end;

    return nil;
end;

local function CapitalizeTimeUnit(String)
    local Number, Unit = String:match("^(%d+)%s*(%a+)$");

    if Number and Unit then
        Unit = Unit:sub(1, 1):upper() .. Unit:sub(2);
        return Number .. " " .. Unit;
    else
        return String;
    end;
end;

local function FetchRiftEggs(x25)
    local FoundRiftEggs = {};
    local Foundx25Eggs = {};

    for i, v in next, game:GetService("Workspace").Rendered.Rifts:GetChildren() do
        if not table.find({"golden-chest", "royal-chest", "gift-rift"}, v.Name) then
            if v.Display.SurfaceGui.Icon.Luck.Text == "x25" then
                table.insert(Foundx25Eggs, v);
            else
                table.insert(FoundRiftEggs, v);
            end;
        end;
    end;
    
    if x25 then
        return Foundx25Eggs;
    else
        return FoundRiftEggs;
    end;
end;

local Repository = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/";
local Library = loadstring(game:HttpGet(Repository .. "Library.lua"))();
local ThemeManager = loadstring(game:HttpGet(Repository .. "addons/ThemeManager.lua"))();
local SaveManager = loadstring(game:HttpGet(Repository .. "addons/SaveManager.lua"))();

local Options = Library.Options;
local Toggles = Library.Toggles;

local Window = Library:CreateWindow({
    Title = "cca is a monkey 🐒";
    Footer = "Made by @s.eths | v1.4c";
    NotifySide = "Right";
    ShowCustomCursor = true;
});

if game:GetService("Players").LocalPlayer.Name == "purewoozy" then
    Library:Notify({
        Title = "BANANAAAAAA 🍌";
        Description = "OOO AAAA OOOO AAAA OOOO AAA";
        Time = 4;
    });
end;

local Tabs = {
    Main = Window:AddTab("Main", "user");
    Potions = Window:AddTab("Potions", "beer");
    Rifts = Window:AddTab("Rifts", "atom");
    Teleports = Window:AddTab("Teleports", "globe");
    CPUSettings = Window:AddTab("CPU Settings", "cpu");
    ["UI Settings"] = Window:AddTab("UI Settings", "settings");
};

local TabsMainFunctions = Tabs.Main:AddLeftGroupbox("Main Functions");

TabsMainFunctions:AddToggle("AutoBlowBubbles", {
    Text = "Auto Blow Bubbles";
    Default = false;

    Callback = function(Value)
        getgenv().Functions.AutoBlowBubbles = Value;
        task.spawn(function()
            while Functions.AutoBlowBubbles do
                task.wait();
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("BlowBubble");
            end;
        end);
    end;
});

TabsMainFunctions:AddToggle("AutoSell", {
    Text = "Auto Sell";
    Default = false;

    Callback = function(Value)
        getgenv().Functions.AutoSell = Value;
        task.spawn(function()
            while Functions.AutoSell do
                task.wait();
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("SellBubble");
            end;
        end);
    end;
});

TabsMainFunctions:AddToggle("AutoCollectPickups", {
    Text = "Auto Collect Pickups";
    Default = false;

    Callback = function(Value)
        getgenv().Functions.AutoCollectPickups = Value;
        task.spawn(function()
            while Functions.AutoCollectPickups do
                CollectPickups();
                task.wait(1);
            end;
        end);
    end;
});

TabsMainFunctions:AddToggle("FasterEggs", {
    Text = "Faster Eggs";
    Default = false;

    Callback = function(Value)
        getgenv().Functions.FasterEggs = Value;
        task.spawn(function()
            while Functions.FasterEggs do
                game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.R, false, game);
                task.wait();
                game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.R, false, game);
            end;
        end);
    end;
});

local TabsToggles = Tabs.Main:AddLeftGroupbox("Quick Toggles");

local UntoggleAll = TabsToggles:AddButton({
    Text = "Toggle Best";

    Func = function()
        Toggles.AutoBlowBubbles:SetValue(true);
        Toggles.AutoCollectPickups:SetValue(true);
        Toggles.FasterEggs:SetValue(true);
        Toggles.AutoClaimPlaytimeRewards:SetValue(true);
        Toggles.AutoClaimSeasonRewards:SetValue(true);
        Toggles.AutoClaimWheelSpin:SetValue(true);
        Toggles.AutoClaimChests:SetValue(true);
        Toggles.AutoBuyFromMarkets:SetValue(true);
        Toggles.AutoGenieQuest:SetValue(true);
    end;

    Tooltip = "WARNING: This will toggle:\nAutoBlowBubbles, AutoCollectPickups, FasterEggs\nAutoClaimPlaytimeRewards, AutoClaimWheelSpin, AutoClaimChests\nAutoBuyFromMarkets, AutoGenieQuest";
    Risky = true;
});

local UntoggleAll = TabsToggles:AddButton({
    Text = "Untoggle All";

    Func = function()
        Toggles.AutoBlowBubbles:SetValue(false);
        Toggles.AutoSell:SetValue(false);
        Toggles.AutoCollectPickups:SetValue(false);
        Toggles.FasterEggs:SetValue(false);
        Toggles.AutoClaimPlaytimeRewards:SetValue(false);
        Toggles.AutoClaimSeasonRewards:SetValue(false);
        Toggles.AutoClaimWheelSpin:SetValue(false);
        Toggles.AutoClaimChests:SetValue(false);
        Toggles.AutoBuyFromMarkets:SetValue(false);
        Toggles.AutoOpenMysteryBox:SetValue(false);
        Toggles.AutoGenieQuest:SetValue(false);
        Toggles.UseGoldenKeys:SetValue(false);
        Toggles.UseRoyalKeys:SetValue(false);
        Toggles.Disable3DRendering:SetValue(false);
        Toggles.BlackOutScreen:SetValue(false);
    end;

    Tooltip = "WARNING: This will untoggle EVERY toggle in the script.";
    Risky = true;
});

local TabsOtherFunctions = Tabs.Main:AddRightGroupbox("Other Functions");

TabsOtherFunctions:AddToggle("AutoClaimPlaytimeRewards", {
    Text = "Auto Claim Playtime Rewards";
    Default = false;

    Callback = function(Value)
        getgenv().Functions.AutoClaimPlaytimeRewards = Value;
        task.spawn(function()
            while Functions.AutoClaimPlaytimeRewards do
                for i = 1, 9 do
                    task.wait();
                    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Function"):InvokeServer("ClaimPlaytime", i);
                end;
                task.wait(60);
            end;
        end);
    end;
});

TabsOtherFunctions:AddToggle("AutoClaimWheelSpin", {
    Text = "Auto Claim Wheel Spin";
    Default = false;

    Callback = function(Value)
        getgenv().Functions.AutoClaimWheelSpin = Value;
        task.spawn(function()
            while Functions.AutoClaimWheelSpin do
                task.wait();
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("ClaimFreeWheelSpin");
            end;
        end);
    end;
});

TabsOtherFunctions:AddToggle("AutoClaimSeasonRewards", {
    Text = "Auto Claim Season Rewards";
    Default = false;

    Callback = function(Value)
        getgenv().Functions.AutoClaimSeasonRewards = Value;
        task.spawn(function()
            while Functions.AutoClaimSeasonRewards do
                task.wait();
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("ClaimSeason");
            end;
        end);
    end;
});

TabsOtherFunctions:AddToggle("AutoClaimChests", {
    Text = "Auto Claim Chests";
    Default = false;

    Callback = function(Value)
        getgenv().Functions.AutoClaimChests = Value;
        task.spawn(function()
            local Chests = {"Void Chest", "Giant Chest", "Infinity Chest"};
            while Functions.AutoClaimChests do
                for i, v in next, Chests do
                    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("ClaimChest", v, true);
                    task.wait(1);
                end;
                task.wait(60);
            end;
        end);
    end;
});

TabsOtherFunctions:AddToggle("AutoBuyFromMarkets", {
    Text = "Auto Buy From Markets";
    Default = false;

    Callback = function(Value)
        getgenv().Functions.AutoBuyFromMarkets = Value;
        task.spawn(function()
            while Functions.AutoBuyFromMarkets do
                local Markets = {"alien-shop", "shard-shop"};
                for _, v in next, Markets do
                    for i = 1, 3 do
                        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("BuyShopItem", v, i);
                    end;
                end;
                task.wait(60);
            end;
        end);
    end;
});

TabsOtherFunctions:AddToggle("AutoOpenMysteryBox", {
    Text = "Auto Open Mystery Box";
    Default = false;

    Callback = function(Value)
        getgenv().Functions.AutoOpenMysteryBox = Value;
        task.spawn(function()
            while Functions.AutoOpenMysteryBox do
                task.wait();
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("UseGift", "Mystery Box", 1);
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("UseGift", "Golden Box", 1);
                for i, v in next, game:GetService("Workspace").Rendered.Gifts:GetChildren() do
                    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("ClaimGift", v.Name);
                    task.wait();
                    v:Destroy();
                end;
            end;
        end);
    end;
});

TabsOtherFunctions:AddToggle("AutoGenieQuest", {
    Text = "Auto Genie Quest";
    Default = false;

    Callback = function(Value)
        getgenv().Functions.AutoGenieQuest = Value;
        task.spawn(function()
            while Functions.AutoGenieQuest do
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("StartGenieQuest", math.random(1, 3));
                task.wait(3600);
            end;
        end);
    end;
});

local RedeemAllCodes = TabsOtherFunctions:AddButton({
    Text = "Redeem All Codes";

    Func = function()
        local Codes = {"easter", "RELEASE", "Lucky", "Thanks"};
        for i, v in next, Codes do
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Function"):InvokeServer("RedeemCode", v);          
        end;
    end;
});

local TabsPotionsCraft = Tabs.Potions:AddLeftGroupbox("Craft");

local CraftLuckyPotions = TabsPotionsCraft:AddButton({
    Text = "Craft Lucky Potions";

    Func = function()
        for i = 2, 5 do
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("CraftPotion", "Lucky", i, true);
            task.wait(1);
        end;
    end;
});

local CraftSpeedPotions = TabsPotionsCraft:AddButton({
    Text = "Craft Speed Potions";

    Func = function()
        for i = 2, 5 do
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("CraftPotion", "Speed", i, true);
            task.wait(1);
        end;
    end;
});

local CraftCoinsPotions = TabsPotionsCraft:AddButton({
    Text = "Craft Coins Potions";

    Func = function()
        for i = 2, 5 do
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("CraftPotion", "Coins", i, true);
            task.wait(1);
        end;
    end;
});

local CraftMythicPotions = TabsPotionsCraft:AddButton({
    Text = "Craft Mythic Potions";

    Func = function()
        for i = 2, 5 do
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("CraftPotion", "Mythic", i, true);
            task.wait(1);
        end;
    end;
});

local CraftAllPotions = TabsPotionsCraft:AddButton({
    Text = "Craft All Potions";

    Func = function()
        local PotionTypes = {"Lucky", "Speed", "Coins", "Mythic"};

        for _, v in next, PotionTypes do
            for i = 2, 5 do
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("CraftPotion", v, i, true);
                task.wait(1);
            end;
        end;
    end;
});

local TabPotionsTimeLeft = Tabs.Potions:AddLeftGroupbox("Time Left");

local LuckyPotionTimeLeft = TabPotionsTimeLeft:AddLabel("Lucky Potion: 00:00:00");
local SpeedPotionTimeLeft = TabPotionsTimeLeft:AddLabel("Speed Potion: 00:00:00");
local MythicPotionTimeLeft = TabPotionsTimeLeft:AddLabel("Mythic Potion: 00:00:00");
local CoinsPotionTimeLeft = TabPotionsTimeLeft:AddLabel("Coins Potion: 00:00:00");
TabPotionsTimeLeft:AddDivider();
TabPotionsTimeLeft:AddLabel("Notice: Only displays Rarity V.");

task.spawn(function()
    while task.wait() do
        local PotionTypes = {
            Lucky = LuckyPotionTimeLeft;
            Speed = SpeedPotionTimeLeft;
            Mythic = MythicPotionTimeLeft;
            Coins = CoinsPotionTimeLeft;
        };

        for i, v in next, PotionTypes do
            local BuffsGUI = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Buffs:FindFirstChild(i)
            if BuffsGUI and BuffsGUI.Button and BuffsGUI.Button.Label and BuffsGUI.Button.Label.Text and BuffsGUI.Button.Icon:FindFirstChild("Potion" .. i .. "5") then
                local TimerText = GetTimerText(BuffsGUI.Button.Label.Text);
                if TimerText then
                    v:SetText(i .. " Potion: " .. TimerText);
                else
                    v:SetText(i .. " Potion: " .. CapitalizeTimeUnit(BuffsGUI.Button.Label.Text) .. "+");
                end;
            else
                v:SetText(i .. " Potion: 00:00:00");
            end;
        end;
    end;
end);

local TabsPotionsUse = Tabs.Potions:AddRightGroupbox("Use");

local SelectPotionType = TabsPotionsUse:AddDropdown("SelectPotionType", {
    Values = {"Lucky", "Speed", "Coins", "Mythic"};
    Default = 1;

    Text = "Select Potion Type";

    Callback = function(Value)
        return;
    end;
});

local SelectPotionRarity = TabsPotionsUse:AddDropdown("SelectPotionRarity", {
    Values = {"I", "II", "III", "IV", "V", "VI"};
    Default = 1;

    Text = "Select Potion Rarity";

    Callback = function(Value)
        return;
    end;
});

local SelectPotionAmount = TabsPotionsUse:AddSlider("SelectPotionAmount", {
    Text = "Select Potion Amount";
    Default = 1;
    Min = 1;
    Max = 100;
    Rounding = 1;

    Callback = function(Value)
        return;
    end;
});

local UsePotions = TabsPotionsUse:AddButton({
    Text = "Use Potions";

    Func = function()
        print()
        for i = 1, math.floor(SelectPotionAmount.Value + 0.5) do
            task.wait(0.3);
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("UsePotion", SelectPotionType.Value, FancyNumberTranslator(SelectPotionRarity.Value));
        end;
    end;
});

TabsPotionsUse:AddDivider();

local UseHatchingPotions = TabsPotionsUse:AddButton({
    Text = "Use Hatching Potions";

    Func = function()
        local PotionTypes = {"Lucky", "Speed", "Mythic"};

        for _, v in next, PotionTypes do
            for i = 1, 35 do
                task.wait(0.3);
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("UsePotion", v, 5);
            end;
        end;
    end;

    Tooltip = "WARNING: This will use 10 hours of Lucky V, Speed V and Mythic V Potions.";
    Risky = true;
});

local TabsRiftsEggs = Tabs.Rifts:AddLeftGroupbox("Eggs");

local RiftEggsDropdown = TabsRiftsEggs:AddDropdown("RiftEggsDropdown", {
    Values = {};
    Default = 1;

    Text = "Rift Eggs";

    Callback = function(Value)
        if Value then
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("Teleport", "Workspace.Worlds.The Overworld.FastTravel.Spawn");
            task.wait(1);
            TweenTo(Value.Display.CFrame, 15);
            task.wait(16);
            repeat
                task.wait();
                if (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Position - Value.Display.CFrame.Position).Magnitude > 20 then
                    TweenTo(Value.Display.CFrame, 15);
                    task.wait(16);
                end;
            until (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Position - Value.Display.CFrame.Position).Magnitude <= 20
        end;
    end;
});

local x25EggsDropdown = TabsRiftsEggs:AddDropdown("x25EggsDropdown", {
    Values = {};
    Default = 1;

    Text = "x25 Eggs";

    Callback = function(Value)
        if Value then
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("Teleport", "Workspace.Worlds.The Overworld.FastTravel.Spawn");
            task.wait(1);
            TweenTo(Value.Display.CFrame, 15);
            task.wait(16);
            repeat
                task.wait();
                if (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Position - Value.Display.CFrame.Position).Magnitude > 20 then
                    TweenTo(Value.Display.CFrame, 15);
                    task.wait(16);
                end;
            until (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Position - Value.Display.CFrame.Position).Magnitude <= 20
        end;
    end;
});

TabsRiftsEggs:AddDivider();

local RefreshDropdowns = TabsRiftsEggs:AddButton({
    Text = "Refresh Dropdowns";

    Func = function()
        local Foundx25Eggs, FoundRiftEggs = FetchRiftEggs(true), FetchRiftEggs(false);

        if #Foundx25Eggs > 0 then
            x25EggsDropdown:SetValues(Foundx25Eggs);
        else
            Library:Notify({
                Title = "Missing x25-egg";
                Description = "Unable to find a active x25 Luck Egg.";
                Time = 4;
            });
        end;

        if #FoundRiftEggs > 0 then
            RiftEggsDropdown:SetValues(FoundRiftEggs);
        else
            Library:Notify({
                Title = "Missing rift-egg";
                Description = "Unable to find a active Rift Egg.";
                Time = 4;
            });
        end;
    end;
});

local TabsRiftsChests = Tabs.Rifts:AddRightGroupbox("Chests");

TabsRiftsChests:AddToggle("UseGoldenKeys", {
    Text = "Use Golden Keys";
    Default = false;

    Callback = function(Value)
        getgenv().Functions.UseGoldenKeys = Value;
        task.spawn(function()
            while Functions.UseGoldenKeys do
                task.wait();
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("UnlockRiftChest", "golden-chest", false);
            end;
        end);
    end;
});

TabsRiftsChests:AddToggle("UseRoyalKeys", {
    Text = "Use Royal Keys";
    Default = false;

    Callback = function(Value)
        getgenv().Functions.UseRoyalKeys = Value;
        task.spawn(function()
            while Functions.UseRoyalKeys do
                task.wait();
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("UnlockRiftChest", "royal-chest", false);
            end;
        end);
    end;
});

local TeleportToGoldenChest = TabsRiftsChests:AddButton({
    Text = "Teleport To Golden Chest";

    Func = function()
        task.spawn(function()
            if game:GetService("Workspace").Rendered.Rifts:FindFirstChild("golden-chest") then
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("Teleport", "Workspace.Worlds.The Overworld.FastTravel.Spawn");
                task.wait(1);
                TweenTo(game:GetService("Workspace").Rendered.Rifts["golden-chest"].Chest["golden-chest"].CFrame + Vector3.new(0, 6, 0), 15);
                task.wait(16);
                repeat
                    task.wait();
                    if (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Position - game:GetService("Workspace").Rendered.Rifts["golden-chest"].Chest["golden-chest"].CFrame.Position).Magnitude > 20 then
                        TweenTo(game:GetService("Workspace").Rendered.Rifts["golden-chest"].Chest["golden-chest"].CFrame + Vector3.new(0, 6, 0), 15);
                        task.wait(16);
                    end;
                until (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Position - game:GetService("Workspace").Rendered.Rifts["golden-chest"].Chest["golden-chest"].CFrame.Position).Magnitude <= 20
            else
                Library:Notify({
                    Title = "Missing golden-chest";
                    Description = "Unable to find a active Golden Chest.";
                    Time = 4;
                });
            end;
        end);
    end;
});

local TeleportToRoyalChest = TabsRiftsChests:AddButton({
    Text = "Teleport To Royal Chest";

    Func = function()
        task.spawn(function()
            if game:GetService("Workspace").Rendered.Rifts:FindFirstChild("royal-chest") then
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("Teleport", "Workspace.Worlds.The Overworld.FastTravel.Spawn");
                task.wait(1);
                TweenTo(game:GetService("Workspace").Rendered.Rifts["royal-chest"].Chest["royal-chest"].CFrame + Vector3.new(0, 6, 0), 15);
                task.wait(16);
                repeat
                    task.wait();
                    if (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Position - game:GetService("Workspace").Rendered.Rifts["golden-chest"].Chest["golden-chest"].CFrame.Position).Magnitude > 20 then
                        TweenTo(game:GetService("Workspace").Rendered.Rifts["royal-chest"].Chest["royal-chest"].CFrame + Vector3.new(0, 6, 0), 15);
                        task.wait(16);
                    end;
                until (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Position - game:GetService("Workspace").Rendered.Rifts["golden-chest"].Chest["golden-chest"].CFrame.Position).Magnitude <= 20
            else
                Library:Notify({
                    Title = "Missing royal-chest";
                    Description = "Unable to find a active Royal Chest.";
                    Time = 4;
                });
            end;
        end);
    end;
});

local TabsMainTeleports = Tabs.Teleports:AddLeftGroupbox("Main Teleports");

local TeleportToTheOverworld = TabsMainTeleports:AddButton({
    Text = "Teleport to The Overworld";
    Func = function()
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("Teleport", "Workspace.Worlds.The Overworld.FastTravel.Spawn");
    end;
});

local TeleportToFloatingIsland = TabsMainTeleports:AddButton({
    Text = "Teleport to Floating Island";
    Func = function()
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("Teleport", "Workspace.Worlds.The Overworld.Islands.Floating Island.Island.Portal.Spawn");
    end;
});

local TeleportToOuterSpace = TabsMainTeleports:AddButton({
    Text = "Teleport to Outer Space";
    Func = function()
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("Teleport", "Workspace.Worlds.The Overworld.Islands.Outer Space.Island.Portal.Spawn");
    end;
});

local TeleportToTwilight = TabsMainTeleports:AddButton({
    Text = "Teleport to Twilight";
    Func = function()
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("Teleport", "Workspace.Worlds.The Overworld.Islands.Twilight.Island.Portal.Spawn");
    end;
});

local TeleportToTheVoid = TabsMainTeleports:AddButton({
    Text = "Teleport to The Void";
    Func = function()
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("Teleport", "Workspace.Worlds.The Overworld.Islands.The Void.Island.Portal.Spawn");
    end;
});

local TeleportToZen = TabsMainTeleports:AddButton({
    Text = "Teleport to Zen";
    Func = function()
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("Teleport", "Workspace.Worlds.The Overworld.Islands.Zen.Island.Portal.Spawn");
    end;
});

local TeleportToHatchingZone = TabsMainTeleports:AddButton({
    Text = "Teleport to Hatching Zone";
    Func = function()
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("Teleport", "Workspace.Worlds.The Overworld.FastTravel.Spawn");
        task.wait(0.3)
        TweenTo(CFrame.new(-57, 9, -27), 1.4);
    end;
});

TabsMainTeleports:AddDivider();

local UnlockAllIslands = TabsMainTeleports:AddButton({
    Text = "Unlock All Islands";
    Func = function()
        for i, v in next, game:GetService("Workspace").Worlds["The Overworld"].Islands:GetChildren() do
            firetouchinterest(v.Island.UnlockHitbox, game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, 0);
            task.wait();
            firetouchinterest(v.Island.UnlockHitbox, game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, 1);
            task.wait(0.3);
        end;
        task.wait();
        firetouchinterest(game:GetService("Workspace").Worlds["The Overworld"].Islands["Zen"].Island.UnlockHitbox, game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, 0);
        task.wait();
        firetouchinterest(game:GetService("Workspace").Worlds["The Overworld"].Islands["Zen"].Island.UnlockHitbox, game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, 1);
    end;
});

local TabsOtherTeleports = Tabs.Teleports:AddRightGroupbox("Other Teleports");

local TeleportToCoinFarmArea = TabsOtherTeleports:AddButton({
    Text = "Teleport To Coin Farm Area";
    Func = function()
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("Teleport", "Workspace.Worlds.The Overworld.Islands.Zen.Island.Portal.Spawn");
        task.wait(0.3);
        TweenTo(CFrame.new(4, 15973, 44), 0.8);
    end;
});

local TeleportToBestEgg = TabsOtherTeleports:AddButton({
    Text = "Teleport To Best Egg";
    Func = function()
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("Teleport", "Workspace.Worlds.The Overworld.FastTravel.Spawn");
        task.wait(0.3);
        TweenTo(CFrame.new(15, 10, -5), 0.5);
    end;
});

local TabsPlayerTeleports = Tabs.Teleports:AddRightGroupbox("Player Teleports");

local SelectPlayer = TabsPlayerTeleports:AddDropdown("SelectPlayer", {
    Values = {};
    Default = 1;

    Text = "Select Player";

    Callback = function(Value)
        return;
    end;
});

local TeleportToPlayer = TabsPlayerTeleports:AddButton({
    Text = "Teleport To Player";

    Func = function()
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("Teleport", "Workspace.Worlds.The Overworld.FastTravel.Spawn");
        task.wait(1);
        TweenTo(game:GetService("Players")[SelectPlayer.Value].Character.HumanoidRootPart.CFrame, 15);
        task.wait(16);
        repeat
            task.wait();
            if (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Position - game:GetService("Players")[SelectPlayer.Value].Character.HumanoidRootPart.CFrame.Position).Magnitude > 20 then
                TweenTo(game:GetService("Players")[SelectPlayer.Value].Character.HumanoidRootPart.CFrame, 15);
                task.wait(16);
            end;
        until (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Position - game:GetService("Players")[SelectPlayer.Value].Character.HumanoidRootPart.CFrame.Position).Magnitude <= 20
    end;
});

TabsPlayerTeleports:AddDivider();

local RefreshDropdowns = TabsPlayerTeleports:AddButton({
    Text = "Refresh Dropdowns";

    Func = function()
        local Players = {};

        for i, v in next, game:GetService("Players"):GetPlayers() do
            if v.Name ~= game:GetService("Players").LocalPlayer.Name then
                table.insert(Players, v.Name);
            end;
        end;

        SelectPlayer:SetValues(Players);
    end;
});

local TabsCPUSettings = Tabs.CPUSettings:AddLeftGroupbox("CPU Saving");

TabsCPUSettings:AddToggle("Disable3DRendering", {
    Text = "Disable 3D Rendering";
    Default = false;

    Callback = function(Value)
        getgenv().Functions.Disable3DRendering = Value;
        task.spawn(function()
            if Functions.Disable3DRendering then
                game:GetService("RunService"):Set3dRenderingEnabled(false);
            elseif not Functions.Disable3DRendering then
                game:GetService("RunService"):Set3dRenderingEnabled(true);
            end;
        end);
    end;
});

TabsCPUSettings:AddToggle("BlackOutScreen", {
    Text = "Black Out Screen";
    Default = false;

    Callback = function(Value)
        getgenv().Functions.BlackOutScreen = Value;
        task.spawn(function()
            if Functions.BlackOutScreen then
                local ScreenGui = Instance.new("ScreenGui");
                ScreenGui.Name = "BlackoutGui";
                ScreenGui.ResetOnSpawn = false;
                ScreenGui.IgnoreGuiInset = true;
                ScreenGui.Parent = game:GetService("CoreGui");
                local BlackFrame = Instance.new("Frame");
                BlackFrame.Size = UDim2.new(1, 0, 1, 0);
                BlackFrame.Position = UDim2.new(0, 0, 0, 0);
                BlackFrame.BackgroundColor3 = Color3.new(0, 0, 0);
                BlackFrame.BorderSizePixel = 0;
                BlackFrame.Parent = ScreenGui;
            elseif not Functions.BlackOutScreen then
                game:GetService("CoreGui").BlackoutGui:Destroy();
            end;
        end);
    end;
});

local ToggleCPUSaver = TabsCPUSettings:AddButton({
    Text = "Toggle CPU Saver";
    Func = function()
        Toggles.Disable3DRendering:SetValue(true);
        Toggles.BlackOutScreen:SetValue(true);
        CustomFPSCap:SetValue(10);
        Toggles.FixFPSCap:SetValue(true);
    end;
    Tooltip = "WARNING: This will toggle:\nDisable3DRendering, BlackOutScreen, FixFPSCap and set CustomFPSCap to 10";
    Risky = true;
});

local TabsFPSSettings = Tabs.CPUSettings:AddRightGroupbox("FPS Cap");

local FPSCap3 = TabsFPSSettings:AddButton({
    Text = "Set FPS Cap to 3";
    Func = function()
        setfpscap(3);
    end;
});

local FPSCap10 = TabsFPSSettings:AddButton({
    Text = "Set FPS Cap to 10";
    Func = function()
        setfpscap(10);
    end;
});

local FPSCap30 = TabsFPSSettings:AddButton({
    Text = "Set FPS Cap to 30";
    Func = function()
        setfpscap(30);
    end;
});

local FPSCap60 = TabsFPSSettings:AddButton({
    Text = "Set FPS Cap to 60";
    Func = function()
        setfpscap(60);
    end;
});

local CustomFPSCap = TabsFPSSettings:AddSlider("CustomFPSCap", {
    Text = "Custom FPS Cap";
    Default = 60;
    Min = 3;
    Max = 60;
    Rounding = 1;

    Callback = function(Value)
        setfpscap(Value);
    end;
});

TabsFPSSettings:AddToggle("FixFPSCap", {
    Text = "Fix FPS Cap";
    Default = false;

    Callback = function(Value)
        getgenv().Functions.FixFPSCap = Value;
        task.spawn(function()
            while Functions.FixFPSCap do
                setfpscap(CustomFPSCap.Value);
                task.wait(60);
            end;
        end);
    end;

    Tooltip = "WARNING: This will loop the CustomFPSCap Value every 1 minute.";
    Risky = true;
});

local CurrentFPSLabel = TabsFPSSettings:AddLabel("Current FPS: ???");

task.spawn(function()
    local Frames, Last = 0, tick();

    game:GetService("RunService").RenderStepped:Connect(function()
        Frames += 1;
        if tick() - Last >= 1 then
            CurrentFPSLabel:SetText("Current FPS: " .. Frames);
            Frames = 0
            Last = tick();
        end;
    end);
end);

local TabsUISettings = Tabs["UI Settings"]:AddLeftGroupbox("Menu");

TabsUISettings:AddToggle("KeybindMenuOpen", {
    Default = Library.KeybindFrame.Visible;
    Text = "Open Keybind Menu";
    Callback = function(value)
        Library.KeybindFrame.Visible = value;
    end;
});
TabsUISettings:AddToggle("ShowCustomCursor", {
    Text = "Custom Cursor";
    Default = true;
    Callback = function(Value)
        Library.ShowCustomCursor = Value;
    end;
});
TabsUISettings:AddDropdown("NotificationSide", {
    Values = {"Left", "Right"};
    Default = "Right";
    Text = "Notification Side";
    Callback = function(Value)
        Library:SetNotifySide(Value);
    end;
});
TabsUISettings:AddDropdown("DPIDropdown", {
    Values = {"50%", "75%", "100%", "125%", "150%", "175%", "200%"};
    Default = "100%";
    Text = "DPI Scale";
    Callback = function(Value)
        Value = Value:gsub("%%", "");
        local DPI = tonumber(Value);
        Library:SetDPIScale(DPI);
    end;
});
TabsUISettings:AddDivider();
TabsUISettings:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {Default = "RightShift", NoUI = true, Text = "Menu keybind"});
TabsUISettings:AddButton("Unload", function()
    Library:Unload();
end);

Library.ToggleKeybind = Options.MenuKeybind;

ThemeManager:SetLibrary(Library);
SaveManager:SetLibrary(Library);
SaveManager:IgnoreThemeSettings();
SaveManager:SetIgnoreIndexes({"MenuKeybind"});
ThemeManager:SetFolder("seth's cool script");
SaveManager:BuildConfigSection(Tabs["UI Settings"]);
ThemeManager:ApplyToTab(Tabs["UI Settings"]);
SaveManager:LoadAutoloadConfig();
