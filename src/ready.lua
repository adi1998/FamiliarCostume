mod.skinPackageList = {}
table.insert(mod.skinPackageList, _PLUGIN.guid .. "zerp-FamiliarCostume")

function mod.LoadSkinPackages()
    game.LoadPackages({Names = mod.skinPackageList})
end

modutil.mod.Path.Wrap("SetupMap", function(base)
    mod.LoadSkinPackages()
    base()
end)

function mod.GetUnlockedFamiliarCostumes(costumeList)
    local unlockedCostumes = {}
    for _, costume in ipairs(costumeList) do
        if game.GameState.WorldUpgrades[costume] then
            table.insert(unlockedCostumes,costume)
        end
    end
    return unlockedCostumes
end

function mod.GetFavorites(costumeList, currentFamiliar)
    local favoriteCostume = {}
    game.GameState.ModFamiliarCostumesFavorites = game.GameState.ModFamiliarCostumesFavorites or {
        HoundFamiliar = {},
        FrogFamiliar = {},
        RavenFamiliar = {},
        CatFamiliar = {},
        PolecatFamiliar = {}
    }
    for _, costume in ipairs(costumeList) do
        if game.GameState.ModFamiliarCostumesFavorites[currentFamiliar][costume] then
            table.insert(favoriteCostume,costume)
        end
    end
    return favoriteCostume
end

modutil.mod.Path.Wrap("StartNewRun", function(base, prevRun, args)
    local retValue = base(prevRun,args)
    if game.GameState == nil then
        return retValue
    end

    if config.random then
        local currentFamiliar = game.GameState.EquippedFamiliar
        game.GameState.ModFamiliarCostumes = game.GameState.ModFamiliarCostumes or {}
        if currentFamiliar ~= nil then
            local costumeList = game.ScreenData.FamiliarCostumeShop.ItemCategories[currentFamiliar]
            local favoriteList = mod.GetFavorites(costumeList, currentFamiliar)
            local randomCostume
            if #favoriteList > 0 then
                randomCostume = game.GetRandomArrayValue(favoriteList)
            else
                randomCostume = game.GetRandomArrayValue(mod.GetUnlockedFamiliarCostumes(costumeList))
            end

            -- don't write modded data in basegame tables
            if FamiliarCostumeData[randomCostume] ~= nil then
                game.GameState.FamiliarCostumes[currentFamiliar] = game.FamiliarData[currentFamiliar].DefaultCostume
                game.GameState.ModFamiliarCostumes[currentFamiliar] = randomCostume
            else
                game.GameState.ModFamiliarCostumes[currentFamiliar] = nil
                game.GameState.FamiliarCostumes[currentFamiliar] = randomCostume
            end
        end
    end
    return retValue
end)

modutil.mod.Path.Wrap("MouseOverFamiliarCostumeItem", function (base, button)
    base(button)
    local screen = button.Screen
	if screen.Closing then
		return
	end
    if button.Purchased then
        SetAlpha({ Id = screen.Components.FavoriteButton.Id, Fraction = 1.0, Duration = 0.1 })
    else
        SetAlpha({ Id = screen.Components.FavoriteButton.Id, Fraction = 0.0, Duration = 0.1 })
    end
end)

modutil.mod.Path.Wrap("MouseOffFamiliarCostumeItem", function (base, button)
    base(button)
    local screen = button.Screen
	if screen.Closing then
		return
	end
    SetAlpha({ Id = screen.Components.FavoriteButton.Id, Fraction = 0.0, Duration = 0.1 })
end)