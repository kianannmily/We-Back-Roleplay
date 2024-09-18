//Rob bank system
//robbank bank besar
CMD:lockpick(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid,2.0, 291.35, -106.30, 1001.51))
	if(pData[playerid][pFamily] >= 1)

	{

		Info(playerid, "You're in create please wait...");
		pData[playerid][pActivity] = SetTimerEx("Lockpick", 100, true, "i", playerid);
		PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Create...");
		PlayerTextDrawShow(playerid, ActiveTD[playerid]);
		ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
		TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		InRob[playerid] = 1;
		}
	else
	{
		Error(playerid, "Anda Bukan Anggota Family!");
  }
	return 1;
}

function Lockpick(playerid)
{

	{
	    if(pData[playerid][pActivityTime] >= 100)
	    {
	    	InfoTD_MSG(playerid, 8000, "Lockpick Creating!");
	    	TogglePlayerControllable(playerid, 1);
	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pEnergy] -= 30;
			pData[playerid][pActivityTime] = 0;
			ClearAnimations(playerid);
	    	InRob[playerid] = 0;
	        GivePlayerMoneyEx(playerid, -700);
	    	pData[playerid][pLockPick] += 1;
	    	SendClientMessageEx(playerid, COLOR_WHITE, "INFO: {FFFFFF}You've successfully creat the lockpick and your money -$700");
		}
 		else if(pData[playerid][pActivityTime] < 100)
		{
	    	pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	    	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
		}
	}
	return 1;
}
CMD:robbank(playerid, params[])
{

    if(pData[playerid][RobbankTime] >= gettime()) return Error(playerid, "You've must wait %d seconds to robbery bank", pData[playerid][RobbankTime] - gettime());
	if(IsPlayerInRangeOfPoint(playerid,2.0, 1648.69, -1356.05, 18.20))
	if(pData[playerid][pLockPick] >= 1)

	{
		SendClientMessageToAll(COLOR_RED, "SAPD:{FFFFFF}TELAH TERJADI ROBBANK DI BANK LOS SANTOS,WARGA HARAP MENJAUH DARI SEKITAR!");
		if(GetPVarInt(playerid, "Robbank") > gettime())
					return Error(playerid, "Delays Rob, please wait.");

		Info(playerid, "You're in robbery please wait...");
		pData[playerid][pActivity] = SetTimerEx("Robbank", 6000, true, "i", playerid);
		PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Robbing...");
		PlayerTextDrawShow(playerid, ActiveTD[playerid]);
		ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
		TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		InRob[playerid] = 1;
		}
	else
	{
		Error(playerid, "Anda Tidak Mempunyai Lockpick to robberybank!");
  }
	return 1;
}

function Robbank(playerid)
{

	{
	    if(pData[playerid][pActivityTime] >= 100)
	    {
	    	InfoTD_MSG(playerid, 8000, "Robbing done!");
	    	pData[playerid][BankDelay] = 120;
	    	TogglePlayerControllable(playerid, 1);
	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pEnergy] -= 30;
			pData[playerid][pActivityTime] = 0;
			ClearAnimations(playerid);
	    	InRob[playerid] = 0;
	    	pData[playerid][pRedMoney] += 20000;
	    	pData[playerid][pLockPick] -= 1;
	    	Server_MinMoney(20000);
	    	SendClientMessageEx(playerid, COLOR_WHITE, "INFO: {FFFFFF}You've successfully robbing the bank and earn red money $20000");
	    	pData[playerid][RobbankTime] = gettime() + 172800;
		}
 		else if(pData[playerid][pActivityTime] < 100)
		{
	    	pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	    	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
		}
	}
	return 1;
}

function Robb(playerid)
{

	{
	    if(pData[playerid][pActivityTime] >= 100)
	    {
	    	InfoTD_MSG(playerid, 8000, "Robbing done!");
	    	TogglePlayerControllable(playerid, 1);
	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pEnergy] -= 30;
			pData[playerid][pActivityTime] = 0;
			ClearAnimations(playerid);
	    	InRob[playerid] = 0;
	    	GivePlayerMoneyEx(playerid, bMoney);
	    	SendClientMessageEx(playerid, COLOR_WHITE, "INFO: {FFFFFF}You've successfully robbing the business and earn %d!", bMoney);
	    	pData[playerid][RobbizTime] = gettime() + 5000;
		}
 		else if(pData[playerid][pActivityTime] < 100)
		{
	    	pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	    	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
		}
	}
	return 1;
}

