mod.skinPackageList = {}
table.insert(mod.skinPackageList, _PLUGIN.guid .. "zerp-FamiliarCostume")

function mod.LoadSkinPackages()
    LoadPackages({Names = mod.skinPackageList})
end

modutil.mod.Path.Wrap("SetupMap", function(base)
    mod.LoadSkinPackages()
    base()
end)