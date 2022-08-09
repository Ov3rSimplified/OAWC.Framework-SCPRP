TEAM_SPECTATOR = DarkRP.createJob("Spectator", {
    color = Color(20, 150, 20, 255),
    model = { "models/player/skeleton.mdl" },
    description = [[]],
    weapons = {},
    command = "spectator",
    max = 0,
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
  })
TEAM_SCPSELECT = DarkRP.createJob("SCP Selection", {
  color = Color(20, 150, 20, 255),
  model = { "models/player/skeleton.mdl" },
  description = [[]],
  weapons = {},
  command = "scpselection",
  max = 0,
  salary = 0,
  admin = 0,
  vote = false,
  hasLicense = false,
  candemote = false,
})
TEAM_Dosi = DarkRP.createJob("N02 Dostra", {
  color = Color(20, 150, 20, 255),
  model = { "models/sky/custom/twin/n_02.mdl" },
  description = [[]],
  weapons = {},
  command = "dostraa",
  max = 0,
  salary = 0,
  admin = 0,
  vote = false,
  hasLicense = false,
  candemote = false,
  PlayerSpawn = function(ply)
    ply:SetBodygroup(1, 0)
    ply:SetBodygroup(2, 0)
    ply:SetBodygroup(3, 0)
    ply:SetBodygroup(4, 5)
    ply:SetBodygroup(5, 0)
    ply:SetBodygroup(6, 0)
    ply:SetBodygroup(7, 0)
    ply:SetBodygroup(8, 0)
    ply:SetBodygroup(9, 0)
    ply:SetBodygroup(10, 1)
    ply:SetBodygroup(11, 0)
    ply:SetBodygroup(12, 0)
    ply:SetBodygroup(13, 1)
    ply:SetBodygroup(14, 0)
    ply:SetBodygroup(15, 0)
  end
})