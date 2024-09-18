// -279.67, -2148.42, 28.54 buy product
//727.124572, -651.233459, 15.410306 point1
//727.124572, -655.233459, 15.410306 point2
//727.124572, -659.233459, 15.410306 point 3
//727.124572, -663.233459, 15.410306 point4
CreateJoinPartPoint()
{
	//JOBS
	new strings[128];
	CreateDynamicPickup(1239, 23, 826.62, -613.77, 16.33, -1);
	format(strings, sizeof(strings), "{ffffff}Pekerjaan Part Cars\n'/getjob' Untuk bekerja Parts Car\n'/help > Job > Parts Car' Untuk mengetahui command");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 826.62, -613.77, 16.33, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // production job

	format(strings, sizeof(strings), "[Parts Car JOBS]\n{FFFFFF}/createpart");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 1085.49, 2112.57, 15.35, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // production job

	format(strings, sizeof(strings), "[Parts Car JOBS]\n{FFFFFF}/createpart");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 1085.45, 2118.80, 15.35, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // production job

	format(strings, sizeof(strings), "[Parts Car JOBS]\n{FFFFFF}/createpart");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 1091.71, 2112.64, 15.35, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // production job

	format(strings, sizeof(strings), "[Parts Car JOBS]\n{FFFFFF}/createpart");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 1091.58, 2118.43, 15.35, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // production job
}


CMD:createpart(playerid, params[])
{
	if(pData[playerid][pJobTime] > 0) return Error(playerid, "Anda harus menunggu "GREY2_E"%d "WHITE_E"detik untuk bisa bekerja kembali.", pData[playerid][pJobTime]);
	if(pData[playerid][pJob] == 12 || pData[playerid][pJob2] == 12)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.0, 1085.49, 2112.57, 15.35) || IsPlayerInRangeOfPoint(playerid, 2.0, 1091.71, 2112.64, 15.35)
		|| IsPlayerInRangeOfPoint(playerid, 2.0, 1085.45, 2118.80, 15.35) || IsPlayerInRangeOfPoint(playerid, 2.0, 1091.58, 2118.43, 15.35))
		{
			new type;
			if(sscanf(params, "d", type)) return Usage(playerid, "/createpart [type, 1.Body 2.Spoiler 3.Mesin");

			if(type < 1 || type > 3) return Error(playerid, "Invalid type id.");

			if(type == 1)
			{
				if(pData[playerid][pActivityTime] > 5) return Error(playerid, "Anda masih memiliki activity progress!");
				if(pData[playerid][pMaterial] < 40) return Error(playerid, "material tidak cukup!(Minimal: 40).");
				if(pData[playerid][CarryPart] != 0) return Error(playerid, "Anda sedang membawa sebuah Parts");
				pData[playerid][pMaterial] -= 40;

				TogglePlayerControllable(playerid, 0);
				Info(playerid, "Anda sedang memproduksi Body dengan 40 material!");
				ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
				pData[playerid][pPartStatus] = 1;
				pData[playerid][pPart] = SetTimerEx("CreatePart", 1000, true, "id", playerid, 1);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Creating...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
			}
			else if(type == 2)
			{
				if(pData[playerid][pActivityTime] > 5) return Error(playerid, "Anda masih memiliki activity progress!");
				if(pData[playerid][pMaterial] < 40) return Error(playerid, "Material tidak cukup!(Butuh: 40).");
				if(pData[playerid][CarryPart] != 0) return Error(playerid, "Anda sedang membawa sebuah parts");
				pData[playerid][pMaterial] -= 40;

				TogglePlayerControllable(playerid, 0);
				Info(playerid, "Anda sedang memproduksi Spoiler dengan 40 material!");
				ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
				pData[playerid][pPartStatus] = 1;
				pData[playerid][pPart] = SetTimerEx("CreatePart", 1000, true, "id", playerid, 2);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Creating...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);

			}
			else if(type == 3)
			{
				if(pData[playerid][pActivityTime] > 5) return Error(playerid, "Anda masih memiliki activity progress!");
				if(pData[playerid][pMaterial] < 40) return Error(playerid, "Material tidak cukup!(Butuh: 40).");
				if(pData[playerid][pComponent] < 20) return Error(playerid, "Component tidak cukup!(Butuh: 20).");
				if(pData[playerid][CarryPart] != 0) return Error(playerid, "Anda sedang membawa sebuah Parts");
				pData[playerid][pMaterial] -= 40;
				pData[playerid][pComponent] -= 20;

				TogglePlayerControllable(playerid, 0);
				Info(playerid, "Anda sedang memproduksi Mesin dengan 40 material dan 20 component!");
				ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
				pData[playerid][pPartStatus] = 1;
				pData[playerid][pPart] = SetTimerEx("CreatePart", 1000, true, "id", playerid, 3);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Creating...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
			}
		}
		else return Error(playerid, "You're not near in sparepart warehouse.");
	}
	else Error(playerid, "Anda bukan pekerja sebagai pabrik sparepart.");
	return 1;
}

