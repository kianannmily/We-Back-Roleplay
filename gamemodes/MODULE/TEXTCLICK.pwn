public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(playertextid == IDCard[playerid][25])
    {
        for(new txd; txd < 26; txd++)
        {
            PlayerTextDrawHide(playerid, IDCard[playerid][txd]);
            CancelSelectTextDraw(playerid);
        }           
    }
    if(playertextid == LICCard[playerid][11])
    {
        for(new txd; txd < 26; txd++)
        {
            PlayerTextDrawHide(playerid, LICCard[playerid][txd]);
            CancelSelectTextDraw(playerid);
        }           
    }
    return 1;
}

