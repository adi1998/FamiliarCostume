local guiScreensVFXFile = rom.path.combine(rom.paths.Content(), "Game\\Animations\\GUI_Screens_VFX.sjson")
local helpTextPath = rom.path.combine(rom.paths.Content(),"Game\\Text\\en\\HelpText.en.sjson")

local FamiliarNames = {
    FamiliarCostume_FrogBrown = "Brown",
    FamiliarCostume_FrogGreen = "Green",
    FamiliarCostume_FrogGrey = "Grey",
    FamiliarCostume_FrogYellow = "Yellow",
    FamiliarCostume_HoundBeige = "Beige",
    FamiliarCostume_HoundTan = "Tan",
    FamiliarCostume_HoundOrange = "Orange",
    FamiliarCostume_RavenBlack = "Black",
    FamiliarCostume_RavenGreen = "Green",
    FamiliarCostume_CatBicolor = "Bicolor",
    FamiliarCostume_CatBlack = "Black",
    FamiliarCostume_CatSpotted = "Spotted",
    FamiliarCostume_CatTabby = "Tabby",
    FamiliarCostume_CatTuxedo = "Tuxedo",
    FamiliarCostume_CatWhite = "White",
}

local helptextorder = {
    "Id",
    "DisplayName",
    "Description",
}

sjson.hook(helpTextPath, function (data)
    for key, value in pairs(FamiliarNames) do
        local entry = {
            Id = key,
            DisplayName = value,
            Description = "",
        }
        table.insert(data.Texts,sjson.to_object(entry,helptextorder))
    end
end)

local familiarIconFormat = {
        Name = _PLUGIN.guid,
        FilePath = "zerp-FamiliarCostume/icons/",
        Scale = 1.3
}

local iconorder = {
    "Name",
    "FilePath",
    "Scale",
}

local FamiliarIconList = {
    "cat_bicolor",
    "cat_black",
    "cat_spotted",
    "cat_tabby",
    "cat_tuxedo",
    "cat_white",
    "bird_green",
}

sjson.hook(guiScreensVFXFile, function (data)
    for _, icon in ipairs(FamiliarIconList) do
        local newentry = game.DeepCopyTable(familiarIconFormat)
        newentry.Name = newentry.Name .. icon
        newentry.FilePath = newentry.FilePath .. icon
        table.insert(data.Animations,sjson.to_object(newentry,iconorder))
    end

end)