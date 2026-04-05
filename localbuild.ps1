rm -force -recurse data/zerp-Familiar_Costume_Randomizer
deppth2 hpk -c BC7 -s .\textures\icons -t .\data\zerp-Familiar_Costume_Randomizer
rm -force -recurse data/zerp-Familiar_Costume_Randomizer 
python build_pkg.py -s .\textures\skins -t .\data\zerp-Familiar_Costume_RandomizerSkins
tcli build