function Robbatm(playerid)
{

	{
	    if(pData[playerid][pActivityTime] >= 100)
	    {
	    	InfoTD_MSG(playerid, 8000, "Robbing done!");
	    	TogglePlayerControllable(playerid, 1);
	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pEnergy] -= 30;
			pData[playerid][pActivityTime] = 0;
			ClearAnimations(playerid);
	    	InRob[playerid] = 0;
	    	pData[playerid][pRedMoney] += 1200;
	    	pData[playerid][RobatmTime] = gettime() + 3600;
		}
 		else if(pData[playerid][pActivityTime] < 100)
		{
	    	pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	    	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
		}
	}
	return 1;
}

CMD:robbery(playerid, params[])
{
    new id = -1;
	id = GetClosestATM(playerid);

	if(IsPlayerConnected(playerid))
	{
        if(isnull(params))
		{
            Usage(playerid, "USAGE: /robbery [name]");
            Info(playerid, "Names: atm, biz");
            return 1;
        }
		if(strcmp(params,"biz",true) == 0)
		{
            if(pData[playerid][RobbizTime] >= gettime()) return Error(playerid, "You've must wait %d seconds to robbery biz", pData[playerid][RobbizTime] - gettime());
            if(pData[playerid][pInBiz] >= 0 && IsPlayerInRangeOfPoint(playerid, 2.5, bData[pData[playerid][pInBiz]][bPointX], bData[pData[playerid][pInBiz]][bPointY], bData[pData[playerid][pInBiz]][bPointZ]))
			{
	    		if(GetPVarInt(playerid, "Robb") > gettime())
					return Error(playerid, "Delays Rob, please wait.");

				Info(playerid, "You're in robbery please wait...");
                SendFactionMessage(1, COLOR_RED, "**DISPATCH: {FFFFFF}Seseorang Telah Melakukan Robbery Di Bisnis ID %d", GetPlayerVirtualWorld(playerid));

				pData[playerid][pActivity] = SetTimerEx("Robb", 1300, true, "i", playerid);

				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Robbing...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				TogglePlayerControllable(playerid, 0);
				ApplyAnimation(playerid, "BOMBER", "BOM_Plant",	4.0, 1, 0, 0, 0, 0, 1);
				InRob[playerid] = 1;
			}
        }
		else if(strcmp(params,"atm",true) == 0)
		{
			if(id > -1)
			{
				if(pData[playerid][RobatmTime] >= gettime()) return Error(playerid, "You've must wait %d seconds to robbery atm", pData[playerid][RobatmTime] - gettime());
                if(GetPlayerWeapon(playerid) != WEAPON_BAT) return Error(playerid, "You Need baseball.");
				Info(playerid, "You're in robbery please wait...");

				pData[playerid][pActivity] = SetTimerEx("Robbatm", 1300, true, "i", playerid);

				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Robbing...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				TogglePlayerControllable(playerid, 0);
				ApplyAnimation(playerid,"SWORD", "sword_4", 4.0, 1, 0, 0, 0, 0, 1);
				InRob[playerid] = 1;
			}
		}
		else if(strcmp(params,"bank",true) == 0)
		{
			if(id > -1)
			{
				if(pData[playerid][RobbankTime] >= gettime()) return Error(playerid, "You've must wait %d seconds to robbery bank", pData[playerid][RobbankTime] - gettime());
                //if(GetPlayerWeapon(playerid) != WEAPON_BAT) return Error(playerid, "You Need baseball.");
				Info(playerid, "You're in robbery please wait...");

				pData[playerid][pActivity] = SetTimerEx("Robb", 1300, true, "i", playerid);

				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Robbing...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				TogglePlayerControllable(playerid, 0);
				ApplyAnimation(playerid,"SWORD", "sword_4", 4.0, 1, 0, 0, 0, 0, 1);
				InRob[playerid] = 1;
			}
		}
	}
	return 1;
}


