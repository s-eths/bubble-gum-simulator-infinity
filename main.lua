-- skid this if you want, nothing too good lowkey rushed but it works so ye idc

getgenv().Functions = {
    AutoBlowBubbles = false;
    AutoSell = false;
    AutoCollectPickups = false;
    AutoGenieQuest = false;
    AutoClaimChests = false;
    AutoClaimWheelSpin = false;
    AutoClaimPlaytimeRewards = false;
    AutoBuyFromMarket = false;
    AutoOpenMysteryBox = false;
};

for i, v in next, getconnections(game:GetService("Players").LocalPlayer.Idled) do
    v:Disable();
end;

local UI = loadstring(game:HttpGet("https://sirius.menu/rayfield"))();

local Window = UI:CreateWindow({
   Name = "seths cool script";
   Icon = 0;
   LoadingTitle = "cca is a monkey";
   LoadingSubtitle = "by seth";
   Theme = "Default";

   ConfigurationSaving = {
      Enabled = true;
      FolderName = nil;
      FileName = "seths cool script";
   };
});

local TabMain = Window:CreateTab("Main", 4483362458);
local TabALTSetup = Window:CreateTab("ALT Setup", 4483362458);
local MainFunctions = TabMain:CreateSection("Main Functions");

local AutoBlowBubbles = TabMain:CreateToggle({
    Name = "Auto Blow Bubbles";
    CurrentValue = false;
    Flag = "Toggle1";
    Callback = function(Value)
        getgenv().Functions.AutoBlowBubbles = Value;
        task.spawn(function()
            while Functions.AutoBlowBubbles do
                task.wait();
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("BlowBubble")
            end;
        end);
    end;
});

local AutoSell = TabMain:CreateToggle({
    Name = "Auto Sell";
    CurrentValue = false;
    Flag = "Toggle1";
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

local AutoCollectPickups = TabMain:CreateToggle({
    Name = "Auto Collect Pickups";
    CurrentValue = false;
    Flag = "Toggle1";
    Callback = function(Value)
        getgenv().Functions.AutoCollectPickups = Value;
        task.spawn(function()
            while Functions.AutoCollectPickups do
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
                task.wait(1);
            end;
        end);
    end;
});

local OtherFunctions = TabMain:CreateSection("Other Functions");

local AutoBuyFromMarkets = TabMain:CreateToggle({
    Name = "Auto Buy From Markets";
    CurrentValue = false;
    Flag = "Toggle1";
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

local AutoOpenMysteryBox = TabMain:CreateToggle({
    Name = "Auto Open Mystery Box";
    CurrentValue = false;
    Flag = "Toggle1";
    Callback = function(Value)
        getgenv().Functions.AutoOpenMysteryBox = Value;
        task.spawn(function()
            while Functions.AutoOpenMysteryBox do
                task.wait();
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("UseGift", "Mystery Box", 1);
                for i, v in next, game:GetService("Workspace").Rendered.Gifts:GetChildren() do
                    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("ClaimGift", v.Name);
                    task.wait();
                    v:Destroy();
                end;
            end;
        end);
    end;
});

local AutoClaimPlaytimeRewards = TabMain:CreateToggle({
    Name = "Auto Claim Playtime Rewards";
    CurrentValue = false;
    Flag = "Toggle1";
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

local AutoClaimChests = TabMain:CreateToggle({
    Name = "Auto Claim Chests";
    CurrentValue = false;
    Flag = "Toggle1";
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

local AutoClaimWheelSpin = TabMain:CreateToggle({
    Name = "Auto Claim Wheel Spin";
    CurrentValue = false;
    Flag = "Toggle1";
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

local AutoGenieQuest = TabMain:CreateToggle({
    Name = "Auto Genie Quest";
    CurrentValue = false;
    Flag = "Toggle1";
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

local UseAllGoldenKeys = TabMain:CreateButton({
    Name = "Use All Golden Keys";
    Callback = function()
        task.spawn(function()
            if game:GetService("Workspace").Rendered.Rifts:FindFirstChild("golden-chest") then
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("Teleport", "Workspace.Worlds.The Overworld.FastTravel.Spawn");
                task.wait(1);
                local CFrameValue = Instance.new("CFrameValue");
                CFrameValue.Value = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame;
                CFrameValue:GetPropertyChangedSignal("Value"):Connect(function()
                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameValue.Value;
                end);
                game:GetService("TweenService"):Create(CFrameValue, TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Value = game:GetService("Workspace").Rendered.Rifts["golden-chest"].Chest["golden-chest"].CFrame + Vector3.new(0, 6, 0)}):Play();
                task.wait(11);
                local __tick = tick();
                repeat
                    task.wait();
                    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("UnlockRiftChest", "golden-chest", false)
                until tick() - __tick >= 300;
            end;
        end);
    end;
});

local UseAllRoyalKeys = TabMain:CreateButton({
    Name = "Use All Royal Keys";
    Callback = function()
        task.spawn(function()
            if game:GetService("Workspace").Rendered.Rifts:FindFirstChild("royal-chest") then
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("Teleport", "Workspace.Worlds.The Overworld.FastTravel.Spawn");
                task.wait(1);
                local CFrameValue = Instance.new("CFrameValue");
                CFrameValue.Value = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame;
                CFrameValue:GetPropertyChangedSignal("Value"):Connect(function()
                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameValue.Value;
                end);
                game:GetService("TweenService"):Create(CFrameValue, TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Value = game:GetService("Workspace").Rendered.Rifts["royal-chest"].Chest["royal-chest"].CFrame + Vector3.new(0, 6, 0)}):Play();
                task.wait(11);
                local __tick = tick();
                repeat
                    task.wait();
                    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer("UnlockRiftChest", "royal-chest", false)
                until tick() - __tick >= 300;
            end;
        end);
    end;
});

local UnlockTrading = TabALTSetup:CreateButton({
    Name = "Unlock Trading";
    Callback = function()
        task.spawn(function()
            return;
        end);
    end;
});

local UnlockAllPetEquips = TabALTSetup:CreateButton({
    Name = "Unlock All Pet Equips";
    Callback = function()
        task.spawn(function()
            return;
        end);
    end;
});

local CPUSaver = TabALTSetup:CreateToggle({
    Name = "CPU Saver";
    CurrentValue = false;
    Flag = "Toggle1";
    Callback = function(Value)
        return;
    end;
});

local SetFPSCap = TabALTSetup:CreateSlider({
    Name = "Set FPS Cap";
    Range = {3, 60};
    Increment = 1;
    Suffix = "Bananas";
    CurrentValue = 60;
    Flag = "Slider1",
    Callback = function(Value)
        return
    end,
});

UI:LoadConfiguration();
