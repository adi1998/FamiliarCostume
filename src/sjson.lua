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
    FamiliarCostume_CerberusBase = "Default",
    FamiliarCostume_CerberusEM = "Unrivaled",
    FamiliarCostume_CerberusEM2 = "Unrivaled Phase 2",
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
        FilePath = "zerp-Familiar_Costume_Randomizer/icons/",
        Scale = 1.1
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
    "bird_black",
    "hound_tan",
    "hound_orange",
    "hound_beige",
    "frog_brown",
    "frog_yellow",
    "frog_grey",
    "frog_green",
    "cerb_default",
    "cerb_unrivaled",
    "cerb_unrivaled2",
}

sjson.hook(guiScreensVFXFile, function (data)
    for _, icon in ipairs(FamiliarIconList) do
        local newentry = game.DeepCopyTable(familiarIconFormat)
        newentry.Name = newentry.Name .. icon
        newentry.FilePath = newentry.FilePath .. icon
        table.insert(data.Animations,sjson.to_object(newentry,iconorder))
    end

end)