/*CMD:starthack(playerid, params[])
{
    if(StatusRobBank == 0) return Error(playerid, "ROB BANK", "Fitur Ini Di Nonaktifkan Admin, /report agar admin Mengaktifkanny.");
	if(!IsPlayerInRangeOfPoint(playerid, 1.5, 2145.85, 1604.9456, 993.5684)) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're not near the keypad.");
	if(BankControls[Alarm]) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}Alarm went off, you can't hack the keypad.");
	if(!BankControls[LasersOn]) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}Keypad has been hacked already.");
	if(BankControls[KeypadHackTime] > gettime())
	{
	    new string[72];
		format(string, sizeof(string), "ERROR: {FFFFFF}You have to wait %s to hack the keypad again.", ConvertToMinutes(BankControls[KeypadHackTime] - gettime()));
	 	SendClientMessage(playerid, 0xE74C3CFF, string);
		return 1;
	}

	ApplyAnimation(playerid, "COP_AMBIENT", "COPBROWSE_LOOP", 4.1, 1, 0, 0, 0, 0, 1);
	BankControls[KeypadHackTime] = gettime() + 600;
	RobberyType[playerid] = 1;
	RobberyCounter[playerid] = 20;
	RobberyTimer[playerid] = SetTimerEx("RobberyUpdate", 1000, true, "i", playerid);
	return 1;
}

CMD:plantbomb(playerid, params[])
{
    if(StatusRobBank == 0) return Error(playerid, "ROB BANK", "Fitur Ini Di Nonaktifkan Admin, /report agar admin Mengaktifkanny.");
    if(!IsPlayerInRangeOfPoint(playerid, 1.5, 2144.1624, 1626.25, 993.6882)) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're not near the vault door.");
	if(BankControls[VaultDoorState] != 0) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}Vault door is already open/opening.");
	if(BankControls[DoorInteractionTime] > gettime())
	{
	    new string[72];
		format(string, sizeof(string), "ERROR: {FFFFFF}You have to wait %s to open the vault door again.", ConvertToMinutes(BankControls[DoorInteractionTime] - gettime()));
	 	SendClientMessage(playerid, 0xE74C3CFF, string);
		return 1;
	}

	ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 1, 1, 0, 0, 1);
	BankControls[DoorInteractionTime] = gettime() + 600;
	BankControls[VaultDoorState] = 1; // opening
	SetTimerEx("OpenVaultDoor", 1000, false, "ii", 2, 6);
	SendClientMessage(playerid, -1, "Bomb has been planted and it'll explode in 6 seconds. Take cover!");
	return 1;
}

CMD:timelock(playerid, params[])
{
    if(StatusRobBank == 0) return Error(playerid, "ROB BANK", "Fitur Ini Di Nonaktifkan Admin, /report agar admin Mengaktifkanny.");
    if(!IsPlayerInRangeOfPoint(playerid, 1.5, 2140.2610, 1626.25, 993.6882)) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're not near the time lock.");
	if(BankControls[Alarm]) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}Time lock disabled because of alarm.");
	if(BankControls[VaultDoorState] != 0) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}Vault door is already open/opening.");
	if(BankControls[DoorInteractionTime] > gettime())
	{
	    new string[72];
		format(string, sizeof(string), "ERROR: {FFFFFF}You have to wait %s to open the vault door again.", ConvertToMinutes(BankControls[DoorInteractionTime] - gettime()));
	 	SendClientMessage(playerid, 0xE74C3CFF, string);
		return 1;
	}

	BankControls[DoorInteractionTime] = gettime() + 600;
	BankControls[VaultDoorState] = 1; // opening
	SetTimerEx("OpenVaultDoor", 1000, false, "ii", 3, 30);
	SendClientMessage(playerid, -1, "You've started the time lock, vault door will open in 30 seconds.");
	return 1;
}

CMD:emptydeposit(playerid, params[])
{
	if(StatusRobBank == 0) return Error(playerid, "ROB BANK", "Fitur Ini Di Nonaktifkan Admin, /report agar admin Mengaktifkanny.");
    if(BankControls[VaultDoorState] < 2) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You can't empty deposit boxes when the vault door isn't open.");
	new id = GetClosestDeposit(playerid);
	if(id == -1) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're not near any deposit boxes.");
	if(DepositRobbed[id]) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}Deposit boxes you're trying to rob are already robbed.");
	DepositRobbed[id] = true;
	Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, InsideVaultLabels[id], E_STREAMER_COLOR, 0xE74C3CFF);
	ApplyAnimation(playerid, "ROB_BANK", "CAT_Safe_Rob", 4.0, 1, 0, 0, 0, 0, 1);
	RobberyType[playerid] = 2;
	RobberyCounter[playerid] = 10;
	RobberyTimer[playerid] = SetTimerEx("RobberyUpdate", 1000, true, "i", playerid);
	return 1;
}

//robbank bank besar
CMD:robbank(playerid, params[])
{
        
    if(pData[playerid][RobbankTime] >= gettime()) return Error(playerid, "You've must wait %d seconds to robbery bank", pData[playerid][RobbankTime] - gettime());
	if(IsPlayerInRangeOfPoint(playerid,2.0, -1103.19, -1038.87, 2997.99))
	if(pData[playerid][pLockPick] >= 1)

	{
		SendClientMessageToAll(COLOR_RED, "SAPD:{FFFFFF}TELAH TERJADI ROBBANK DI BANK LOS SANTOS,WARGA HARAP MENJAUH DARI SEKITAR!");
		if(GetPVarInt(playerid, "Robbank") > gettime())
					return Error(playerid, "Delays Rob, please wait.");

		Info(playerid, "You're in robbery please wait...");
		pData[playerid][pRobStatus] = 1;
		pData[playerid][pActivity] = SetTimerEx("Robbank", 6000, true, "i", playerid);
		PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Robbing...");
		PlayerTextDrawShow(playerid, ActiveTD[playerid]);
		ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
		TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		InRob[playerid] = 1;
		}
	else
	{
		Error(playerid, "Anda Tidak Mempunyai Lockpick to robberybank!");
  }
	return 1;
}
CMD:createlockpick(playerid, params[])
{

	if(IsPlayerInRangeOfPoint(playerid,2.0, -3805.48, 1306.75, 75.5))
	if(pData[playerid][pMaterial] >= 75)
	if(pData[playerid][pComponent] >= 150)


	{
		Info(playerid, "You're in Creating please wait...");
		pData[playerid][pRobStatus] = SetTimerEx("Lockpick", 2000, true, "i", playerid);
		PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Creating...");
		PlayerTextDrawShow(playerid, ActiveTD[playerid]);
		ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
		TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		InRob[playerid] = 1;
		}
	else
	{
		Error(playerid, " anda membutuhkan 150 component & 75 material!");
  }
	return 1;
}

function Lockpick(playerid)
{
    if(pData[playerid][pRobStatus] != 1) return 0;
	{
	    if(pData[playerid][pActivityTime] >= 100)
	    {
	    	InfoTD_MSG(playerid, 8000, "Creating Succes!");
	    	TogglePlayerControllable(playerid, 1);
	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pEnergy] -= 30;
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pComponent] -= 150;
			pData[playerid][pMaterial] -= 75;
			ClearAnimations(playerid);
	    	pData[playerid][pLockPick] += 1;
	    	SendClientMessageEx(playerid, COLOR_WHITE, "INFO: {FFFFFF}You've successfully create the lockpick");
	    	
		}
 		else if(pData[playerid][pActivityTime] < 100)
		{
	    	pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	    	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
		}
	}
	return 1;
}

function Robbank(playerid)
{
    if(pData[playerid][pRobStatus]) return 0;
	{
	    if(pData[playerid][pActivityTime] >= 100)
	    {
	    	InfoTD_MSG(playerid, 8000, "Robbing done!");
	    	pData[playerid][BankDelay] = 120;
	    	TogglePlayerControllable(playerid, 1);
	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pEnergy] -= 30;
			pData[playerid][pActivityTime] = 0;
			pData[playerid][pLockPick] -= 1;
			ClearAnimations(playerid);
	    	InRob[playerid] = 0;
	    	pData[playerid][pRedMoney] += 10000;
	    	Server_MinMoney(500000);
	    	SendClientMessageEx(playerid, COLOR_WHITE, "INFO: {FFFFFF}You've successfully robbing the bank and red money $10000");
	    	pData[playerid][RobbankTime] = gettime() + 17280;
		}
 		else if(pData[playerid][pActivityTime] < 100)
		{
	    	pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	    	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
		}
	}
	return 1;
}

function Robb(playerid)
{
    if(pData[playerid][pRobStatus] != 1) return 0;
	{
	    if(pData[playerid][pActivityTime] >= 100)
	    {
	    	InfoTD_MSG(playerid, 8000, "Robbing done!");
	    	TogglePlayerControllable(playerid, 1);
	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pEnergy] -= 30;
			pData[playerid][pActivityTime] = 0;
			ClearAnimations(playerid);
	    	InRob[playerid] = 0;
	    	GivePlayerMoneyEx(playerid, bMoney);
	    	SendClientMessageEx(playerid, COLOR_WHITE, "INFO: {FFFFFF}You've successfully robbing the business and earn %d!", bMoney);
	    	pData[playerid][RobbizTime] = gettime() + 5000;
		}
 		else if(pData[playerid][pActivityTime] < 100)
		{
	    	pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	    	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
		}
	}
	return 1;
}

function Robbatm(playerid)
{
    if(pData[playerid][pRobStatus] != 1) return 0;
	{
	    if(pData[playerid][pActivityTime] >= 100)
	    {
	    	InfoTD_MSG(playerid, 8000, "Robbing done!");
	    	TogglePlayerControllable(playerid, 1);
	    	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pEnergy] -= 30;
			pData[playerid][pActivityTime] = 0;
			ClearAnimations(playerid);
	    	InRob[playerid] = 0;
	    	pData[playerid][pRedMoney] += 1000;
	    	pData[playerid][RobatmTime] = gettime() + 3600;
		}
 		else if(pData[playerid][pActivityTime] < 100)
		{
	    	pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
	    	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
		}
	}
	return 1;
}

CMD:robbery(playerid, params[])
{
    new id = -1;
	id = GetClosestATM(playerid);

	if(IsPlayerConnected(playerid))
	{
        if(isnull(params))
		{
            Usage(playerid, "USAGE: /robbery [name]");
            Info(playerid, "Names: atm, biz");
            return 1;
        }
		if(strcmp(params,"biz",true) == 0)
		{
            if(pData[playerid][RobbizTime] >= gettime()) return Error(playerid, "You've must wait %d seconds to robbery biz", pData[playerid][RobbizTime] - gettime());
            if(pData[playerid][pInBiz] >= 0 && IsPlayerInRangeOfPoint(playerid, 2.5, bData[pData[playerid][pInBiz]][bPointX], bData[pData[playerid][pInBiz]][bPointY], bData[pData[playerid][pInBiz]][bPointZ]))
			{
	    		if(GetPVarInt(playerid, "Robb") > gettime())
					return Error(playerid, "Delays Rob, please wait.");

				Info(playerid, "You're in robbery please wait...");
                SendFactionMessage(1, COLOR_RED, "**DISPATCH: {FFFFFF}Seseorang Telah Melakukan Robbery Di Bisnis ID %d", GetPlayerVirtualWorld(playerid));
				
				pData[playerid][pRobStatus] = 1;
				pData[playerid][pActivity] = SetTimerEx("Robb", 1300, true, "i", playerid);
    			
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Robbing...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				TogglePlayerControllable(playerid, 0);
				ApplyAnimation(playerid, "BOMBER", "BOM_Plant",	4.0, 1, 0, 0, 0, 0, 1);
				InRob[playerid] = 1;
			}
        }
		else if(strcmp(params,"atm",true) == 0)
		{
			if(id > -1)
			{
				if(pData[playerid][RobatmTime] >= gettime()) return Error(playerid, "You've must wait %d seconds to robbery atm", pData[playerid][RobatmTime] - gettime());
                if(GetPlayerWeapon(playerid) != WEAPON_BAT) return Error(playerid, "You Need baseball.");
				Info(playerid, "You're in robbery please wait...");

                pData[playerid][pRobStatus] = 1;
				pData[playerid][pActivity] = SetTimerEx("Robbatm", 1300, true, "i", playerid);
    			
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Robbing...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				TogglePlayerControllable(playerid, 0);
				ApplyAnimation(playerid,"SWORD", "sword_4", 4.0, 1, 0, 0, 0, 0, 1);
				InRob[playerid] = 1;
			}
		}
		else if(strcmp(params,"bank",true) == 0)
		{
			if(id > -1)
			{
				if(pData[playerid][RobbankTime] >= gettime()) return Error(playerid, "You've must wait %d seconds to robbery bank", pData[playerid][RobbankTime] - gettime());
                //if(GetPlayerWeapon(playerid) != WEAPON_BAT) return Error(playerid, "You Need baseball.");
				Info(playerid, "You're in robbery please wait...");

				pData[playerid][pRobStatus] = 1;
				pData[playerid][pActivity] = SetTimerEx("Robb", 1300, true, "i", playerid);
    			
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Robbing...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				TogglePlayerControllable(playerid, 0);
				ApplyAnimation(playerid,"SWORD", "sword_4", 4.0, 1, 0, 0, 0, 0, 1);
				InRob[playerid] = 1;
			}
		}
	}
	return 1;
}
