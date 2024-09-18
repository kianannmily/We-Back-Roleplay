forward DCC_DM(str[]);
public DCC_DM(str[])
{
    new DCC_Channel:PM;
	PM = DCC_GetCreatedPrivateChannel();
	DCC_SendChannelMessage(PM, str);
	return 1;
}

forward DCC_DM_EMBED(str[], pin, id[]);
public DCC_DM_EMBED(str[], pin, id[])
{
    new DCC_Channel:PM, query[200];
	PM = DCC_GetCreatedPrivateChannel();

	new DCC_Embed:embed = DCC_CreateEmbed(.title="Expensive Roleplay");
	new str1[100], str2[100];

	format(str1, sizeof str1, "```\nHello!\nYour UCP has been verified,\nUse PIN below for entering the Game!```");
	DCC_SetEmbedDescription(embed, str1);
	format(str1, sizeof str1, "UCP");
	format(str2, sizeof str2, "\n```%s```", str);
	DCC_AddEmbedField(embed, str1, str2, bool:1);
	format(str1, sizeof str1, "PIN");
	format(str2, sizeof str2, "\n```%d```", pin);
	DCC_AddEmbedField(embed, str1, str2, bool:1);

	DCC_SendChannelEmbedMessage(PM, embed);

	mysql_format(g_SQL, query, sizeof query, "INSERT INTO `playerucp` (`ucp`, `verifycode`, `DiscordID`) VALUES ('%e', '%d', '%e')", str, pin, id);
	mysql_tquery(g_SQL, query);
	return 1;
}

forward CheckDiscordUCP(DiscordID[], Nama_UCP[]);
public CheckDiscordUCP(DiscordID[], Nama_UCP[])
{
	new rows = cache_num_rows();
	new DCC_Role: WARGA, DCC_Guild: guild, DCC_User: user, dc[100];
	new verifycode = RandomEx(111111, 988888);
	if(rows > 0)
	{
		return SendDiscordMessage(7, "**INFO**: That username already exists! Try another");
	}
	else 
	{
		guild = DCC_FindGuildById("1163727661064003604");
		WARGA = DCC_FindRoleById("1266639891891224627");
		user = DCC_FindUserById(DiscordID);
		DCC_SetGuildMemberNickname(guild, user, Nama_UCP);
		DCC_AddGuildMemberRole(guild, user, WARGA);

		format(dc, sizeof(dc),  "**UCP**: *%s* is now Verified.", Nama_UCP);
		SendDiscordMessage(7, dc);
		DCC_CreatePrivateChannel(user, "DCC_DM_EMBED", "sds", Nama_UCP, verifycode, DiscordID);
	}
	return 1;
}

forward CheckDiscordID(DiscordID[], Nama_UCP[]);
public CheckDiscordID(DiscordID[], Nama_UCP[])
{
	new rows = cache_num_rows(), ucp[20], dc[100];
	if(rows > 0)
	{
		cache_get_value_name(0, "ucp", ucp);

		format(dc, sizeof(dc),  "**INFO**: You already have UCP that named *%s*", ucp);
		return SendDiscordMessage(7, dc);
	}
	else 
	{
		new characterQuery[178];
		mysql_format(g_SQL, characterQuery, sizeof(characterQuery), "SELECT * FROM `playerucp` WHERE `ucp` = '%s'", Nama_UCP);
		mysql_tquery(g_SQL, characterQuery, "CheckDiscordUCP", "ss", DiscordID, Nama_UCP);
	}
	return 1;
}

