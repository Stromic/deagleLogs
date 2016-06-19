/*********************************************************************************************
*                                                                                            *
*                              deagleLogs - Configuration File                               *
*                                                                                            *
*********************************************************************************************/

/*Do not remove or edit the below lines */
dLogs = dLogs or {}
dLogs.groups = dLogs.groups or {}
dLogs.track = dLogs.track or {}
dLogs.max = dLogs.max or {}
/*Do not remove or edit the above lines */


-- set the below to 2.5 for DarkRP 2.5.X or 2.4 for anything below that(i.e DarkRP 2.4.X) default: 2.5
-- Set to JB if you are using Jailbreak.
dLogs.version = "2.5"

dLogs.groups.Main = -- Groups that can view the log menu.
{
"admin",
"superadmin",
"moderator",
"trialmoderator"
}

dLogs.groups.canReset = { -- Groups that can reset/delete all existing logs.
"superadmin"
}

dLogs.CommandBlacklist = { -- commands that are blacklisted from showing up in command logs.
"ulib_cl_ready",
"level_networkvars",
"_xgui",
"EGP_ScrWH",
"_sendDarkRPvars",
"dlogs",
"gm_spawn",
"gmod_undo",
"xgui",
"ulib_update_cvar",
"_u",
"___askDoor",
"_sendAllDoorData",
"+menu",
"-menu",
"gmod_tool",
"undo",
"_DarkRP_AnimationMenu",
"+menu_context",
"-menu_context",
"ans",
"cs_askholders",
"cs_menu",
"__playLockpickSound",
"_lockpickSuccess",
"vote"

}

dLogs.entBlacklist = { -- "Weapons" that are blacklisted from showing up in the damage logs.
"env_fire"

}

dLogs.chatCommand = "/dlogs"
dLogs.consoleCommand = "dlogs_openmenu"

dLogs.resetCommand = "dlogs_resetlog" --use the category names from dLogs.max or put all as the argument to reset everything. so i.e "dlogs_resetlog all"


dLogs.track.IP = true
dLogs.track.Name = true
dLogs.track.Job = true
dLogs.track.Kills = true
dLogs.track.Prop = true
dLogs.track.Tool = true
dLogs.track.Connect = true
dLogs.track.Damage = true
dLogs.track.Arrest = true
dLogs.track.Demote = true
dLogs.track.Hit = true
dLogs.track.Warrant = true
dLogs.track.Wanted = true
dLogs.track.Purchase = true
dLogs.track.Chat = true
dLogs.track.Command = true

  -- Untested with amounts above 1000. ( please note, it divides these numbers by 10 and puts them in pages, Set to 2000 for 200 per page)
dLogs.max.Tool = 1000
dLogs.max.Name = 1000
dLogs.max.Job = 1000
dLogs.max.Prop = 1000
dLogs.max.Kills = 1000
dLogs.max.Connect = 1000
dLogs.max.Damage = 1000
dLogs.max.Arrest = 1000
dLogs.max.Demote = 1000
dLogs.max.Hit = 1000
dLogs.max.Warrant = 1000
dLogs.max.Wanted = 1000
dLogs.max.Purchase = 1000
dLogs.max.Chat = 1000
dLogs.max.Command = 1000

dLogs.groups.IP =
{
"superadmin"
}

dLogs.groups.Purchase = {
"*"
}

dLogs.groups.Chat = {
"*"
}

dLogs.groups.Command = {
"*"
}

dLogs.groups.Hit =
{
"*"
}

dLogs.groups.Demote =
{
"*"
}

dLogs.groups.Arrest =
{
"*"
}

dLogs.groups.Name =
{
"*"
}

dLogs.groups.Prop =
{
"*"
}

dLogs.groups.Job =
{
"*"
}

dLogs.groups.Kills =
{
"*"
}

dLogs.groups.Damage =
{
"*"
}

dLogs.groups.Tool =
{
"*"
}

dLogs.groups.Connect =
{
"*"
}
dLogs.groups.Warrant =
{
"*"
}
dLogs.groups.Wanted =
{
"*"
}

dLogs.DermaTheme = "dLogs_PenguinTheme"
dLogs.CommunityCol = Color(51,128,255) -- dont edit this or it'll break(or look ugly as shit)
