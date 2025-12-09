modutil.mod.Path.Wrap("SetupFamiliarCostume", function (base, familiar,args)
    base(familiar,args)
    args = args or {}
    game.GameState.ModFamiliarCostumes = game.GameState.ModFamiliarCostumes or {}
    local currentModCostume = game.GameState.ModFamiliarCostumes[familiar.Name]
	if currentModCostume ~= nil then
        local costumeData = game.WorldUpgradeData[currentModCostume]
        game.SetThingProperty({ DestinationId = familiar.ObjectId, Property = "GrannyModel", Value = costumeData.GrannyModel })
        game.SetThingProperty({ DestinationId = familiar.ObjectId, Property = "GrannyTexture", Value = costumeData.GrannyTexture })
        SetAnimation({ DestinationId = familiar.ObjectId, Name = args.Animation or familiar.IdleAnimation })
    else
        game.SetThingProperty({ DestinationId = familiar.ObjectId, Property = "GrannyTexture", Value = "" })
    end
end)

function mod.ToggleFavoriteFamiliarCostume( screen, button )
    local selectedItem = screen.SelectedItem
    print("toggle fav fam cos")
    selectedItem.IsFavorite = not selectedItem.IsFavorite == true
    if selectedItem.IsFavorite then
        local animationName = "FilledHeartIcon"
        SetAnimation({ Name = animationName, DestinationId = selectedItem.FavButtonId, Scale = 0.3, OffsetX = -20, OffsetY = 15})
        SetAlpha({ Id = selectedItem.FavButtonId, Fraction = 1.0, Duration = 0.1 })
    else
        SetAlpha({ Id = selectedItem.FavButtonId, Fraction = 0.0, Duration = 0.1 })
    end
        
end