function CreatePart(playerid, type)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(pData[playerid][pPartStatus] != 1) return 0;
	if(pData[playerid][pJob] == 12 || pData[playerid][pJob2] == 12)
	{
		if(pData[playerid][pActivityTime] >= 100)
		{
		if(IsPlayerInRangeOfPoint(playerid, 2.0, 1085.49, 2112.57, 15.35) || IsPlayerInRangeOfPoint(playerid, 2.0, 1091.71, 2112.64, 15.35)
		|| IsPlayerInRangeOfPoint(playerid, 2.0, 1085.45, 2118.80, 15.35) || IsPlayerInRangeOfPoint(playerid, 2.0, 1091.58, 2118.43, 15.35))
			{
				if(type == 1)
				{
					SetPlayerAttachedObject(playerid, 9, 2453, 5, 0.105, 0.086, 0.22, -80.3, 3.3, 28.7, 0.35, 0.35, 0.35);
					pData[playerid][CarryPart] = 1;
					Info(playerid, "Anda telah berhasil membuat Body, /sellpart untuk menjualnya.");
					TogglePlayerControllable(playerid, 1);
					InfoTD_MSG(playerid, 8000, "Body Created!");
					KillTimer(pData[playerid][pPart]);
					pData[playerid][pActivityTime] = 0;
					pData[playerid][pPartStatus] = 0;
					HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
					pData[playerid][pEnergy] -= 3;
					ClearAnimations(playerid);
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
				}
				else if(type == 2)
				{
					SetPlayerAttachedObject(playerid, 9, 2391, 5, 0.105, 0.086, 0.22, -80.3, 3.3, 28.7, 0.35, 0.35, 0.35);
					pData[playerid][CarryPart] = 2;
					Info(playerid, "Anda telah berhasil membuat spoiler, /sellpart untuk menjualnya.");
					TogglePlayerControllable(playerid, 1);
					InfoTD_MSG(playerid, 8000, "Spoiler Created!");
					KillTimer(pData[playerid][pPart]);
					pData[playerid][pActivityTime] = 0;
					pData[playerid][pPartStatus] = 0;
					HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
					pData[playerid][pEnergy] -= 3;
					ClearAnimations(playerid);
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
				}
				else if(type == 3)
				{
					SetPlayerAttachedObject(playerid, 9, 2912, 5, 0.105, 0.086, 0.22, -80.3, 3.3, 28.7, 0.35, 0.35, 0.35);
					pData[playerid][CarryPart] = 3;
					Info(playerid, "Anda telah berhasil membuat Mesin, /sellpart untuk menjualnya.");
					TogglePlayerControllable(playerid, 1);
					InfoTD_MSG(playerid, 8000, "Mesin Created!");
					KillTimer(pData[playerid][pPart]);
					pData[playerid][pActivityTime] = 0;
					pData[playerid][pPartStatus] = 0;
					HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
					pData[playerid][pEnergy] -= 3;
					ClearAnimations(playerid);
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
				}
				else
				{
					KillTimer(pData[playerid][pPart]);
					pData[playerid][pActivityTime] = 0;
					pData[playerid][pPartStatus] = 0;
					HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
					return 1;
				}
			}
		}
		else if(pData[playerid][pActivityTime] < 100)
		{
		if(IsPlayerInRangeOfPoint(playerid, 2.0, 1085.49, 2112.57, 15.35) || IsPlayerInRangeOfPoint(playerid, 2.0, 1091.71, 2112.64, 15.35)
		|| IsPlayerInRangeOfPoint(playerid, 2.0, 1085.45, 2118.80, 15.35) || IsPlayerInRangeOfPoint(playerid, 2.0, 1091.58, 2118.43, 15.35))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
				ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
			}
		}
	}
	return 1;
}

CMD:sellpart(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 801.12, -613.77, 16.33)) return Error(playerid, "Kamu tidak didekat Warehouse.");
	if(pData[playerid][CarryPart] == 0) return Error(playerid, "Kamu sedang tidak memegang apapun.");

	if(pData[playerid][CarryPart] == 1)
	{
		RemovePlayerAttachedObject(playerid, 9);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		pData[playerid][CarryPart] = 0;
		GivePlayerMoneyEx(playerid, 1010);

		//Sparepart += 10;
		Server_MinMoney(500);
		Server_Save();
		InfoTD_MSG(playerid, 3500, "~g~$1010");
		Info(playerid, "Anda menjual parts dengan harga "GREEN_E"$1010");
		pData[playerid][pJobTime] += 160;
	}
	else if(pData[playerid][CarryPart] == 2)
	{
		RemovePlayerAttachedObject(playerid, 9);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		pData[playerid][CarryPart] = 0;
		GivePlayerMoneyEx(playerid, 1120);

		//Sparepart += 10;
		Server_MinMoney(1220);
		Server_Save();
		InfoTD_MSG(playerid, 3500, "~g~$1220");
		Info(playerid, "Anda menjual parts dengan harga "GREEN_E"$1220");
		pData[playerid][pJobTime] += 120;
	}
	else if(pData[playerid][CarryPart] == 3)
	{
		RemovePlayerAttachedObject(playerid, 9);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		pData[playerid][CarryPart] = 0;
		GivePlayerMoneyEx(playerid, 1320);

		//Sparepart += 10;
		Server_MinMoney(1320);
		Server_Save();
		InfoTD_MSG(playerid, 3500, "~g~$1320");
		Info(playerid, "Anda menjual parts dengan harga "GREEN_E"$1320");
		pData[playerid][pJobTime] += 260;
	}
	return 1;
}