DCMD:ucp(user, channel, params[])
{
	new id[21];
    if(channel != DCC_FindChannelById("1266640034694430791"))
		return 1;
    if(isnull(params)) 
		return DCC_SendChannelMessage(channel, "**USAGE**: !ucp [UCP NAME]");
	if(!IsValidNameUCP(params))
		return DCC_SendChannelMessage(channel, "Use UCP username not In Character name");
//	DCC_SendChannelMessage(channel, "**Accept Silahkan Cek PM Bot Discord HamZyy!**);
	
	DCC_GetUserId(user, id, sizeof id);

	new characterQuery[178];
	mysql_format(g_SQL, characterQuery, sizeof(characterQuery), "SELECT * FROM `playerucp` WHERE `DiscordID` = '%s'", id);
	mysql_tquery(g_SQL, characterQuery, "CheckDiscordID", "ss", id, params);
	return 1;
}

DCMD:server(user, channel, params[])
{
	foreach(new i : Player)
	{
		new DCC_Embed:embed = DCC_CreateEmbed(.title = "Expensive World");
		new str1[100], str2[100], name[MAX_PLAYER_NAME+1];
		GetPlayerName(i, name, sizeof(name));

		format(str1, sizeof str1, "**NAME SERVER**");
		format(str2, sizeof str2, "\nExpensive Roleplay");
		DCC_AddEmbedField(embed, str1, str2, false);
		format(str1, sizeof str1, "**WEBSITE**");
		format(str2, sizeof str2, "\nhttps://discord.gg/Expensiverp");
		DCC_AddEmbedField(embed, str1, str2, false);
		format(str1, sizeof str1, "**PLAYERS**");
		format(str2, sizeof str2, "\n%d Online", pemainic);
		DCC_AddEmbedField(embed, str1, str2, false);
		format(str1, sizeof str1, "**GAMEMODE**");
		format(str2, sizeof str2, "\nE:RP 1.0.0.0");
		DCC_AddEmbedField(embed, str1, str2, false);
		format(str1, sizeof str1, "__[ID]\tName\tLevel\tPing__\n");
		format(str2, sizeof str2, "**%i\t%s\t%i\t%i**\n", i, name, GetPlayerScore(i), GetPlayerPing(i));
		DCC_AddEmbedField(embed, str1, str2, false);

		DCC_SendChannelEmbedMessage(channel, embed);
		return 1;
	}
	return 1;
}/*

DCMD:setcs(user, channel, params[])
{
	if(channel != channelCS) return DCC_SendChannelMessage(channel, "`[MERPATIBOT]: Error you are not part of the admin team`");
	new target, cs[5], string[256];
	if(sscanf(params, "us[5]", target, cs)) return DCC_SendChannelMessage(channel, "`[MERPATIBOT]: Usage !setcs [PlayerName] [Yes/No]`");

	if(!strcmp(cs, "Yes", true))
	{
		if(!IsPlayerConnected(target)) return DCC_SendChannelMessage(channel, "```\n[MERPATI]: Error Player yang ingin anda atur sedang tidak ada di dalam kota, Silahkan gunakan \"/osetcs\"\n```");

		format(string, sizeof(string), "`[MERPATIBOT]: Error akun dengan nama %s cs nya telah di atur Ke [ACCEPT]`", pData[target][pCs]);
		if(pData[target][pCs]) return DCC_SendChannelMessage(channel, string);

		pData[target][pCs] = 1;
		Servers(target, "Character Story Anda berhasil di atur | [ACCEPTED]");

		format(string, sizeof(string), "`[MERPATIBOT]: Akun dengan nama %s Character Storynya Berhasil Diatur | [ACCEPTED]`", pData[target][pName]);
		DCC_SendChannelMessage(channel, string);
	}
	else if(!strcmp(cs, "No", true))
	{
		if(!IsPlayerConnected(target)) return DCC_SendChannelMessage(channel, "```\n[MERPATI]: Error Player yang ingin anda atur sedang tidak ada di dalam kota, Silahkan gunakan \"/osetcs\"\n```");

		format(string, sizeof(string), "`[MERPATIBOT]: Error akun dengan nama %s cs nya telah di atur Ke [DENIED]`", pData[target][pCs]);
		if(!pData[target][pCs]) return DCC_SendChannelMessage(channel, string);

		pData[target][pCs] = 0;
		Servers(target, "Character Story Anda berhasil di atur | [DENIED]");

		format(string, sizeof(string), "`[MERPATIBOT]: Akun dengan nama %s Character Storynya Berhasil Diatur | [DENIED]`", pData[target][pName]);
		DCC_SendChannelMessage(channel, string);
	}
	return 1;
}

DCMD:osetcs(user, channel, params[])
{
	if(channel != channelCS) return DCC_SendChannelMessage(channel, "`[MERPATIBOT]: Error you are not part of the admin team`");
	new target, cs[5], string[256];
	if(sscanf(params, "ss[5]", target, cs)) return DCC_SendChannelMessage(channel, "`[MERPATIBOT]: Usage !osetcs [PlayerName] [Yes/No]`");

	if(!strcmp(cs, "Yes", true))
	{
		if(IsPlayerConnected(target)) return DCC_SendChannelMessage(channel, "```\n[MERPATI]: Error Player yang ingin anda atur sedang berada di dalam kota, silahkan gunakan /setcs\n```");

		new query[256];
		mysql_format(g_SQL, query, sizeof query, "SELECT * FROM players WHERE username = '%s'", target);
		mysql_tquery(g_SQL, query, "CheckPlayerUserCs", "sd", target, 1);
	}
	else if(!strcmp(cs, "No", true))
	{
		if(IsPlayerConnected(target)) return DCC_SendChannelMessage(channel, "```\n[MERPATI]: Error Player yang ingin anda atur sedang berada di dalam kota, silahkan gunakan /setcs\n```");

		new query[256];
		mysql_format(g_SQL, query, sizeof query, "SELECT * FROM players WHERE username = '%s'", target);
		mysql_tquery(g_SQL, query, "CheckPlayerUserCs", "sd", target, 0);
	}
	return 1;
}

DCMD:sapdonline(user, channel, params[])
{
	if(channel != panelMerpati) return DCC_SendChannelMessage(channel, "`[MERPATIBOT]: Error you are not part of the admin team`");

	new duty[16], lstr[1024], count = 0;
	format(lstr, sizeof(lstr), "Name\tRank\tStatus\tDuty Time\n");
	foreach(new i: Player)
	{
		if(pData[i][pFaction] == 1)
		{
			switch(pData[i][pOnDuty])
			{
				case 0:
				{
					duty = "Off Duty";
				}
				case 1:
				{
					duty = "On Duty";
				}
			}
			format(lstr, sizeof(lstr), "%s%s(%d)\t%s(%d)\t%s\t%d detik", lstr, pData[i][pName], i, GetFactionRank(i), pData[i][pFactionRank], duty, pData[i][pOnDutyTime]);
			format(lstr, sizeof(lstr), "%s\n", lstr);
			count++;
		}
	}
	format(lstr, sizeof(lstr), "%s\n", lstr);

	if(count > 0)
	{
		new DCC_Embed:msgEmbed, msgField[1520];
		format(msgField, sizeof(msgField), "```\n%s\n```", lstr);
		msgEmbed = DCC_CreateEmbed("", "", "", "", 0x00ff00, "SAPD online list", "", "", "");
		DCC_AddEmbedField(msgEmbed, "SAPD Online In Server", msgField);
		DCC_SendChannelEmbedMessage(channel, msgEmbed);
	}
	else DCC_SendChannelMessage(channel, "`[MERPATIBOT]: There are no sapd online`");
	return 1;
}

DCMD:samdonline(user, channel, params[])
{
	if(channel != panelMerpati) return DCC_SendChannelMessage(channel, "`[MERPATIBOT]: Error you are not part of the admin team`");

	new duty[16], lstr[1024], count = 0;
	format(lstr, sizeof(lstr), "Name\tRank\tStatus\tDuty Time\n");
	foreach(new i: Player)
	{
		if(pData[i][pFaction] == 3)
		{
			switch(pData[i][pOnDuty])
			{
				case 0:
				{
					duty = "Off Duty";
				}
				case 1:
				{
					duty = "On Duty";
				}
			}
			format(lstr, sizeof(lstr), "%s%s(%d)\t%s(%d)\t%s\t%d detik", lstr, pData[i][pName], i, GetFactionRank(i), pData[i][pFactionRank], duty, pData[i][pOnDutyTime]);
			format(lstr, sizeof(lstr), "%s\n", lstr);
			count++;
		}
	}
	format(lstr, sizeof(lstr), "%s\n", lstr);

	if(count > 0)
	{
		new DCC_Embed:msgEmbed, msgField[1520];
		format(msgField, sizeof(msgField), "```\n%s\n```", lstr);
		msgEmbed = DCC_CreateEmbed("", "", "", "", 0x00ff00, "SAMD online list", "", "", "");
		DCC_AddEmbedField(msgEmbed, "SAMD Online In Server", msgField);
		DCC_SendChannelEmbedMessage(channel, msgEmbed);
	}
	else DCC_SendChannelMessage(channel, "`[MERPATIBOT]: There are no samd online`");

	return 1;
}

DCMD:players(user, channel, params[])
{
	new DCC_Embed:msgEmbed, msgField[256];
	format(msgField, sizeof(msgField), "[<a:Ve_SireneRedTKF:949720555983110195>] Player Online Di Kota Merpati: %s", number_format(Iter_Count(Player)));
	msgEmbed = DCC_CreateEmbed("", msgField, "", "", 0x00ff00, "Kota Merpati | #MERPATIBANGKIT", "", "", "");
	DCC_SendChannelEmbedMessage(channel, msgEmbed);
	return 1;
}

DCMD:checkucp(user, channel, params[])
{
	if(channel != panelMerpati) return DCC_SendChannelMessage(channel, "`[MERPATIBOT]: Error you are not part of the admin team`");

	new nameUcp[24];
	if(sscanf(params, "s[24]", nameUcp)) return DCC_SendChannelMessage(channel, "`[MERPATIBOT]: Usage !checkucp [UCP]`");

	new query[256];
	format(query, sizeof(query), "SELECT * FROM `playerucp` WHERE `uUserUCP` = '%s' LIMIT 1", nameUcp);
	mysql_tquery(g_SQL, query, "DiscordCheckCharUCP", "s", nameUcp);
	return 1;
}

DCMD:jumlahucp(user, channel, params[])
{
	if(channel != panelMerpati) return DCC_SendChannelMessage(channel, "`[MERPATIBOT]: Error you are not part of the admin team`");

	new registered_players, Cache:result = mysql_query(g_SQL, "SELECT COUNT(*) FROM `playerucp`");
	cache_get_value_int(0, 0, registered_players);

	new msg[256];
	format(msg, sizeof msg, "`[MERPATIBOT]: Registered ucp account is %d accounts`", registered_players);
	DCC_SendChannelMessage(channel, msg);
	cache_delete(result);
	return 1;
}

DCMD:setucp(user, channel, params[])
{
	new DCC_Channel:channelSetUCP;
	channelSetUCP = DCC_FindChannelById("940852705251950642");

	if(channel != channelSetUCP) return DCC_SendChannelMessage(channel, "`[MERPATIBOT]: Error you are not part of the admin team`");
	new getNameIC[256], getNameUCP[12];
	if(sscanf(params, "s[256]s[12]", getNameIC, getNameUCP)) return DCC_SendChannelMessage(channel, "`[MERPATIBOT]: Usage !setucpuser [Name IC] [Name UCP]`");

	new setUCPQuery[178];
	mysql_format(g_SQL, setUCPQuery, sizeof setUCPQuery, "SELECT * FROM `playerucp` WHERE `uUserUcp` = '%s' LIMIT 1", getNameUCP);
	mysql_tquery(g_SQL, setUCPQuery, "CheckPlayerUCPex", "ss", getNameIC, getNameUCP);
	return 1;
}

DCMD:admins(user, channel, params[])
{
	new count = 0, line3[1200];
	foreach(new i:Player)
	{
		if(pData[i][pAdmin] > 0 || pData[i][pHelper] > 0)
		{
			format(line3, sizeof(line3), "%s\n%s(%s)\n", line3, pData[i][pName], pData[i][pAdminname], GetStaffRank(i));
			count++;
		}
	}
	if(count > 0)
	{
		new DCC_Embed:msgEmbed, msgField[256];
		format(msgField, sizeof(msgField), "```%s```", line3);
		msgEmbed = DCC_CreateEmbed("", "", "", "", 0x00ff00, "Admin online list", "", "", "");
		DCC_AddEmbedField(msgEmbed, "Admin Online In Server", msgField);
		DCC_SendChannelEmbedMessage(channel, msgEmbed);
	}
	else return DCC_SendChannelMessage(channel, "There are no admin online!");
	return 1;
}

DCMD:id(use, channel, params[])
{
	new otherid;
	new str[356];
	if(sscanf(params, "u", otherid))
	{
	    DCC_SendChannelMessage(channel, "USAGE: !id [ID/Name]");
 		return 1;
 	}
	//Servers(playerid, "Name: %s(ID: %d) | UCP Name: %s | Level: %d", pData[otherid][pName], otherid, pData[otherid][pUCP], pData[otherid][pLevel]);
	format(str, sizeof(str), "%sName: %s(ID: %d) | UCP Name: %s | Level: %d\n", str, pData[otherid][pName], otherid, pData[otherid][pUCP], pData[otherid][pLevel]);
	//format(str,sizeof(str),"Name: %s(ID: %d) | UCP Name: %s | Level: %d", pData[otherid][pName], otherid, pData[otherid][pUCP], pData[otherid][pLevel]);
	DCC_SendChannelMessage(channel, str);
	return 1;
}

DCMD:kickall(user, channel, params[])
{
	if(channel != panelMerpati) return DCC_SendChannelMessage(channel, "`[MERPATIBOT]: Error you are not part of the admin team`");
	SendRconCommand("hostname MERPATI ROLEPLAY | [MAINTANANCE]");
	GameTextForAll("Server will restart in 20 seconds", 20000, 3);
	SetTimer("PlayerKickALL", 20000, false);
	DCC_SendChannelMessage(channel, "Successfully kicked all the players in Server");
	return 1;
}

DCMD:removeucp(playerid, channel, params[])
{
	if(channel != panelMerpati) return DCC_SendChannelMessage(channel, "`[MERPATIBOT]: Error you are not part of the admin team`");
    new player[200], str[200], string[200];
	if(isnull(params)) return DCC_SendChannelMessage(channel, "USAGE: !removeucp [UCP]");
	format(player,sizeof(player),"/userucp/%s.ini", params);

    format(str,sizeof(str), "UCP: `%s` tidak ditemukan di database", params);
	if(!dini_Exists(player)) return DCC_SendChannelMessage(channel, str);

	dini_Remove(player);

	format(string,sizeof(string),"```UCP: `%s` Berhasil di hapus dari database!```", params);
	DCC_SendChannelMessage(channel, string);
	return 1;
}

DCMD:checkplayer(user, channel, params[])
{
	if(channel != panelMerpati) return DCC_SendChannelMessage(channel, "`[MERPATIBOT]: Error you are not part of the admin team`");
	new name[24];
	if(sscanf(params, "s[24]", name))
	{
	    DCC_SendChannelMessage(channel, "USAGE: !checkplayer [Player_Name]");
 		return 1;
 	}
	// Load User Data
    new cVar[500];
    new cQuery[600];

	strcat(cVar, "admin,money,bmoney,brek");

	mysql_format(g_SQL, cQuery, sizeof(cQuery), "SELECT %s FROM players WHERE username='%e' LIMIT 1", cVar, name);
	mysql_tquery(g_SQL, cQuery, "LoadStatsDiscord", "s", name);
	return 1;
}

DCMD:ans(user, channel, params[])
{
	if(channel != g_Discord_ReportAccept) return DCC_SendChannelMessage(channel, "`[MERPATIBOT]: Kamu tidak bisa menggunakan cmd ini!`");

	new userName[DCC_NICKNAME_SIZE];
	DCC_GetUserName(user, userName, sizeof(userName));

	new to_player, message[256];
	if(sscanf(params, "us[256]", to_player, message)) return DCC_SendChannelMessage(channel, "`USAGE: !ans [ID] [Message]`");

	new fmt_str[128];

	format(fmt_str, sizeof fmt_str, "[DISCORD REPORT]\n {ffffff}From {ff0000}[%S]:{FFFFFF} %s", userName, message);
	SendClientMessage(to_player, 0xFFFF00FF, fmt_str);
	PlayerPlaySound(to_player, 1085, 0.0, 0.0, 0.0);

	new DCC_Embed:msgAnsReport, msgDescReport[256];
	format(msgDescReport, sizeof(msgDescReport), "Report Message Berhasil Dikirim Ke Player %s(%d)\nMessage Report: %s", pData[to_player][pName], to_player, message);
	msgAnsReport = DCC_CreateEmbed("[ REPORT ACCEPT ]", msgDescReport, "", "", 0x00ff00, "Report Send", "", "", "");
	DCC_SendChannelEmbedMessage(channel, msgAnsReport);

	SendStaffMessage(COLOR_RED, ""YELLOW_E"[REPORT DISCORD LOGS] [Msg: %s] | %s[%d]:{FFFFFF} | %s", userName, pData[to_player][pName], to_player, message);

	return 1;
}

DCMD:ann(user, channel, params[])
{
	if(channel != panelMerpati) return DCC_SendChannelMessage(channel, "`[MERPATIBOT]: Error you are not part of the admin team`");
	if(isnull(params)) return DCC_SendChannelMessage(channel, "`USAGE: !ann [Message]`");

	new str[512];
	format(str, sizeof(str), "~w~%s", params);
	GameTextForAll(str, 7000, 3);

	new msgAnn[256];
	format(msgAnn, sizeof(msgAnn), "`[MERPATIBOT]: '%s' Berhasil ditampilkan`", params);
	DCC_SendChannelMessage(channel, msgAnn);
	return 1;
}

DCMD:ojail(user, channel, params[])
{
	if(channel != panelMerpati) return DCC_SendChannelMessage(channel, "`[MERPATIBOT]: Error you are not part of the admin team`");
	new player[24], datez, tmp[50], PlayerName[MAX_PLAYER_NAME];
	if(sscanf(params, "s[24]ds[50]", player, datez, tmp))
		return DCC_SendChannelMessage(channel, "`USAGE: !ojail <name> <time in minutes)> <reason>`");

	if(strlen(tmp) > 50) return DCC_SendChannelMessage(channel, "`[MERPATIBOT]: Reason must be shorter than 50 characters.`");
	if(datez < 1 || datez > 60) return DCC_SendChannelMessage(channel, "`[MERPATIBOT]: Jail time must remain between 1 and 60 minutes`");

	foreach(new ii : Player)
	{
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

	    if(strfind(PlayerName, player, true) != -1)
		{
			DCC_SendChannelMessage(channel, "`[MERPATIBOT]: Player is online, you can use /jail on him.`");
	  		return 1;
	  	}
	}
	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT reg_id FROM players WHERE username='%e'", player);
	mysql_tquery(g_SQL, query, "OJailPlayerDiscord", "ssi", player, tmp, datez);
	return 1;
}
