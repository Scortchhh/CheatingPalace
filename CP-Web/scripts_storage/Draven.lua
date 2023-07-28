Draven = {}

function Draven:__init()
    if myHero.Team == 100 then
		self.EnemyBase = Vector3.new(14400, 200, 14400)
	else
		self.EnemyBase = Vector3.new(400, 200, 400)
	end

    self.TextArtGif = {
        {Order = 1, Text = "lodxkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~lodxkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~odxkkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~odxkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~odxkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~odxkOOkkxxddoooollllllllllllllllllllooodddxxkkkOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~dxkkOOOOOkkkxxddoollcc::;;;;;,,,,,;;,,;;;;;;::ccclloooddxxxkkkOOOOOOOOOOOOO~n~dxkOOOOOOOOOOOOOOOOOOkkkxxddoollcc:::;;;;;,,,,;;;;;;,;;;;;;::ccclloooddxkOO~n~dxkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkkkxxxddoollcc::;;;;;,,,,,,,,,,,''''':xOO~n~xkkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO0000OOOOkkkxxo:,'''''''''''''''ckOO~n~xkkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO0000OOO00000k:''''''''''''''',oOOO~n~xkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO000O00000d;''''''''''''''':xOOO~n~xkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO000000Oo,'''''''''''''''ckOOO~n~kkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO000kc''''''''''''''',oOOOO~n~kkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO0000x:''''''''''''''':xOOOO~n~kOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO0O0Od;'''''''''''''''lkOOOO~n~kOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO0Oo,'''''''''''''',oOOOOO~n~kOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkc''''''''''''''':xOOOOO~n~kOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOx:'''''''''''''''lOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOd,'''''''''''''',dOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOl''''''''''''''':xOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkc'''''''''''''''lOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOx;'''''''''''''';dOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo,'''''''''''''':kOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOl'''''''''''''''lOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkc'''''''''''''';dOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOx;'''''''''''''':kOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo,''''''''''''',lOOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkl''''''''''''',lkOOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOk:''''''''''',cxOOOOOOOOOOO~n~OO000OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOd;''''''''',:dOOOOOOOOOOOOO~n~OOO00OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo,'''''''':okOOOOOOOOOOOOOO~n~OO0000OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkl''''''';okOOOOOOOOOOOOOOOO~n~000000OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOx:''''';lkOOOOOOOOOOOOOOOOOO~n~00000OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOd;''',lxOOOOOOOOOOOOOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo,',cxOOOOOOOOOOOOOOOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkc,:dOOOOOOOOOOOOOOOOOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkookOOOOOOOOOOOOOOOOOOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO0OOOOOOOOOOOOOOOOOOOOOOO"},
        {Order = 2, Text = ";;;;;;;;;;;;;;;;;;:cclodxkkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~;;;;;;;;;;;;;;;;;::clodxxkkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~;;;;;;;;;;;;;;;;;::clodxkkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~;;;;;;;;clc::;;;;:clodxxkkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~;;;;;;;:dOOkkxdoollccclloddxxkkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~;;;;;;;cxOOOOOOOOOkkxdoolccc:::cclloooodxxkkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~;;;;;;;lkOOOOOOOOOOOOOOOOOkkxdollc:;,,,,,;::cloddxkkOOOOOOOOOOOOOOOOOOOOOOO~n~;;;;;;:dOOOOOOOOOOOOOOOOOOOOOOOOOOkxxddolc::;,,,,;;:cloodxkkOOOOOOOOOOOOOOO~n~;;;;;;:xOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkkxdoolc:,,,,,,;;:cclodxxkOOOOOOO~n~;;;;;;lkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOd:,;,,,,,,,,,,,;;:cllodxx~n~;;;;;;okOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkl;,;;,;;;;;;;;;;;;;;;;;;:~n~;;;;;:dOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOd:;;;;;,;;;;;;;;;;;;;;;;;:~n~;;;;;cxOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkl;;;;;;;;;;;;;;;;;;;;;;;;o~n~;;;;;lkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOxc;;;;;;;;;;;;;;;;;;;;;;;cx~n~;;;,;okOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOko;;;;;;;;;;;;;;;;;;;;;;;:oO~n~;;;,:dOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOxc;;;;;;;;;;;;;;;;;;;;;;;lxO~n~;;;;cxOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo;;;;;;;;;;;;;;;;;;;;;;;:dOO~n~;;;;lkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOxc;;;;;;;;;;;;;;;;;;;;;;;lkOO~n~;;;;oOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOd:;;;;;;;;;;;;;;;;;;;;;;:dOOO~n~;,;:dOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkl;;;;;;;;;;;;;;;;;;;;;;;okOOO~n~;;;cxOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOd:;;;;;;;;;;;;;;;;;;;;;;cxOOOO~n~;;;lkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkl;;;;;;;;;;;;;;;;;;;;;;;oOOOOO~n~;,;oOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOd:;;;;;;;;;;;;;;;;;;;;;;cxOOOOO~n~;;:xOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkl;;;;;;;;;;;;;;;;;;;;;;:dOOOOOO~n~;;cxOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOxc;,;;;;;;;;;;;;;;;;;;;;lkOOOOOO~n~;;okOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOko;;;;;;;;;;;;;;;;;;;;;;:dOOOOOOO~n~;;lxkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOxc;;;;;;;;;;;;;;;;;;;;;;lkOOOOOOO~n~;;;:ldxkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo;;;;;;;;;;;;;;;;;;;;;;cxOOOOOOOO~n~;;;;;:coxkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOxc;;;;;;;;;;;;;;;;;;;;;;okOOOOOOOO~n~;;;;;:ccodxkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOd:;;;;;;;;;;;;;;;;;;;;;cxOOOOOOOOO~n~;;;;::clodxkkOOOOOOOOOOOOOOOOOOOOOOOOOOOkl;;;;;;;;;;;;;;;;;;;;;cdOOOOOOOOOO~n~;;;;:cclodxkkOOOOOOOOOOOOOOOOOOOOOOOOOOOd:;;;;;;;;;;;;;;;;;:loxkOOOOOOOOOOO~n~;;;::clodxxkkOOOOOOOOOOOOOOOOOOOOOOOOOOkl;;;;;;;;;;;;;;:cldkOOOOOOOOOOOOOOO~n~;;;:cclodxkkOOOOOOOOOOOOOOOOOOOOOOOOOOOd:;;;;;;;;;;;:loxkOOOOOOOOOOOOOOOOOO~n~;;::clodxxkkOOOOOOOOOOOOOOOOOOOOOOOOOOkl;;;;;;;;:codkOOOOOOOOOOOOOOOOOOOOOO~n~;;::clodxkkOOOOOOOOOOOOOOOOOOOOOOOOOOOxc;;;;;cldxkOOOOOOOOOOOOOOOOOOOOOOOOO~n~;::clodxxkkOOOOOOOOOOOOOOOOOOOOOOOOOkko;;:loxkOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~;::clodxkkOOOOOOOOOOOOOOOOOOOOOOOOOOkxoodkkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~;:cllodxkkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"},
        {Order = 3, Text = ":::::::::::::::::::::::::::::::::::::::::cclloodxxkkkkkkkkkkkkkkkkkkkkkkkkk~n~::::::::::::ccc:::::::::::::::::::::::::ccclooddxxkkkkkkkkkkkkkkkkkkkkkkkkk~n~::::::::::::lxxdolc::::::::::::::::::::ccclloddxxkkkkkkkkkkkkkkkkkkkkkkkkkk~n~:::::::::::cdkkkkkxdolcc:;;:::::::::::ccclloodxxkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~::::::::::coxkkkkkkkkkkxdolc:;;;;;::::ccclooddxxkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~::::::::::cdkkkkkkkkkkkkkkkkxdol:;;,,,;;:clodxxkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~:::::::::cokkkkkkkkkkkkkkkkkkkkkkxdolc:;,,,;:clodxkkkkkkkkkkkkkkkkkkkkkkkkk~n~:::::::::ldkkkkkkkkkkkkkkkkkkkkkkkkkkkkxdol:;,',;:clodxkkkkkkkkkkkkkkkkkkkk~n~::::::::cokkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxdo:,,,,,,;:codxkkkkkkkkkkkkkkk~n~::::::::lxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxl::::;;;,,,,;:cloxxkkkkkkkkk~n~:::::::cokkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkoc::::::::::::;;;;;:clodxkkkk~n~:::::::lxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkdc::::::::::::::::::::;::cllod~n~::::::cokkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxl:::::::::::::::::::::::::::::~n~::::::lxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkoc:::::::::::::::::::::::::::::~n~:::::cokkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkdc::::::::::::::::::::::::::::::~n~:::::lxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxl:::::::::::::::::::::::::::::::~n~::::cokkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxoc:::::::::::::::::::::::::::::::~n~::::lxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkdc:::::::::::::::::::::::::::::::l~n~:::cdkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkdl:::::::::::::::::::::::::::::::lx~n~:::lxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxl:::::::::::::::::::::::::::::::cdk~n~::cdkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkoc::::::::::::::::::::::::::::::cdkk~n~::lxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkdc::::::::::::::::::::::::::::::cokkk~n~:cdkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxdl::::::::::::::::::::::::::::::coxkkk~n~:ldkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkocc::::::::::::::::::::::::::::::lxkkkk~n~:cldxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkdc:::::::::::::::::::::::::::::::lxkkkkk~n~:::cldxkkkkkkkkkkkkkkkkkkkkkkkkkkkxl:::::::::::::::::::::::::::::::cdkkkkkk~n~:::::cldkkkkkkkkkkkkkkkkkkkkkkkkkkoc::::::::::::::::::::::::::::::cdkkkkkkk~n~:::::::cldkkkkkkkkkkkkkkkkkkkkkkkdc::::::::::::::::::::::::::::::cokkkkkkkk~n~:::::::::cldkkkkkkkkkkkkkkkkkkkkxl::::::::::::::::::::::::::::::cokkkkkkkkk~n~:::::::::::cldkkkkkkkkkkkkkkkkkxoc::::::::::::::::::::::::::::::lxkkkkkkkkk~n~:::::::::::::coxkkkkkkkkkkkkkkkdc::::::::::::::::::::::::::::::lxkkkkkkkkkk~n~:::::::::::::::coxkkkkkkkkkkkkxl::::::::::::::::::::::::::::::ldkkkkkkkkkkk~n~:::::::::::::::::coxkkkkkkkkkxoc::::::::::::::::::::::::::::cldkkkkkkkkkkkk~n~:::::::::::::::::ccldkkkkkkkkdc::::::::::::::::::::ccclloooddxkkkkkkkkkkkkk~n~::::::::::::::::ccclodxkkkkkdl:::::::::::::cccllooddxxkkkkkkkkkkkkkkkkkkkkk~n~:::::::::::::::ccclloodxkkkxl::::ccclllooddxxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~::::::::::::::ccccloodxxkkkdllooddxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~::::::::::::::ccclloddxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~::::::::::::::cclloodxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"},
        {Order = 4, Text = "llllllllllllllllllolllllllllllllllllllllllllllllllllllllllllllllllllooodddx~n~llllllllllllllllloxxdocccclllllllllllllllllllllllllllllllllllllllllooodddxx~n~llllllllllllllllodxxxxxolc:::cclllllllllllllllllllllllllllllllllllooodddxxx~n~lllllllllllllllodxxxxxxxxxdl:;;;;:cclllllllllllllllllllllllllllllooodddxxxx~n~llllllllllllllldxxxxxxxxxxxxxdl:;,,,;;:cclllllllllllllllllllllllooodddxxxxx~n~lllllllllllllloxxxxxxxxxxxxxxxxxdlc;,''',;;:cclllllllllllllllllooodddxxxxxx~n~llllllllllllloxxxxxxxxxxxxxxxxxxxxxdolc;,''',,;;:cclllllllllllooodddxxxxxxx~n~llllllllllllodxxxxxxxxxxxxxxxxxxxxxxxxxdoc:,''''',,;:ccllllllooodddxxxxxxxx~n~lllllllllllldxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxo:;;,'''''',;:cllloooddxxxxxxxxx~n~llllllllllldxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxolllcc:;,,'''',;:cloddxxxxxxxxxx~n~lllllllllloxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxolllllllllcc:;;,'',;:codxxxxxxxxx~n~llllllllloxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxolllllllllllllllcc:;;,,,;codxxxxxx~n~llllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdlllllllllllllllllllllcc:;;;;:loxxx~n~lllllllldxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdlllllllllllllllllllllllllllcc::::co~n~llllllldxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdlllllllllllllllllllllllllllllllllccc~n~lllllloxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdolllllllllllllllllllllllllllllllllllll~n~lllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxdlllllllllllllllllllllllllllllllllllllll~n~llllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxdllllllllllllllllllllllllllllllllllllllll~n~lllldxxxxxxxxxxxxxxxxxxxxxxxxxxxxdlllllllllllllllllllllllllllllllllllllllll~n~llldxxxxxxxxxxxxxxxxxxxxxxxxxxxxdolllllllllllllllllllllllllllllllllllllllll~n~lloxxxxxxxxxxxxxxxxxxxxxxxxxxxxdollllllllllllllllllllllllllllllllllllllllll~n~llldxxxxxxxxxxxxxxxxxxxxxxxxxxdolllllllllllllllllllllllllllllllllllllllllod~n~lllldxxxxxxxxxxxxxxxxxxxxxxxxdolllllllllllllllllllllllllllllllllllllllllodx~n~llllldxxxxxxxxxxxxxxxxxxxxxxdollllllllllllllllllllllllllllllllllllllllloxxx~n~lllllldxxxxxxxxxxxxxxxxxxxxdollllllllllllllllllllllllllllllllllllllllloxxxx~n~llllllloxxxxxxxxxxxxxxxxxxxollllllllllllllllllllllllllllllllllllllllldxxxxx~n~lllllllloxxxxxxxxxxxxxxxxxollllllllllllllllllllllllllllllllllllllllodxxxxxx~n~llllllllloxxxxxxxxxxxxxxxollllllllllllllllllllllllllllllllllllllllodxxxxxxx~n~lllllllllloxxxxxxxxxxxxxolllllllllllllllllllllllllllllllllllllllloxxxxxxxxx~n~llllllllllloxxxxxxxxxxxolllllllllllllllllllllllllllllllllllllllloxxxxxxxxxx~n~lllllllllllloxxxxxxxxxolllllllllllllllllllllllllllllllllllllllldxxxxxxxxxxx~n~lllllllllllllodxxxxxxolllllllllllllllllllllllllllllllllllllllldxxxxxxxxxxxx~n~llllllllllllllodxxxxolllllllllllllllllllllllllllllllllllllllodxxxxxxxxxxxxx~n~lllllllllllllllodxxdlllllllllllllllllllllllllllllllllllllllodxxxxxxxxxxxxxx~n~lllllllllllllllloddllllllllllllllllllllllllllllllllllllllloxxxxxxxxxxxxxxxx~n~lllllllllllllllllllllllllllllllllllooooddddddddddddddddddxxxxxxxxxxxxxxxxxx~n~llllllllllllllllllllllllllllllllloooddddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~lllllllllllllllllllllllllllllllloooddddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~llllllllllllllllllllllllllllllloooddddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"},
        {Order = 5, Text = "oooooooooooooooooooooooddoccclooooooooooooooooooooooooooooooooooooooooooooo~n~oooooooooooooooooooooodddddl;;;:llooooooooooooooooooooooooooooooooooooooooo~n~ooooooooooooooooooooodddddddoc;',;:cllooooooooooooooooooooooooooooooooooooo~n~ooooooooooooooooooooddddddddddo:,''',,;:clooooooooooooooooooooooooooooooooo~n~ooooooooooooooooooodddddddddddddl:,''''',,:cloooooooooooooooooooooooooooooo~n~ooooooooooooooooooddddddddddddddddl;,''''''',;:cloooooooooooooooooooooooooo~n~oooooooooooooooooddddddddddddddddddoc:;'''''''',,;clooooooooooooooooooooooo~n~ooooooooooooooodddddddddddddddddddddddo:,'''''''''',;:clooooooooooooooooooo~n~ooooooooooooooodddddddddddddddddddddddddl:;,''''''''''',;:loooooooooooooooo~n~ooooooooooooodddddddddddddddddddddddddddooolc:;,'''''''''',;clooooooooooooo~n~oooooooooooodddddddddddddddddddddddddddoooooooolc:;,'''''''',;:looooooooooo~n~ooooooooooodddddddddddddddddddddddddooooooooooooooolc:;,''''''',:cooooooooo~n~oooooooooodddddddddddddddddddddddddoooooooooooooooooooolc:;,''''',;cloooooo~n~ooooooooodddddddddddddddddddddddddooooooooooooooooooooooooolc:;,''',;:loooo~n~oooooooodddddddddddddddddddddddddoooooooooooooooooooooooooooooolc:;,'',:coo~n~oooooooddddddddddddddddddddddddoooooooooooooooooooooooooooooooooooolc:;,,;c~n~ooooooddddddddddddddddddddddddooooooooooooooooooooooooooooooooooooooooolc:;~n~oooooddddddddddddddddddddddddoooooooooooooooooooooooooooooooooooooooooooool~n~ooooodddddddddddddddddddddddooooooooooooooooooooooooooooooooooooooooooooooo~n~ooooodddddddddddddddddddddooooooooooooooooooooooooooooooooooooooooooooooooo~n~oooooddddddddddddddddddddoooooooooooooooooooooooooooooooooooooooooooooooooo~n~ooooodddddddddddddddddddooooooooooooooooooooooooooooooooooooooooooooooooooo~n~oooooodddddddddddddddddoooooooooooooooooooooooooooooooooooooooooooooooooooo~n~ooooooddddddddddddddddooooooooooooooooooooooooooooooooooooooooooooooooooood~n~ooooooodddddddddddddooooooooooooooooooooooooooooooooooooooooooooooooooooddd~n~oooooooddddddddddddoooooooooooooooooooooooooooooooooooooooooooooooooooodddd~n~ooooooodddddddddddooooooooooooooooooooooooooooooooooooooooooooooooooodddddd~n~oooooooodddddddddoooooooooooooooooooooooooooooooooooooooooooooooooooddddddd~n~oooooooodddddddoooooooooooooooooooooooooooooooooooooooooooooooooooddddddddd~n~ooooooooddddddooooooooooooooooooooooooooooooooooooooooooooooooooddddddddddd~n~oooooooooddddoooooooooooooooooooooooooooooooooooooooooooooooooodddddddddddd~n~ooooooooodddooooooooooooooooooooooooooooooooooooooooooooooooodddddddddddddd~n~ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooddddddddddddddd~n~ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooddddddddddddddddd~n~ooooooooooooooooooooooooooooooooooooooooooooooooooooooooodddddddddddddddddd~n~ooooooooooooooooooooooooooooooooooooooooooooooooooooooodddddddddddddddddddd~n~ooooooooooooooooooooooooooooooooooooooooooooooooooooooddddddddddddddddddddd~n~ooooooooooooooooooooooooooooooooooooooooooooooooooodddddddddddddddddddddddd~n~ooooooooooooooooooooooooooooooooooooooooooooooooooddddddddddddddddddddddddd"},
        {Order = 6, Text = "dddddddddddddddddddddddddddddooc,;:lodddddddddddddddddddddddddddddddddddddd~n~dddddddddddddddddddddddddddooool:,,,;;:lodddddddddddddddddddddddddddddddddd~n~ddddddddddddddddddddddddddooooooc;,,,,,,;cloddddddddddddddddddddddddddddddd~n~dddddddddddddddddddddddddoooooool:,,,,,,,,,;clodddddddddddddddddddddddddddd~n~dddddddddddddddddddddddooooooooooc;,,,,,,,,,,,;cldddddddddddddddddddddddddd~n~ddddddddddddddddddddddoooooooooool:,,,,,,,,,,,,,,:coddddddddddddddddddddddd~n~ddddddddddddddddddddooooooooooooool;,,,,,,,,,,,,,,,;:lodddddddddddddddddddd~n~dddddddddddddddddddooooooooooooooooc,,,,,,,,,,,,,,,,,,;:loddddddddddddddddd~n~ddddddddddddddddddooooooooooooooooooc::;,,,,,,,,,,,,,,,,,;:lodddddddddddddd~n~ddddddddddddddddoooooooooooooooooodddddoc:;,,,,,,,,,,,,,,,,,;cloddddddddddd~n~dddddddddddddddoooooooooooooooooodddddddddoc:;,,,,,,,,,,,,,,,,,:ldddddddddd~n~ddddddddddddddoooooooooooooooooddddddddddddddol:;,,,,,,,,,,,,,,,,:odddddddd~n~ddddddddddddooooooooooooooooooddddddddddddddddddolc;,,,,,,,,,,,,,,;lddddddd~n~dddddddddddooooooooooooooooodddddddddddddddddddddddolc;,,,,,,,,,,,,;coddddd~n~ddddddddddooooooooooooooooodddddddddddddddddddddddddddolc:;,,,,,,,,,,:ldddd~n~ddddddddooooooooooooooooodddddddddddddddddddddddddddddddddlc:;,,,,,,,,;cddd~n~ddddddddoooooooooooooooodddddddddddddddddddddddddddddddddddddoc:;,,,,,,,:od~n~dddddddoooooooooooooooddddddddddddddddddddddddddddddddddddddddddol:;,,,,,;l~n~dddddddooooooooooooooddddddddddddddddddddddddddddddddddddddddddddddol:;,,,;~n~dddddddoooooooooooodddddddddddddddddddddddddddddddddddddddddddddddddddolc;,~n~dddddddooooooooooodddddddddddddddddddddddddddddddddddddddddddddddddddddddol~n~ddddddooooooooooddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd~n~ddddddooooooooodddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd~n~ddddddooooooodddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd~n~dddddoooooodddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd~n~dddddoooooddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd~n~dddddoooddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd~n~ddddooodddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd~n~ddddodddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd~n~ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd~n~ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd~n~ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd~n~ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd~n~ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd~n~ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddo~n~oooddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddoo~n~lloooodddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddoooo~n~ccclloooodddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddooooo~n~::cccllloooddddddddddddddddddddddddddddddddddddddddddddddddddddddddddoooooo"},
        {Order = 7, Text = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdlc:;;;;:ldxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdolc:;;;;;;;:codxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxdolllc:;;;;;;;;;:codxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxdollllc:;;;;;;;;;;;;;:ldxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxdolllllc:;;;;;;;;;;;;;;;:codxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxdollllllc:;;;;;;;;;;;;;;;;;;:codxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxddllllclllc:;;;;;;;;;;;;;;;;;;;;;cldxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxdollllllllc:;;;;;;;;;;;;;;;;;;;;;;;;:loxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxdolllllllllllc:;;;;;;;;;;;;;;;;;;;;;;;;;:codxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxddlllllllllllddddlc;;;;;;;;;;;;;;;;;;;;;;;;;;cldxxxxxxxxxx~n~xxxxxxxxxxxxxxxxdollllllllllodxxxxxdolc:;;;;;;;;;;;;;;;;;;;;;;;;:loxxxxxxxx~n~xxxxxxxxxxxxxxdollllllllllodxxxxxxxxxxxdlc:;;;;;;;;;;;;;;;;;;;;;;;:codxxxxx~n~xxxxxxxxxxxxddllllllllllodxxxxxxxxxxxxxxxdol:;;;;;;;;;;;;;;;;;;;;;;;:ldxxxx~n~xxxxxxxxxxxdolllllllllodxxxxxxxxxxxxxxxxxxxxdoc:;;;;;;;;;;;;;;;;;;;;;:oxxxx~n~xxxxxxxxxxdolllllllloddxxxxxxxxxxxxxxxxxxxxxxxdol:;;;;;;;;;;;;;;;;;;;;cdxxx~n~xxxxxxxxxdolcllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxdoc:;;;;;;;;;;;;;;;;;:lxxx~n~xxxxxxxxdolllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdlc;;;;;;;;;;;;;;;;cdxx~n~xxxxxxxdollllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdoc:;;;;;;;;;;;;;;ldx~n~xxxxxxdolllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdlc:;;;;;;;;;;;:ox~n~xxxxxdollllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdol:;;;;;;;;;;cd~n~xxxxdollllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdlc:;;;;;;;:l~n~xxxdolllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdol:;;;;;;:~n~xxdollodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdoc:;;;;~n~xdolodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxolc;;~n~doodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdoc~n~dddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~dxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~ooddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~lloooddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~cccllooddddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~:::cclllooddddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~;;:::cccllooodddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~;;;;::::cclllooodddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~;;;;;;;:::ccclloooddddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~;;;;;;;;;::::cclllooodddddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~;;;;;;;;;;;;:::cccllooodddddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~;;;;;;;;;;;;;;::::ccclloooddddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~;;;;;;;;;;;;;;;;;::::ccllloodddddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~;;;;;;;;;;;;;;;;;;;:::ccclloooddddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"},
        {Order = 8, Text = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdlc::::clodxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdolc::::::::cloxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdlc:::::::::::::cldxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdlc:::::::::::::::::cldxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdlc:::::::::::::::::::::codxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxdlc:::::::::::::::::::::::::codxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxdlc:::::::::::::::::::::::::::::codxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxdlc::::::::::::::::::::::::::::::::clodxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxdlc:ccc::::::::::::::::::::::::::::::::clodxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxdlc:cloddoc::::::::::::::::::::::::::::::::cldxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxdlc:cloxxxxxdoc::::::::::::::::::::::::::::::::cldxxxxxxx~n~xxxxxxxxxxxxxxxxdlc:cldxxxxxxxxxdocc:::::::::::::::::::::::::::::::cldxxxxx~n~dxxxxxxxxxxxxxdoc:cldxxxxxxxxxxxxxdolcc::::::::::::::::::::::::::::::codxxx~n~dddxxxxxxxxxxolccldxxxxxxxxxxxxxxxxxddolc::::::::::::::::::::::::::::::codx~n~oddddxxxxxxdlccodxxxxxxxxxxxxxxxxxxxxxxdolc:::::::::::::::::::::::::::::cox~n~oooddddxxdoccodxxxxxxxxxxxxxxxxxxxxxxxxxxdolc::::::::::::::::::::::::::::lx~n~llooodddollodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdlc:::::::::::::::::::::::::cox~n~cclllolllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdlc:::::::::::::::::::::::cox~n~cccclclodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdlc:::::::::::::::::::::cox~n~::cclodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdlc:::::::::::::::::::cdx~n~:clodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdlc:::::::::::::::::cdx~n~lodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdoc:::::::::::::::ldx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdoc:::::::::::::ldx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdoc:::::::::::ldx~n~odxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdolc:::::::coxx~n~:cldxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdolc:::::coxx~n~:::clodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdolc:::coxx~n~::::::clodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdolc:coxx~n~::::::::clodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxolldxx~n~:::::::::::cldxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdxxx~n~:::::::::::::clodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~::::::::::::::::clddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~::::::::::::::::::clodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~:::::::::::::::::::::cldxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~:::::::::::::::::::::::clodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~::::::::::::::::::::::::::cldxxxxxxxxxxxxxddddddddxxxxxxxxxxxxxxxxxxxxxxxxx~n~::::::::::::::::::::::::::::clodxxxxxddoolllloooddddxxxxxxxxxxxxxxxxxxxxxxx~n~:::::::::::::::::::::::::::::::cloollcccccccllloooddddxxxxxxxxxxxxxxxxxxxxx~n~:::::::::::::::::::::::::::::::::c::::::::cccclloooddddxxxxxxxxxxxxxxxxxxxx"},
        {Order = 9, Text = "llloooodddddddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddoollllloddxxxxxxxxxxxxxxxxxxxx~n~llllloooodddddddxxxxxxxxxxxxxxxxxxxxxxxxdddollllllllllodxxxxxxxxxxxxxxxxxxx~n~llllllooooddddddddxxxxxxxxxxxxxxxdxxxdddolllllllllllllloddxxxxxxxxxxxxxxxxx~n~lllllllloooodddddddxxxxxxxxdxxxxxxddooollllllllllllllllllodxxxxxxxxxxxxxxxx~n~llllllllloooooddddddddxxxxxxxxxdddollllllllllllllllllllllloddxxxxxxxxxxxxxx~n~llllllllllloooodddddddxxxxxxxddoolllllllllllllllllllllllllllodxxxxxxxxxxxxx~n~llllllllllllloooodddddddxxdddollllllllllllllllllllllllllllllloddxxxxxxxxxxx~n~llllllllllllllooooodddddddoollllllllllllllllllllllllllllllllllloddxxxxxxxxx~n~llllllllllllllllooooddddollllllllllllllllllllllllllllllllllllllloddxxdxxxxx~n~llllllllllllllllllooodddolllllllllllllllllllllllllllllllllllllllllodxxxxxxx~n~lllllllllllllllllloddxxxddolllllllllllllllllllllllllllllllllllllllloddxxxxx~n~lllllllllllllllloddxxxxxxxddllllllllllllllllllllllllllllllllllllllllloddxxx~n~lllllllllllllloddxxxxxxxxxxxdolllllllllllllllllllllllllllllllllllllllloddxx~n~lllllllllllloddxxxxxxxxxxxxxxddollllllllllllllllllllllllllllllllllllllllodx~n~llllllllloodxxxxxxxxxdxxxxxxxxxddolllllllllllllllllllllllllllllllllllllllod~n~llllllloddxxxxxxxxxxxxxxxxxxxxxxxdollllllllllllllllllllllllllllllllllllllll~n~llllloddxxxxxxxxxxxxxxxxxxxxxxxxxxddollllllllllllllllllllllllllllllllllllll~n~lloodddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddollllllllllllllllllllllllllllllllllll~n~oddxxdxxxxxxxxxxxxxxxxxxxxxxxxxxxxddxxddollllllllllllllllllllllllllllllllll~n~dxxddxxxxxxxxxxxxxxxxxxxxxxxxxxxxddxxxxxddolllllllllllllllllllllllllllllllo~n~xxxxxdxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddollllllllllllllllllllllllllllod~n~ddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdollllllllllllllllllllllllllldx~n~loddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddollllllllllllllllllllllllodx~n~lllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddolllllllllllllllllllllodxx~n~llllloddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdolllllllllllllllllllodxxx~n~lllllloddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddollllllllllllllllodxxxx~n~lllllllloddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddolllllllllllllodxxxxx~n~lllllllllloddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdxddollllllllllllddxxxxx~n~lllllllllllloddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdddolllllllllodxxxxxx~n~lllllllllllllloddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdoollllllodxxdxxxx~n~llllllllllllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdollllodxxxxxxxx~n~llllllllllllllllllodxxxxxxxdxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddoloddxxxxxxxx~n~llllllllllllllllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddddddddddxxxxxxx~n~llllllllllllllllllllloddxxxxxxxxxxxxxxxxxxxxxxxxxddddddooooooooddddddddxxxx~n~llllllllllllllllllllllloddxdxxxxxxxxxxxddddddddoooolllllllllooooodddddddxxx~n~llllllllllllllllllllllllloddxxxxddddddooooollllllllllllllllllloooooddddddxx~n~lllllllllllllllllllllllllllooooooollllllllllllllllllllllllllllllooooddddddd~n~llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllloooooddddd~n~llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllloooodddd"},
        {Order = 10, Text = "oooooooooooooooooodoooooooooooooooooooooooooodddddooooooooddddddddddddddddd~n~oooooooooooooooooodoooooooooooooooooooooooooooooooooooooooodddddddddddddddd~n~oooooooooooooooooodoooooooooooooooooooooooooooooooooooooooooodddddddddddddd~n~ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooddddddddddddd~n~ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooodddddddddddd~n~ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooddddddddddd~n~ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooodddddddddd~n~ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooodddddddddd~n~oooooooooooooooooodoooooooooooooooooooooooooooooooooooooooooooooodddddddddd~n~ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooodddddd~n~ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooddddd~n~ooooooooooooooodddddddooooooooooooooooooooooooooooooooooooooooooooooooodddd~n~ooooooooooodddddddddddddooooooooooooooooooooooooooooooooooooooooooooooooddd~n~oooooooodddddddddddddddddoooooooooooooooooooooooooooooooooooooooooooooooodd~n~ooooooddddddddddddddddddddooooooooooooooooooooooooooooooooooooooooooooooooo~n~oooodddddddddddddddddddddddoooooooooooooooooooooooooooooooooooooooooooooooo~n~oodddddddddddddddddddddddddoooooooooooooooooooooooooooooooooooooooooooooooo~n~dddddddddddddddddddddddddddddoooooooooooooooooooooooooooooooooooooooooooooo~n~oddddddddddddddddddddddddddddddoooooooooooooooooooooooooooooooooooooooooooo~n~ooodddddddddddddddddddddddddddddooooooooooooooooooooooooooooooooooooooooooo~n~oooodddddddddddddddddddddddddddddoooooooooooooooooooooooooooooodooooooooooo~n~oooooodddddddddddddddddddddddddddddoooooooooooooooooooooooooooooooooooooooo~n~ooooooodddddddddddddddddddddddddddddooooooooooooooooooooooooooooooooooooooo~n~oooooooodddddddddddddddddddddddddddddddoooooooooooooooooooooooooooooooooooo~n~ooooooooooddddddddddddddddddddddddddddddooooooooooooooooooooooooooooooooodd~n~oooooooooooodddddddddddddddddddddddddddddoooooooooooooooooooooooooooooooodd~n~oooooooooooooddddddddddddddddddddddddddddddoooooooooooooooooooooooooooooood~n~ooooooooooooooddddddddddddddddddddddddddddddooooooooooooooooooooooooooooooo~n~ooooooooooooooooooooddddddddddddddddddddddddooooooooooooooooooooooooooooooo~n~ooooooooooooooooooooddddddddddddddddddddddddddooooooooooooooooooooooooooooo~n~ooooooooooooooooooodddddddddddddddddddddddddddddooooooooooooooooooooooooooo~n~ooooooooooooooooooooddddddddddddddddddddddddddddooooooooooooooooooooooooooo~n~ooooooooooooooooooooodddddddddddddddddddddddddddddooooooooooooooooooooooooo~n~oooooooooooooooooooooooddddddddddddddddddddddddddddoooooooooooooooooooooooo~n~oooooooooooooooooooooooodddddddddddddddddddddddddddddoooooooooooooooooooooo~n~ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo~n~ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo~n~ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo~n~ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo"},
        {Order = 11, Text = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdddddooooo~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddddoooo~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddddooo~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddddoo~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddddo~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdddd~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddd~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdd~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxd~n~xxxxxxxxxxxxddodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxdoollodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxddoolllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxddolllllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxdoollllllllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxdolllllllllllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxdollllllllllllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxdollllllllllllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxdollllllllllllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxdollllllllllllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxdollllllllllllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxdollllllllllllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxdollllllllllllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxdollllllllllllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxdollllllllllllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxdoolllllllllllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxdoolllllllllllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxdoolllllllllllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxdoolllllllllllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxddolllllllllllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxdolllllllllllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxdolllllllllllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxdollllllllllllllloddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxdollllllllllllllloodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxddoooollllllllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxddddoooolllllllodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddddooooolodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdddddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"},
        {Order = 12, Text = "kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkOkkkk~n~kkkkkkkkkkkkkkkOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkdoxOOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkxocclxOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkdlc:ccokOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkoc:cc:cdkOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkxlc:cc:lxOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkdl:cc:cokOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkdc:cc:cokOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkoc:cc:cdkOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkxlc:c::lxOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkdlc::ccokOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkdc:c::cdkOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkoc::::ldkOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkxlc::cclxOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkdlc::ccokOkOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkdc:cc:cdkOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkxocc::clxkOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkxlc:::clxOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkdl::cccokOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkdc:cc:cdkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkxocccc:lxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkxlc:::coxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkdlc:c:cokkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkdlc:::cdkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkdlc:clxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkxdlccoxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkxoccokkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkxoldkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkddxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"},
        {Order = 13, Text = "000000000000000000000000000000000000000000000000000000000000000000000000000~n~000000000000000000000000000000000000000000000000000000000000000000000000000~n~000000000000000000000000000000000000000000000000000000000000000000000000000~n~000000000000000000000000000000000000000000000000000000000000000000000000000~n~000000000000000000000000000000000000000000000000000000000000000000000000000~n~000000000000000000000000000000000000000000000000000000000000000000000000000~n~000000000000000000000000000000000000000000000000000000000000000000000000000~n~000000000000000000000KKKKKKKKKKKK000000000000000000000000000000000000000000~n~0000000000KKKKKKKKKKKKKKKKKKKKKK0000000000000000000000000000000000000000000~n~00000000KKXKKKKKKKKKKKKKKKKKKKKKK000000000000000000000000000000000000000000~n~00000000KKKKKKKKKKKKKKKKKKKKKKK00000000000000000000000000000000000000000000~n~000000000KKKKKKKKKKKKKKKKKKKKKK00000000000000000000000000000000000000000000~n~000000000KKKKKKKKKKKKKKKKKKKKKK00000000000000000000000000000000OOOOO0000000~n~0000000000KKKKKKKKKKKKKKKKKKKK000000000000000000000000000000000OOOOO0000000~n~0000000000KKKKKKKKKKKKKKKKKK00000000000000000000000000000000000OOOOOO000000~n~00000000000KKKKKKKKKKKKKKKK00000000000000000000000000000000000OOOO0OO000000~n~000000000000KKKKKKKKKKKKKK000000000000000000000000000000000000OOOOOOOO00000~n~000000000000KKKKKKKKKKKK00000000000000000000000000000000000000OO00OOOO00000~n~0000000000000KKKKKKKKKK00000000000000000000000000000000000000OOOOOOOOOO0000~n~0000000000000KKKKKKKK000000000000000000000000000000000000000OOOOOOOOOOO0000~n~00000000000000KKKKK00000000000000000000000000000000000000000OOOOOOOOOOO0000~n~000000000000000KKK00000000000000000000000000000000000000000OOOOOOOOOOOOO000~n~0000000000000000000000000000000000000000000000000000000000OOOOOOOOOOOOOO000~n~000000000000000000000000000000000000000000000000000000000OOOOOOOOOOOOOOOO00~n~00000000000000000000000000000000000000000000000000000OOOOOOOOOOOOOOOOOOOO00~n~00000000000000000000000000000000000000000000000000000OOOOOOOOOOOOOOOOOOOOO0~n~0000000000000000000000000000000000000000000000000OOOOOOOOOOOOOOOOOOOOOOOOO0~n~000000000000000000000000000000000000000000000000OOOOOOOOOOOOOOOOOOOOOOOOOO0~n~00000000000000000000000000000000000000000000000OOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~000000000000000000000000000000000000000000000OOOOOOOOOOOOOOOOOOOOOOOOOOO000~n~00000000000000000000000000000000000000000000OOOOOOOOOOOOOOOOOOOOO0000000000~n~00000000000000000000000000000000000000000OOOOOOOOOOOOOOOOO0000000000KKKKKKK~n~0000000000000000000000000000000000000000OOOOOOOOOOO00000000000000KKKKKKKKKK~n~000000000000000000000000000000000000OOOOOOOO00000000000000000000KKKKKKKKKKK~n~0000000000000000000000000000000000000000000000000000000000000000KKKKKKKKKKK~n~0000000000000000000000000000000000000000000000000000000000000000000KKKKKKKK~n~00000000000000000000000000000000000000000000000000000000000000KK000KKKKKKKK~n~00000000000000000000000000000000000000000000000000000000000000KK000KKKKKKKK~n~00000000000000000000000000000000000000000000000000000000000000KKKKKKKKKKKKK"},
        {Order = 14, Text = "KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKXXXXXXXXXXXXXXXXXXXXXKKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXKKKKKKKKKKKKKKKKK~n~KKKKKKXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXKKKKKKKKKKKKKKKKKKK~n~KKKKKXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKKXXXXXXXXXXXXXXXXXXXXXXXXKXXKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKKXXXKKXXXXXXXXXXXXXXXXKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKKKXKKKKKXXKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK000KKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK000000KKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK000000000KKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK00000000000000KKXKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK000000000000KKXKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK000000000000000000000000KXKXXX~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK000000000000000000000000000000000KXXXXX~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKK00000000000000000000000000000000000000000KXXXXX~n~KKKKKKKKKKKKKK0000000000000000000000000000000000000000000000000000000KXXXXX~n~KKKKKKKKKKKKKK0000000000000000000000000000000000000000000000000000000KKXXXX~n~KKKKKKKKKKKKKK0000000000000000000000000000000000000000000000000000000KKXXXX~n~KKKKKKKKKKKKKK000000000000000000000000000000000000000000000000000000KKKXXXX~n~KKKKKKKKKKKKKK0000000000000000000000000000000000000KKKKKKKKKKKKKKXXXXXXXXXX~n~KKKKKKKKKKKKKKK0000000000000000KKKKKKKKKKKKKKKKKXXXXXXXXXXXXXXXXXXXXXXXXXXX~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX~n~KKKKKKKKKKKKKKKKKKXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX~n~KKKKKKKKKKXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX~n~KKKKKKKKKXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"},
        {Order = 15, Text = "000000000000000000000000000000000000000000000000000000000000000000000000000~n~000000000000000000000000000000000000000000000000000000000000000000000000000~n~000000000000000000000000000000000000000000000000000000000000000000000000000~n~000000000000000000000000000000000000000000000000000000000000000000000000000~n~000000000000000000000000000000000000000000000000000000000000000000000000000~n~00000000000000K0000000000000000000OOOOOOOOOkkkkkkkxxxxxxxxddddxO00000000000~n~0000000000K0000Okkxddoolllllllcccccccc::::::::;;;;;;;;;;;;;;;;lk00000000000~n~00000OOkkxxdoolccc:::::ccccccccllllllloooooooodddddddxxxxxxxxkk000000000000~n~00000OOkkkkkkkkkOOOOOO000000000KKKKKKKKKKKKKXXXXXXXXXXXXXXXXXXKK00000000000~n~KKK00KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKXXXXXXXXXXXXXXXXKK00000000000~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKXKK00000000000~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK00000000000~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK00000000000~n~KKKKKK000000KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK00000000000~n~KKKKK0000000000KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK00000000000~n~KKKKK0000000000000000KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK000~n~KKKKK000000000000000000KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKK000000000000000000000KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKK0000000000000000000000KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKK000000000000000000000000000000KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK0KKK~n~KKKKKK00000000000000000000000000000000000000KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKK000000000000000000000000000000000000000000000000000000KKKKKKKKKKKKKK~n~KKKKKKK00000000000000000000000000000000000000000000000000000000KKKKKKKKKKKK~n~KKKKKKK00000000000000000000000000000000000000000000000000000000KKKKKKKKKKKK~n~KKKKKKK00000000000000000000000000000000000000000000000000000000KKKKKKKKKKKK~n~KKKKKKKK0000000000000000000000000000000000000000000000000000000KKKKKKKKKKKK~n~KKKKKKKK0000000000000000000000000000000000000000000000000000000KKKKKKKKKKKK~n~KKKKKKKK0000000000000000000000000000000000000000000000000000000KKKKKKKKKKKK~n~KKKKKKKK0000000000000000000000000000000000000000000000000000000KKKKKKKKKKKK~n~KKKKKKKKK000000000000000000000000000000000000000000000000000000KKKKKKKKKKKK~n~KKKKKKKKK000000000000000000000000000000000000000000000000000000KKKKKKKKKKKK~n~KKKKKKKKK000000000000000000000000000000000000000000000000000000KKKKKKKKKKKK~n~KKKKKKKKK000000000000000000000000000000000000000000000000000000KKKKKKKKKKKK~n~KKKKKKKKKK00000000000000000000000000000000000000000000000000000KKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKK0000000000000000000000000000000000KKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK"},
        {Order = 16, Text = "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOkkkkkkkkkkkkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~OOOOOOOOOOOOOOOOOkkxxdoollcc:cccccccccclllllllooooooooddddddddxxxxxxkOOOOOO~n~OOOOOOOOOkkxxdoolcc::::::::::::::::::::::::::::::::::::::::::::::;,;dOOOOOO~n~OOOkxddollc:::::::::::::::::::::::::::::::::::::::::::::::::::;,'..,dOOOOOO~n~OOOkkxxxxxddddddoooolllllcccccc::::::::::::::::::::::::::::;;,.....;xOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOkkkkkxxxxxxddddddooooollllccccc:;'.......:kOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO000OOO000OOOOOOOOOkkko'........ckOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO000000000000Oo'........lOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO0000000000Ol........'oOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO00000000Oc........,dOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO00k:........;xOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO0k:........:kOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO0x;........cOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOx,........lOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOd,.......'oOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo'.......,dOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo'.......;xOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO0Ol........:kOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO0Oc........cOOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOk:.......'oOOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOk:.......'dOOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOx;.......;xOOOOOOOOO~n~00000OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOx,......'oOOOOOOOOOO~n~00000OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOd,.....'lOOOOOOOOOOO~n~00000OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo'.....ckOOOOOOOOOOO~n~00000OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOl'....:kOOOOOOOOOOOO~n~00000OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOl....;xOOOOOOOOOOOOO~n~000000OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkc...,dOOOOOOOOOOOOOO~n~0OOO0000000OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOk:..,oOOOOOOOOOOOOOOO~n~0OOOO00000000000OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOx:.'lOOOOOOOOOOOOOOOO~n~00OOOOOOO00000000OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOx;.lkOOOOOOOOOOOOOOOO~n~00OOOOOOOO0000000000OOOOO0OOO0000OOOOOOOOOOOOOOOOOOOOOd;ckOOOOOOOOOOOOOOOOO~n~OOOOOOOOOOOOOOO000000OOOOOOOOO00000000000OOOOOOOOOOOOOdlxOOOOOOOOOOOOOOOOOO~n~OOOOOOOOOOOOOOOO0000000OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkkOOOOOOOOOOOOOOOOOOO~n~OOOOOOOOOOOOOOO0000000000OOOOOOOOOOOOOOOOOOOOOOOO00OOO0OOOOOOOOOOOOOOOOOOOO"},
        {Order = 17, Text = "'',,;:cloddxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~'',,;:cloddxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~'',,;:clodxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~'',,;:clodxxkkkkkkkkkkkkkkkkxxxdddddxxxxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~',,;;:clodxxkkkkkkkkkxxdddoollccccccccclllloooodddxxxxkkkkkkkkkkkkkkkkkkkkk~n~',,;;:clodxxxxxxddoollcccccccccccccccccccccccccccccclllooooddddxxxxkkkkkkkk~n~',,;;:cllooolllccccccccccccccccccccccccccccccccccccccccccccccccccllloooodxk~n~';clllccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc::;,,lxk~n~';okxxxdddoolllccccccccccccccccccccccccccccccccccccccccccccccccc::;,,'',okk~n~';okkkkkkkkkkxxdddooollcccccccccccccccccccccccccccccccccccccc:;,,'''''':dkk~n~,,lxkkkkkkkkkkkkkkkkkxxxdddoollcccccccccccccccccccccccccc::;,,'''''''',cxkk~n~,,cxkkkkkkkkkkkkkkkkkkkkkkkkkkxxxddooolllccccccccccccc:;;,'''''''''''',lkkk~n~,,:dkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxxxddooollcc:;,,''''''''''''''';dkkk~n~,,;okkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxd:'''''''''''''''''''cxkkk~n~,,;okkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkd;'''''''''''''''''',lkkkk~n~,,;lxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkko;'''''''''''''''''';okkkk~n~,,;cxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkl,'''''''''''''''''':dkkkk~n~,,;cdkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxl,''''''''''''''''',lxkkkk~n~,,;:okkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxc,''''''''''''''''';okkkkk~n~,;;:oxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkx:'''''''''''''''''':dkkkkk~n~,;;:oxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkd:''''''''''''''''',cxkkkkk~n~,;;:lxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkd;''''''''''''''''',lkkkkkk~n~,;:cldkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkko;''''''''''''''''';dkkkkkk~n~,;:cldkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkko,'''''''''''''''''cxkkkkkk~n~,;:cldkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkl,'''''''''''''''',lkkkkkkk~n~;;:cldxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxc,'''''''''''''''';okkkkkkk~n~;;:cloxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkx:'''''''''''''''',cxkkkkkkk~n~;;:cloxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkd:'''''''''''''',:oxkkkkkkkk~n~;::cloxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkd;''''''''''''';lxkkkkkkkkkk~n~;:clodxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkko;''''''''''',:dkkkkkkkkkkkk~n~;:cloddxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkko,''''''''',;lxkkkkkkkkkkkkk~n~;:clodxxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkl,'''''''',cdkkkkkkkkkkkkkkk~n~;:clodxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxc,'''''',:okkkkkkkkkkkkkkkkk~n~;:clodxxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxc'''''';lxkkkkkkkkkkkkkkkkkk~n~;:cloddxxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkd:'''',cdkkkkkkkkkkkkkkkkkkkk~n~::cllodddxxxxxxxxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkd;'',:oxkkkkkkkkkkkkkkkkkkkkk~n~::ccllooodddddddxxxxxxxxxxkkkkkkkkkkkkkkkkkkkko;';cxkkkkkkkkkkkkkkkkkkkkkkk~n~:ccccllllloooooooddddddddxxxxxxxxxxkkkkkkkkkkko;:okkkkkkkkkkkkkkkkkkkkkkkkk~n~cccccccllllllllloooooooodddddddxxxxxxxxxxxxkkkoldkkkkkkkkkkkkkkkkkkkkkkkkkk"},
        {Order = 18, Text = ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;::ccllloodddddddddddddddddddddddddddddddddd~n~;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;::ccllloodddddddddddddddddddddddddddddddddd~n~;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;::ccllloooodddddddddddddddddddddddddddddddd~n~;;;;;;;;;;;;;;;;;;;;;;;;;;::::ccclllllllllllooooddddddddddddddddddddddddddd~n~;;;;;;;;;;;;;;;;;;::::ccccllllllllllllllllllllllllloooodddddddddddddddddddd~n~;;;;;;;;;;;:::ccccllllllllllllllllllllllllllllllllllllllloooooddddddddddddd~n~;;;::::cccllllllllllllllllllllllllllllllllllllllllllllllllllllllooooddddddd~n~;;cooollllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllloooo~n~;;cddddooolllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllcc::~n~;;:oddddddddoolllllllllllllllllllllllllllllllllllllllllllllllllllllcc::;;;;~n~;;:lddddddddddddoollllllllllllllllllllllllllllllllllllllllllllccc::;;;;;;;:~n~;;;cddddddddddddddddoollllllllllllllllllllllllllllllllllllcc::;;;;;;;;;;;;l~n~;;;:odddddddddddddddddddoollllllllllllllllllllllllllllcc::;;;;;;;;;;;;;;;:o~n~;;;:ldddddddddddddddddddddddooolllllllllllllllllllcc::;;;;;;;;;;;;;;;;;;;cd~n~;;;;cdddddddddddddddddddddddddddooolllllllllllcc::;;;;;;;;;;;;;;;;;;;;;;:ld~n~;;;;coddddddddddddddddddddddddddddddoooollc:::;;;;;;;;;;;;;;;;;;;;;;;;;;cod~n~;;;;:oddddddddddddddddddddddddddddddddddl:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ldd~n~;;;;;lddddddddddddddddddddddddddddddddddc;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;:odd~n~;;;;;cdddddddddddddddddddddddddddddddxddc;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;cddd~n~;;;;;:odddddddddddddddddddddddddddddddddc;;;;;;;;;;;;;;;;;;;;;;;;;;;;;:lddd~n~;;;;;:lddddddddddddddddddddddddddddddddoc;;;;;;;;;;;;;;;;;;;;;;;;;;;;;:oddd~n~;;;;;;cddddddddddddddddddddddddddddddddoc;;;;;;;;;;;;;;;;;;;;;;;;;;;;;cdddd~n~;;;;;;codddddddddddddddddddddddddddddddo:;;;;;;;;;;;;;;;;;;;;;;;;;;;;:odddd~n~;;;;;;:ldddddddddddddddddddddddddddddddo:;;;;;;;;;;;;;;;;;;;;;;;;;;;;cddddd~n~;;;;;;;ldddddddddddddddddddddddddddddddo:;;;;;;;;;;;;;;;;;;;;;;;;;;;:lddddd~n~;;;;;;;coddddddddddddddddddddddddddddddo:;;;;;;;;;;;;;;;;;;;;;;;;;;;:oddddd~n~;;;;;;;:oddddddddddddddddddddddddddddddo:;;;;;;;;;;;;;;;;;;;;;;;;;;;cdddddd~n~;;;;;;;;:loddddddddddddddddddddddddddddl:;;;;;;;;;;;;;;;;;;;;;;;;;:codddddd~n~;;;;;;;;;;:loddddddddddddddddddddddddddl:;;;;;;;;;;;;;;;;;;;;;;;:codddddddd~n~;;;;;;;;;;;::coddddddddddddddddddddddddl:;;;;;;;;;;;;;;;;;;;;:clodddddddddd~n~;;;;;;:::::::ccloddddddddddddddddddddddl;;;;;;;;;;;;;;;;;;;:clddddddddddddd~n~;;:::::::ccccccclloddddddddddddddddddddl;;;;;;;;;;;;;;;;;:clodddddddddddddd~n~:::::ccccccccllllllloodddddddddddddddddl;;;;;;;;;;;;;;;:clooooooooddddddddd~n~:ccccccclllllllllllllloodddddddddddddddc;;;;;;;;;;;;:cllllllooooooooooddddd~n~cccclllllllllllllllllllllooddddddddddddc;;;;;;;;;;:cllllllllllllooooooooooo~n~lllllllllllllllllllllllllllooddddddddddc;;;;;;;::cllllllllllllllllllllooooo~n~lllllllllllllllllllllllllllllloddddddddc;;;;;:clllllllllllllllllllllllllloo~n~llllllllllllllllllllllllllllllllooddddoc;;::cllllllllllllllllllllllllllllll~n~lllllllllllllllllllllllllllllllllloddxoc;:cllllllllllllllllllllllllllllllll"},
        {Order = 19, Text = ":::::::::::::::::::::::ccc:::cc:::c::::::::::::c::ccc:::c:::::::cccccclllll~n~:::::::::::::::::::::::cccccc:::::ccccccccllllccc::ccc::::::::::cccccclllll~n~:::::::::::::::::::::::cc::ccccccclllloooooooooollccc:::::::::::cccccclllll~n~cc::::cc:cccc:::c::::ccccclllloooooooooooooooooooooollccc:::::::cccccclllll~n~:c::c::c::::cccccclllloooooooooooooooooooooooooooooooooollccc:::cccccclllll~n~:c::cccccccllloooooooooooooooooooooooooooooooooooooooooooooollcccccccclllll~n~:c:clllooooooooooooooooooooooooooooooooooooooooooooooooooooooooolllccclllll~n~c:ccloooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooollllll~n~:::cllloooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooool~n~:::cclllloooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo~n~::cccllllllooooooooooooooooooooooooooooooooooooooooooooooooooooooooooolllcc~n~::::ccllllllloooooooooooooooooooooooooooooooooooooooooooooooooooolllccc:::c~n~c::ccclllllllllooooooooooooooooooooooooooooooooooooooooooooolllcccc::::::::~n~:ccc:cllllllllllloooooooooooooooooooooooooooooooooooooolllccccc:::::::::cc:~n~::cc:ccllllllllllllooooooooooooooooooooooooooooooolllccc:::ccccc:ccc:::::cc~n~c:::::clllllllllllllloooooooooooooooooooooooolllcccc::::::ccccc:::cc:::c:cc~n~:::::cccllllllllllllllloooooooooooooooooollccccc:::::::::::::::::::::::::cl~n~:::::ccclllllllllllllllllooooooooolllcccccc::::cc:::::::::::::::::::::::ccl~n~:::::::ccllllllllllllllllllooollcccc::::::cccc:cc:::::::::::::::::::::::clo~n~:::::::ccllllllllllllllllllllcc::::cccc::cc:ccc:::::::::::::::::cccc::::clo~n~::::::::cllllllllllllllllllllc::::::::::::::::::::::::::::::::::cccc:c:cloo~n~::::::::cclllllllllllllllllllc::::::::::::::::::::::::::::::::::cccccc:cloo~n~:::::::::clllllllllllllllllllcc::::::::::::::::::::::::::::::::::cccccccooo~n~:::::::c:ccllllllllllllllllllcc::::::::::::::::::::::::::::::::::cccccclooo~n~:::::::c::clllllllllllllllllllc::::::::::::::::::::::::::::::::::cccc:coooo~n~:::::::c::ccllllllllllllllllllc::::::::::::::::::::::::::::::::::cc:ccloooo~n~cc::ccccccccclllllllllllllllllcc::::::::::::::::::::::::::::::::::c:ccloooo~n~ccccccccccccllllllllllllllllllc::::::::::::::::::::::::::::ccccc:cccclooooo~n~ccccccclllllllllllllllllllllllc:::::::::::::::::::::::::c:::::ccccccloooooo~n~ccllllllllloooooooolllllllllllcc::::::::::::::::::::::::::cc::ccclloooooooo~n~lllllloooooooooooooollllllllllcc::::::::::::::::::::::::ccccccloooooooooooo~n~loooooooooooooooooooollllllllllc::::::::::::::::c:::ccccccllooooooooooooooo~n~ooooooooooooooooooooooollllllllc:::::::::::::::c::::ccclloooooooooooooooooo~n~oooooooooooooooooooooooolllllllc::::::::cc:::cc::cccloooooooooooooooooooooo~n~oooooooooooooooooooooooooolllllc::::::::::ccccccllooooooooooooooooooooooooo~n~ooooooooooooooooooooooooooollllcc:c:::cc:cccclloooooooooooooooooooooooooooo~n~ooooooooooooooooooooooooooooollcc:::::ccclloooooooooooooooooooooooooooooooo~n~oooooooooooooooooooooooooooooollc:ccccllooooooooooooooooooooooooooooooooooo~n~ooooooooooooooooooooooooooooooolccclooooooooooooooooooooooooooooooooooooooo"},
        {Order = 20, Text = "ccccccccccccccccccccccccccccccccccccccccccclllloollcccccccccccccccccccccccc~n~cccccccccccccccccccccccccccccccccclllllloooddddddddollccccccccccccccccccccc~n~cccccccccccccccccccccccccccllllooooddddddxxxxxxxxxxddolllcccccccccccccccccc~n~cccccccccccccccccccclllloooddddxxxxxxxxxxxxxxxxxxxxxxxddollcccccccccccccccc~n~ccccccccccccllllooooddddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddollcccccccccccccc~n~cccccllllooodddddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdddolcccccccccccc~n~ccccloddddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddxddollccccccccc~n~cccccloddxxxxxxxdxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdxxxxxxddolccccccc~n~cccccclodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddollcccc~n~ccccccccdxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddolcc~n~ccccccccldddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddol~n~cccccccc:ldxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdddo~n~ccccccccc:ldxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddxxxxxddddooolll~n~ccccccccc::ldxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddddooolllcccccc~n~cccccccccc::ldxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddddooolllcccccccccccl~n~ccccccccccc::odxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddddooolllcccccccccccccccccl~n~ccccccccccc::codxxxxdxxdxxxxddxxxxxxxxxxxxddddoolllcccccccccccccccccccccclo~n~cccccccccccc::codxxxxxxxxxxxxxxxxxxxddddooolllcccccccccccccccccccccccccccld~n~cccccccccccc:::codxxxxxxxxxxxddddooollllcccccccccccccccccccccccccccccccccod~n~ccccccccccccc:::codxxxxddddooollllcccccccccccccccccccccccccccccccccccccclod~n~cccccccccccccc:::coddooollllccccccccccccccccccccccccccccccccccccccccccccldx~n~cccccccccccccc::::clllccccccccccccccccccccccccccccccccccccccccccccccccccodx~n~ccccccccccllllc::::cccccccccccccccccccccccccccccccccccccccccccccccccccclodd~n~cccllllllllllllc::::cccccccccccccccccccccccccccccccccccccccccccccccccccldxx~n~llllllllllooooooc:::cccccccccccccccccccccccccccccccccccccccccccccccccclodxx~n~llllooooooooddddoc:::ccccccccccccccccccccccccccccccccccccccccccccccccclodxx~n~oooooodddddddddddoc::cccccccccccccccccccccccccccccccccccccccccccccccccldxxx~n~ddddddddddddddddddoc::ccccccccccccccccccccccccccccccccccccccccccccccclodxxx~n~dddddddddddxxxxxxxdl::ccccccccccccccccccccccccccccccccccccccccccccccclodxxx~n~dddddxxxxxxxxxxxdxxdl::ccccccccccccccccccccccccccccccccccccccccccclllodxxxx~n~xxxxxxxxxxxxxxxxdxxddc:ccccccccccccccccccccccccccccccccccccccclloodddxxxxxx~n~xxxxxxxxxxxxxxxxxdxxdoc:cccccccccccccccccccccccccccccccccllooodddxxxxxxxxxx~n~xxxxxxxxxxxxxxxdxxxxxdocccccccccccccccccccccccccccccllloodddxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxdxxxxxxdoccccccccccccccccccccccccllooddddxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxdlccccccccccccccccccllloodddxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxdlccccccccccccllloodddxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxolccccccllloooddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxdlclloodddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxdooddxxxdxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"},
        {Order = 21, Text = "lllllllllllllllllllllllllllllllllllllllllllloodddxxxxolllllllllllllllllllll~n~llllllllllllllllllllllllllllllllllloooodddxxxxxxxxkxxxdolllllllllllllllllll~n~llllllllllllllllllllllllllllooodddxxxxxxxxxxxxxxxxxxxxxxollllllllllllllllll~n~llllllllllllllllllllloodddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdlllllllllllllllll~n~lllllllllllllooodddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdolllllllllllllll~n~lllllllodddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxollllllllllllll~n~lllllloxkxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdollllllllllll~n~llllllldxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdolllllllllll~n~llllllldxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdllllllllll~n~llllllldxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdollllllll~n~llllllloxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxollllllo~n~llllllloxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdoooooo~n~llllllloxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddddd~n~lllllllldxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~lllllllldxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddooodxx~n~lllllllldxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddooollllllodxx~n~lllllllloxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdddoollllllllllllloxxx~n~lllllllloxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdddoolllllllllllllllllllloxxx~n~lllllllloxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdddoollllllllllllllllllllllllllloxxx~n~llllllllodxxxxxxxxxxxxxxxxxxxxxdddooolllllllllllllllllllllllllllllllllldxxx~n~llllooooodxxxxxxxxxxxxxxdddooollllllllllllllllllllllllllllllllllllllllldxxx~n~oooooddddxxxxxxxxdddooolllllllllllllllllllllllllllllllllllllllllllllllldxxx~n~ddddddddxxxddooollllllllllllllllllllllllllllllllllllllllllllllllllllllodxxx~n~xxxxxxxxxxollllllllllllllllllllllllllllllllllllllllllllllllllllllllllloxxxx~n~xxxxxxxxxxxdlllllllllllllllllllllllllllllllllllllllllllllllllllllllllloxxxx~n~xxxxxxxxxxxxdllllllllllllllllllllllllllllllllllllllllllllllllllllllllloxxxx~n~xxxxxxxxxxxxxdlllllllllllllllllllllllllllllllllllllllllllllllllllllllldxxxx~n~xxxxxxxxxxxxxxdllllllllllllllllllllllllllllllllllllllllllllllllllllllldxxxx~n~xxxxxxxxxxxxkxxdlllllllllllllllllllllllllllllllllllllllllllllllllllllldxxxx~n~xxxxxxxxxxxxxxxxdolllllllllllllllllllllllllllllllllllllllllllllllllllldxxxx~n~xxxxxxxxxxxxxxxxxdolllllllllllllllllllllllllllllllllllllllllllllllloodxxxxx~n~xxxxxxxxxxxxxxxxxxdollllllllllllllllllllllllllllllllllllllllloodddxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxollllllllllllllllllllllllllllllllloooddxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxolllllllllllllllllllllllllloodddxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxolllllllllllllllllloooddxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxollllllllllooddddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxdlloooddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"},
        {Order = 22, Text = "llllllllllllllllllllllllllllllllccclllllllooddxxkkkkkkkdlllllcllcllllllllll~n~lllllllllllllllllclllllllllllllllloodddxxkkkkkkkkkkkkkkxolllcllclllllllllll~n~lllllllllllllllccllllllllloooddxxxkkkkkkkkkkkkkkkkkkkkkkdlllllcllllllllllll~n~llllllllllccllclllloooddxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxollcllllllllllllll~n~lllllllclllloodddxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxllllcclllllllllll~n~llllllllodxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkdlcllclllllllllll~n~lllllllldkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxolclllllllllllll~n~lllcclllxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkdlllllllllllllll~n~lcccclloxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxolllllloooooooo~n~lccllcldkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxoooooodddddddd~n~lclcccldkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxdddddxxxxxxxx~n~cclclcoxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxxxxxxxkkkkkk~n~llllllokkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~lclllldkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~llllloxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~llllodkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~oooodxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~ddddxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxxxdddooodkkkkkkkkk~n~xxxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxxxxddooolllllllccoxkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxxxdddoolllllllllllllllllclxkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkxxxdddoooollllccclllllllllllllllllllldkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkxxxdddooollllcccllllcclllllcclllllllllllllllllokkkkkkkk~n~kkkkkkkkkkkkxxddddoolllllcccclcllcccclllllllcccllllllllllllllllllloxkkkkkkk~n~kkkkxxdddoollllllllllllllllccclllllllllllclllccllllllllllllllllllcldkkkkkkk~n~kkkxdllclcclllllllllllllllllllllllllllllllllllllllllllllllllllllllldkkkkkkk~n~kkkkkxollllccllllllllllllllllllllllllllllllllllllllllllllllllllllcloxkkkkkk~n~kkkkkkkdolcllcclllllllllllllllllllllllllllllllllllllllllllllllllclclxkkkkkk~n~kkkkkkkkxdolclllllcllllllllllllllllllllllllllllllllllllllllllllllllldkkkkkk~n~kkkkkkkkkkxdllclllclllllllllllllllllllllllllllllllllllllllllllllllclokkkkkk~n~kkkkkkkkkkkkxollccllcllllllllllllllllllllllllllllllllllllllllllllllloxkkkkk~n~kkkkkkkkkkkkkkxolclllllclllllllllllllllllllllllllllllllllllllllllllclxkkkkk~n~kkkkkkkkkkkkkkkkdolclllllclllclllllllllllllcccllllllcclllllccllllloooxkkkkk~n~kkkkkkkkkkkkkkkkkkdolllllcclllllllcccclllllllcclccllllloooodddxxxxkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkxdlllllcccllllcccccclllllloooddddxxxkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkxdllccclllllloooddddxxxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkxdoodddxxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"},
        {Order = 23, Text = "cccccccccccccccccccccccccccccccccccccccllooddxkkkkkkkOx:;:ccccccccccccccccc~n~cccccccccccccccccccccccccccccccllooddxxxkkkkOkkkkkkkkOx:';ccccccccccccccccc~n~ccccccccccccccccccccccccllooddxxkkkOkkkkkOOOkkkkkkOkkkx:.':cccccccccccccccc~n~cccccccccccccccccllooddxxkkkkkkkkOkkkkkkkkkkkkkkkkkkOOx:..,cccccccccccccccc~n~ccccccccccclooddxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkc..':cclclllllllllll~n~ccccccccccoxkkkkOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkc...,clloooooooooodd~n~ccccccccclxkkkkkOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkOkc....:odddddddddxxxx~n~cccccccccdkkkkOkkkOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkc....'lxxxxxxxxkkkkk~n~ccccccccokkkkkOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkl.....;dkkkkkkkkkkkk~n~llllllloxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkl......ckkkkkkkkkkkk~n~oooooooxkkkOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkl'.....,okkkkkkkkkkk~n~dddddxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkl'......;dkkkkkkkkkk~n~xxxxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkko'.......ckkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkko'.......'okkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkOkkko'........:xOkkOkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkOkkko,........;dOkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkOkkkko,........,dkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkOd,........'okkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkOkkOd,.........lkkkOkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkOkkkkkkkkkkkkkkkkkkkkkkkkkkkd,.........ckkkOkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkOOkkkkkkkkkkkkkkkkxxxdddooool,.........:xkkkkkkk~n~kkkkkkkkOkkkkkkkkkkkkkkOOkkkkkkxxxdddddooollllcccccccccc:,........;dOOkkkkk~n~kkkkkkkOOkkkkkkkkkxxxxdddooollllccccccccccccccccccccccccc:,.......,dOkkkkkk~n~kkkkkkxxxdddoooolllccccccccccccccccccccccccccccccccccccccc:,......'okkkkkkk~n~doolllccccccccccccccccccccccccccccccccccccccccccccccccccccc:,......lkkkkkkk~n~kdolcccccccccccccccccccccccccccccccccccccccccccccccccccccccc:,.....ckkkkkkk~n~Okkxdoccccccccccccccccccccccccccccccccccccccccccccccccccccccc:,....:xOkkkkk~n~kkkkkkxolccccccccccccccccccccccccccccccccccccccccccccccccccccc:,...;dOkkkkk~n~kkkkkkkkkdolccccccccccccccccccccccccccccccccccccccccccccccccccc:,..,dOOkkkk~n~kkkkkkkkkkkxdlcccccccccccccccccccccccccccccccccccccccccccccccccc:,.'okOkkkk~n~kkkkkkkkkkkkOkxolcccccccccccccccccccccccccccccccccccccccccccccccc:,'lkkkkkk~n~kkkkkkkkkkkkOkkkkdolcccccccccccccccccccccccccccccccccccccccccccccc:;ckOkkkk~n~kkkkkkkkkkkkkkkkkOkxdlcccccccccccccccccccccccccccccccccccclllllloooodkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkxdlcccccclllllllloooooodddddddxxxxxxxkkkkkkkkkkOkkOkk~n~kkkkkkkkkkkkkkkkkkkOkkkkkxxxxxxxkkkkkkkkkkkkkkkkkkOOkkkkkkkkkkkkkkkkkOOkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkOkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"},
        {Order = 24, Text = ",,,,,,,,,,,;;;;;;;::::::::::cccccccccclloodxxkkkkkkkxc;;:clllllllllllllllll~n~,,,,,,,,,,,,,;;;;:::cccccclllllooodxxxkkkkkkkkkkkkkkd:,,;cooooooooddddddddd~n~,,,,,,,,,,,,,,;;::ccllooodddxxkkkkkkkkkkkkkkkkkkkkkko;,,,;ldxxxxxxxxxxxxxxx~n~,,,,,,,,,,,,,,;::clodxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkxc,,,,,;lxkkkkkkkkkkkkkk~n~,,,,,,,,,,,,;codxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkd:,,,,,,;lxkkkkkkkkkkkkk~n~,,,,,,,,,,,;okkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkl;,,,,,,,;lxkkkkkkkkkkkk~n~,,,,,,,,,,;lxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxc,,,,,,,,,;lxkkkkkkkkkkk~n~,,,,,,,,,,cxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkko;,,,,,,,,,,;cxkkkkkkkkkk~n~,,,,,,,,,:dkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkl;,,,,,,,,,,,;cxkkkkkkkkk~n~,,,,,,,,;okkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxc,,,,,,,,,,,,,,cdkkkkkkkk~n~,,,,,,,;lxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkko;,,,,,,,,,,,,,,,:dkkkkkkk~n~,,,,,,,cxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkl,,,,,,,,,,,,,,,,,:dkkkkkk~n~,,,,,,:dkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkd:,,,,,,,,,,,,,,,,,,:okkkkk~n~,,,,,;okkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkko;,,,,,,,,,,,,,,,,,,,:dkkkk~n~,,,,;lkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxc,,,,,,,,,,,,,,,,,,,,;okkkk~n~,,,;cxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkd:,,,,,,,,,,,,,,,,,,,,:dkkkk~n~,,,:dkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkko;,,,,,,,,,,,,,,,,,,,,:dkkkk~n~,,:dkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxc,,,,,,,,,,,,,,,,,,,,,cxkkkk~n~,;okkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkd:,,,,,,,,,,,,,,,,,,,,,cxkkkk~n~;lxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkl;,,,,,,,,,,,,,,,,,,,,,lkkkkk~n~cxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxc,,,,,,,,,,,,,,,,,,,,,;lkkkkk~n~dkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkd:,,,,,,,,,,,,,,,,,,,,,;okkkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxl;,,,,,,,,,,,,,,,,,,,,,:dkkkkk~n~kkkkkkkkkkkkkkkxxxxxxdddddddooooooollllllllcc:;,,,,,,,,,,,,,,,,,,,,,:dkkkkk~n~oooollllllccccccc:::::::::::::;;;;;;;;;;;:::::;;;,,,,,,,,,,,,,,,,,,,cxkkkkk~n~;;;;;;;::::::::::::::::::::::::::::::::::::;;:::;;;,,,,,,,,,,,,,,,,,cxkkkkk~n~,,,;;;;::::::::::::::::::::::::::::::::::;;;::::::;;;,,,,,,,,,,,,,,,lkkkkkk~n~,,,,,;;:::::::::::::::::::::::::::::::::::;::::::::::;;,,,,,,,,,,,,;okkkkkk~n~,,,,;;::cllllc:::::::::::::::::::::::::::::::::::::;:::;;;,,,,,,,,,;okkkkkk~n~,,,;;;:cclodxxdolc:::::::::::::::::::::::::::::::::::::::;;;,,,,,,,:dkkkkkk~n~,,,;;;:cloddxkkkkxdoc::::::::::::::::::::::::::::;;::::::::;;;,,,,,:dkkkkkk~n~,,,;;::clodxxkkkkkkkkxolc::::;::::::::::::::::::::;::::::::::;;;,,,cxkkkkkk~n~,,;;;:cllodxxkkkkkkkkkkkxdolcccccccccccc::::::::::::::::::::::;;;;,cxkkkkkk~n~,,;;;:clodxxkkkkkkkkkkkkkkkkkkkkkkkxxxxxxxxxxxddddddddddddooooooooldkOkkkkk~n~,,;;::clodxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~,,;;:cloodxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~,;;::clodxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~,;;:cclodxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~,;;:cloodxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"},
        {Order = 25, Text = "cccccccccccccccccccccccccccccccccccclllooddxxkkkkdcccldxxxxkkkkkkkkkkkkkkkk~n~ccccccccccccccccccccccccccccccllooddxxxkkkkkkkkkxlccccloxxxkkkkkkkkkkkkkkkk~n~cccccccccccccccccccccccclloodxxkkkkkkkkkkkkkkkkxocccccccodxkkkkkkkkkkkkkkkk~n~cccccccccccccccccclloddxxxkkkkkkkkkkkkkkkkkkkkkdlccccccccloxkkkkkkkkkkkkkkk~n~cccccccccccccclodxxkkkkkkkkkkkkkkkkkkkkkkkkkkkxlcccccccccccldxkkkkkkkkkkkkk~n~cccccccccccccldkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxoccccccccccccccodkkkkkkkkkkkk~n~cccccccccccccdxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkdlcccccccccccccccloxkkkkkkkkkk~n~ccccccccccccoxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxoccccccccccccccccccldxkkkkkkkk~n~cccccccccccoxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkdcccccccccccccccccccccldxkkkkkk~n~cccccccccclxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxlcccccccccccccccccccccccoxkkkkk~n~cccccccccldkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxocccccccccccccccccccccccccldxkkk~n~ccccccccldkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkdlcccccccccccccccccccccccccccldxk~n~ccccccccdxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxoccccccccccccccccccccccccccccccox~n~cccccccoxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkdccccccccccccccccccccccccccccccccd~n~ccccccoxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkdlccccccccccccccccccccccccccccccclx~n~cccccoxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxoccccccccccccccccccccccccccccccccox~n~cccclxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkdlcccccccccccccccccccccccccccccccldk~n~cccldkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxlcccccccccccccccccccccccccccccccclxk~n~ccldkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxxocccccccccccccccccccccccccccccccccoxk~n~ccdxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkdolccccccccccccccccccccccccccccccccldkk~n~coxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxoccccccccccccccccccccccccccccccccccoxkk~n~oxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkdcccccccccccccccccccccccccccccccccccdkkk~n~xkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxlcccccccccccccccccccccccccccccccccclxkkk~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxocccccccccccccccccccccccccccccccccccoxkkk~n~lllloooooddddxxxxxxxxkkkkkkkkkkkkdlccccccccccccccccccccccccccccccccccldkkkk~n~:::;;;,,,;;;;;;:::::ccccclllllooolcccccccccccccccccccccccccccccccccccoxkkkk~n~ccccc:::;;,,,,,,,,,,,,,,,,,,,,,,,,;;:::ccccccccccccccccccccccccccccccdkkkkk~n~ccccccccc:::;;;,,,,,,,,,,,,,,,,,,,,,,,,;;::ccccccccccccccccccccccccclxkkkkk~n~cccccccccccccc:::;;,,,,,,,,,,,,,,,,,,,,,,,;;:::cccccccccccccccccccccoxkkkkk~n~ccccccccccccccccccc::;;;,,,,,,,,,,,,,,,,,,,,,,;;:::ccccccccccccccccldkkkkkk~n~ccccccccccccccccccccccc:::;;;,,,,,,,,,,,,,,,,,,,,,;;::cccccccccccccoxkkkkkk~n~cccccccccccccccccccccccccccccc::::::;;;;,,,,,,,,,,,,,,;;::cccccccccdkkkkkkk~n~ccccccccccccccccccccccccccccclloodddddddooollcc::;;;,,,,,;;:::cccclxkkkkkkk~n~ccccccccccccccccccccccccccccllooddxxxxkkkkkkkkxxxxddoollcc:::::::coxkkkkkkk~n~cccccccccccccccccccccccccccllloddxxxxkkkkkkkkkkkkkkkkkkkkkxxxdddodxkkkkkkkk~n~cccccccccccccccccccccccccccllooddxxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~ccccccccccccccccccccccccccllooddxxxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~ccccccccccccccccccccccccccllooddxxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~cccccccccccccccccccccccccllooddxxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"},
        {Order = 26, Text = "oooooooooooooooooooooooooooooooooooodddddddddoooooooooooooooooooooooooooooo~n~ooooooooooooooooooooooooooooooodddddxxxxxxxdooooooooooooooooooooooooooooooo~n~oooooooooooooooooooooooooodddddxxxxxxxxxxxdoooooooooooooooooooooooooooooooo~n~oooooooooooooooooooodddddxxxxxxxxxxxxxxxxddoooooooooooooooooooooooooooooooo~n~oooooooooooooooooddxxxxxxxxxxxxxxxxxxxxxddooooooooooooooooooooooooooooooooo~n~oooooooooooooooodxxxxxxxxxxxxxxxxxxxxxxxdoooooooooooooooooooooooooooooooooo~n~ooooooooooooooodxxxxxxxxxxxxxxxxxxxxxxxdooooooooooooooooooooooooooooooooood~n~ooooooooooooooddxxxxxxxxxxxxxxxxxxxxxxddooooooooooooooooooooooooooooooooodd~n~oooooooooooooddxxxxxxxxxxxxxxxxxxxxxxddoooooooooooooooooooooooooooooooooodd~n~ooooooooooooddxxxxxxxxxxxxxxxxxxxxxxddooooooooooooooooooooooooooooooooooddd~n~oooooooooooddxxxxxxxxxxxxxxxxxxxxxxdooooooooooooooooooooooooooooooooooooodd~n~ooooooooooodxxxxxxxxxxxxxxxxxxxxxxddooooooooooooooooooooooooooooooooooooooo~n~oooooooooodxxxxxxxxxxxxxxxxxxxxxxddoooooooooooooooooooooooooooooooooooooooo~n~ooooooooodxxxxxxxxxxxxxxxxxxxxxxxdooooooooooooooooooooooooooooooooooooooooo~n~ooooooooddxxxxxxxxxxxxxxxxxxxxxxdoooooooooooooooooooooooooooooooooooooooooo~n~oooooooddxxxxxxxxxxxxxxxxxxxxxxddoooooooooooooooooooooooooooooooooooooooooo~n~ooooooddxxxxxxxxxxxxxxxxxxxxxxddooooooooooooooooooooooooooooooooooooooooooo~n~oooooodxxxxxxxxxxxxxxxxxxxxxxxdoooooooooooooooooooooooooooooooooooooooooood~n~ooooodxxxxxxxxxxxxxxxxxxxxxxxdooooooooooooooooooooooooooooooooooooooooooood~n~oooodxxxxxxxxxxxxxxxxxxxxxxxddooooooooooooooooooooooooooooooooooooooooooodd~n~oooddxxxxxxxxxxxxxxxxxxxxxxddoooooooooooooooooooooooooooooooooooooooooooodx~n~ooddxxxxxxxxxxxxxxxxxxxxxxxdooooooooooooooooooooooooooooooooooooooooooooddx~n~oddxxxxxxxxxxxxxxxxxxxxxxxdooooooooooooooooooooooooooooooooooooooooooooddxx~n~odxxxxxxxxxxxxxxxxxxxxxxxddooooooooooooooooooooooooooooooooooooooooooooddxx~n~oodddddxxxxxxxxxxxxxxxxxddooooooooooooooooooooooooooooooooooooooooooooddxxx~n~ooooooooooddddxxxxxxxxxxdooooooooooooooooooooooooooooooooooooooooooooodxxxx~n~oooooooooooooooooddddxxddooooooooooooooooooooooooooooooooooooooooooooddxxxx~n~ooooooooooooooooolloooooooooooooooooooooooooooooooooooooooooooooooooodxxxxx~n~oooooooooooooooooooooollllllllooooooooooooooooooooooooooooooooooooooddxxxxx~n~ooooooooooooooooooooooooooollllllllloooooooooooooooooooooooooooooooodxxxxxx~n~ooooooooooooooooooooooooooooooooolllllllllooooooooooooooooooooooooodxxxxxxx~n~ooooooooooooooooooooooooooooooooooooooolllllllloooooooooooooooooooddxxxxxxx~n~oooooooooooooooooooooooooooooooooooooooooooooolllllooooooooooooooodxxxxxxxx~n~ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooodxxxxxxxxx~n~oooooooooooooooooooooooooooooooooooooooooooooooooooooodddddddoooodxxxxxxxxx~n~oooooooooooooooooooooooooooooooooooooooooooooooooooodddddddxxxdddxxxxxxxxxx~n~ooooooooooooooooooooooooooooooooooooooooooooooooooooddddddxxxxxxxxxxxxxxxxx~n~oooooooooooooooooooooooooooooooooooooooooooooooooooddddddxxxxxxxxxxxxxxxxxx~n~ooooooooooooooooooooooooooooooooooooooooooooooooooodddddxxxxxxxxxxxxxxxxxxx"},
        {Order = 27, Text = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxdddddoddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxddddoooooodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxdddddooooooooodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxddooooooooooooodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxddoooooooooooooddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxdoooooooooooooodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxdoooooooooooooodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxddooooooooooooodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxddoooooooooooooddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxddoooooooooooooddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxdoooooooooooooodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxdoooooooooooooodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxdooooooooooooooddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxddoooooooooooooddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxdoooooooooooooodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxdoooooooooooooodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxdooooooooooooooddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxddoooooooooooooddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxddoooooooooooooodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxdoooooooooooooodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxdoooooooooooooodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxddoooooooooooooddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxdoooooooooooooodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxddoooooooooooodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxdddoooooooodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxddooooooddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxdddooodxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxddddxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxd~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdd~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdd~n~xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxddd"},
        {Order = 28, Text = "kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkOOOOOOOOOOOOOOOOOO~n~kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkOOkkkkkkkOOOOOOOOOkkkkOOOOOOOOOOOOOOOOOOOOOOO~n~kkkkkkkkkkkkkkkkkkkkkkkkxdooxOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~kkkkkkkkkkkkkkkkkkkkkxdolcldkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~kkkkkkkkkkkkkkkkkkkkdlccccokOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~kkkkkkkkkkkkkkkkkkkxlcccclxOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~kkkkkkkkkkkkkkkkkkxoccccldkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~kkkkkkkkkkkkkkkkkkdlccccokOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkkkkOOOOOOOOOOOOOOO~n~kkkkkkkkkkkkkkkkkxlcccclxOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkkkkkkkkkOOOOOOOOOOO~n~kkkkkkkkkkkkkkkkxoccccldOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkkkkkkkkkkkkkkkOOOOOO~n~kkkkkkkkkkkkkkkkdlccccokOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkOO~n~kkkkkkkkkkkkkkkxlccccoxOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkkoccccldOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkkdlccclokOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkkxlccccoxOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkxocccclxOOOOOOOOOOOOOOOOOOOOOOOOOOOkkOkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkkdlccclokOOOOOOOOOOOOOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkkxlccccoxOOOOOOOOOOOOOOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkxocccclxOOOOOOOOOOOOOOOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkk~n~kkkkkkkkkkdlcccldkOOOOOOOOOOOOOOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkO~n~kkkkkkkkkxlccccoxOOOOOOOOOOOOOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkOO~n~kkkkkkkkxocccclxOOOOOOOOOOOOOOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkOO~n~kkkkkkkkdlcccldkOOOOOOOOOOOOOOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkOOO~n~kkkkkkkxoccccoxOOOOOOOOOOOOOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkOOOO~n~kkkkkkkkoccclxOOOOOOOOOOOOOOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkOOOOO~n~kkkkkkkkdlcldkOOOOOOOOOOOOOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkOOOOO~n~kkkkkkkkdlcokOOOOOOOOOOOOOkOOOOkkkkkkkkkkOOOkkkkkkkkkkkkkkkkkkkkkkkkkOOOOOO~n~kkkkkkkkxllxOOOOOOOOOOOOOkkOOOkkkkkkkkkkOOOOOkkkkkkkkkkkkkkkkkkkkkkkOOOOOOO~n~kkkkkkkkxodkOOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkOOOOOOOO~n~kkkkkkkkkdxOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkOOOOOOOO~n~kkkkkkkkkkkOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkOOOOOOOOO~n~kkkkkkkkkkkkkkkOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkOOOOOOOOOO~n~kkkkkkkkkkkkkkkkkkkkkOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkOOOOOOOOOOO~n~kkkkkkkkkkkkkkkkkkkkOOOOOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkkkkkkkkOOOOOOOOOOO~n~kkkkkkkkkkkkkkkkkkkOOOOOOOOOOOOOOOOOOOOOOOOOkkkkkkkkkkkkkkkkkkkOOOOOOOOOOOO~n~kkkkkkkkkkkkkkkkkkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOkkkkkkkkkkkOOOOOOOOOOOOO~n~kkkkkkkOOkkOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO~n~OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"},
        {Order = 29, Text = "000000000000000000000000000000000000000000000000000000000000000000000000000~n~000000000000000000000000000000000000000000000000000000000000000000000000000~n~000000000000000000000000000000000000000000000000000000000000000000000000000~n~00000000000000000000KKKK000000000000000000000000000000000000000000000000000~n~0000000000000000000KKXXXKKKKKK000000000000000000000000000000000000000000000~n~0000000000000000000KXKKKKKKKKKKKKKKK000000000000000000000000000000000000000~n~0000000000000000000KKKKKKKKKKKKKKKKKKKKKKK000000000000000000000000000000000~n~000000000000000000KKKKKKKKKKKKKKKKKKKKKKKKKK0000000000000000000000000000000~n~000000000000000000KKKKKKKKKKKKKKKKKKKKKKKKK00000000000000000000000000000000~n~00000000000000000KKKKKKKKKKKKKKKKKKKKKKKK0000000000000000000000000000000000~n~00000000000000000KKKKKKKKKKKKKKKKKKKKK0000000000000000000000000000000000000~n~0000000000000000KKKKKKKKKKKKKKKKKKKK000000000000000000000000000000000000000~n~0000000000000000KKKKKKKKKKKKKKKKKK00000000000000000000000000000000000000000~n~000000000000000KKKKKKKKKKKKKKKKK0000000000000000000000000000000000000000000~n~000000000000000KKKKKKKKKKKKKK0000000000000000000000000000000000000000000000~n~000000000000000KKKKKKKKKKKK000000000000000000000000000000000000000000000000~n~00000000000000KKKKKKKKKK000000000000000000000000000000000000000000000000000~n~00000000000000KKKK000000000000000000000000000000000000000000000000000000000~n~00000000000000K00000000000000000000000000000000000000000000000000000O000000~n~000000000000000000000000000000000000000000000000000000000000000000000000000~n~00000000000000000000000000000000000000000000000000000000000000OO00000O00000~n~00000000000000000000000000000000000000000000000000000000000000OOOOOOOO00000~n~0000000000000000000000000000000000000000000000000000000000000OOOOOOOO000000~n~000000000000000000000000000000000000000000000000000000000000OOOOOOOO0000000~n~000000000000000000000000000000000000000000000000000000OOOOOOOOOOOOO00000000~n~0000000000000000000000000000000000000000000000000000OOOOOOOOOOOOOOO00000000~n~000000000000000000000000000000000000000000000000OOOOOOOOOOOOOOOOOO000000000~n~00000000000000000000000000000000000000000000000OOOOOOOOOOOOOOOOOO0000000000~n~000000000000000000000000000000000000000OO0000000OOOOOOOOOOOOOOOOO0000000000~n~000000000000000000000000000000000000OOOOOOOOOOOOOOOOOOOOOOOOOOOO00000000000~n~0000000000000000000000000000000OOOOOO000000OOOOOOOOOOOOOOOOOOOO000000000KKK~n~00000000000000000000000000000000000000000OOOOOOOOOOOOOOOOOOOOOO00000000KKKK~n~0000000000000000000000000000000000000000OOOOOOOOOOOOOOOOOOOOOO0000000000000~n~000000000000000000000000000000000000OOOOOOOOOOOOOOOOOOOOOOOOO00000KKKK00000~n~000000000000000000000000000000000000000000000OOOOOOOOOOOOOOOO00KKKKKKKKKKKK~n~00000000000000000000000000000000000000000000000000000OOOOOOO00KKKKKKKKKKKKK~n~00000000000000000000000000000000000000000000000K0000000000000KKKKKKKKKKKKKK~n~00000000000000000000000000000000000000000000000K0000KKKKKK00KKKKKKKKKKKKKKK~n~00000000000000000000000000000000000000000000000KKKKKKKKKKKKKKKKKKKKKKKKKKKK"},
        {Order = 30, Text = "000000000000000000000000000000000000000000000000000000000000000000000000000~n~000000000000000000000000000000000000000000000000000000000000000000000000000~n~000000000000000000000000000000000000000000000000000000000000000000000000000~n~000000000000000000000000000000000000000000000000000000000000000000000000000~n~000000000000K0OkxdoollllllodxkkO0000000000000000000000000000000000000000000~n~000000000000KXK00Okxdolcc:;;,;;:ccloddxxkOO000K000000000000000000KKKKKKKKKK~n~00000000000KKXXXXXXXXXXKK0Okxxdolc:;;,,;;::cloddxkOO000KK00KKKKKKKKKKKKKKKK~n~00000000000KXXXXXXXXXXXXXXXXXXXXKK0Okkxxdolc:;;,,;;:cloodxkkO000K00KK0000K0~n~00000000000KXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXKK00Okxdolc::;,,;;:ccloxO0KKKK0KK~n~0000000000KKXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXKK0OOkxdolc::;;:ldk00KKK~n~KKKKKKKKKKKKXKKKXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXKKKKKKKKKKKKKK0OOkxdddxkO0K~n~KKKKKKK00KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKXKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK00KK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK00KKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK000KKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK0000KKK0000000KKKKKKKK~n~KKKKKKKKKK000000000000000000000000000KKK0000KKKKKKKKK00000000000000KKKKKKKK~n~KKKKKKKK0000000000000000000000000000000000000000000000000000000000KKKKKKKKK~n~KKKKKKKK0000000000000000000000000000000000000000000000000000000000KKKKKKKKK~n~KKKKKKK0000000000000000000000000000000000000000000000000000000000KKKKKKKKKK~n~KKKKKKK0000000000000000000000000000000000000000000000000000000000KKKKKKKKKK~n~KKKKKKK000000000000000000000000000000000000000000000000000000000KKKKKKKKKKK~n~KKKKKK0000000000000000000000000000000000000000000000000000000000KKKKKKKKKKK~n~KKKKKK000000000000000000000000000000000000000000000000000000000KKKKKKKKKKKK~n~KKKKKK000000000000000000000000000000000000000000000000000000000KKKKKKKKKKKK~n~KKKKK000000000000000000000000000000000000000000000000000000000KKKKKKKKKKKKK~n~KKKKKK00000000000000000000000000000000000000000000000000000000KKKKKKKKKKKKK~n~KKKKKKKKKKKKKKK0000000000000000000000000000000000000000000000KKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKK000000000000000000000000000000000000KKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK000000000000000000000000000KKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK000000000000000KKKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK0000000KKKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK"},
        {Order = 31, Text = "000000000000000000000000000000000000000000000000000000000000000000000000000~n~000000000000000000000000000000000000000000000000000000000000000000000000000~n~000000000000000000000000000000000000000000000000000000000000000000000000000~n~000000000000000000000000000000000000000000000000000000000000000000000000000~n~0000000000000000000OOkxxddddxxkkkOOO000000000000000000000000000000000000000~n~00000000OOkkxxdoollcc::;;;;;;;:::cclllloooddxxkkkOOO00000000000000000000000~n~0000000Okxdoolcc:::;;;;;;;;;;;;;;;;;;;;;;;;;;;:::ccllloodddxxkkkOO000000000~n~00000000000000OOOkkxxddooollcc:::;;;;;;;;;;;;;;;;;;;;;;;;;;;;:::ccoO0000000~n~000000000000000000KKKKKKK0000OOkkxxddddoollcc::;;;;;;;;;;;;;;;;;;;lk0000000~n~000000000000000000000KK00KKKKKKKKKKKKKKKK000OOkkxxxddolllcc::;;;;;lO0000000~n~0000000000000000000000000KKKKKKKKKKKKKKKKKKKKKKKKKKKKKK000OOkkxxddx00000000~n~000000000000000000000000000KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK000000000~n~000000000000000000000000000000KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK000000000~n~000000000000000000000000000000000KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK000000000~n~0000000000000000000000000000000000000KKKKKKKKKKKKKKKKKKKKKKKKKKKK0000000000~n~00000000000000000000000000000000000000000000KKKKKKKKKKKKKKKKKKKKK0000000000~n~0000000000000000000000000000000000000000000000000KKKKKKKKKKKKKKK00000000000~n~00000000000000000000000000000000000000000000000000000000KK0KKKKK00000000000~n~000000000000000000000000000000000000000000000000000000000000000000000000000~n~000000000000000000000000000000000000000000000000000000000000000000000000000~n~KKK000000000000000000000000000000000000000000000000000000000000000000000000~n~KKKK00000000000000000000000000000000000000000000000000000000000000000000000~n~KKKKK0000000000000000000000000000000000000000000000000000000000000000000000~n~0KKKK0000000000000000000000000000000000000000000000000000000000000000000000~n~KKKKK0000000000000000000000000000000000000000000000000000000000000000000000~n~KKKK00000000000000000000000000000000000000000000000000000000000000000000000~n~KKKK00000000000000000000000000000000000000000000000000000000000000000000000~n~KKKKK0000000000000000000000000000000000000000000000000000000000000000000000~n~KKKKK0000000000000000000000000000000000000000000000000000000000000KK0000000~n~KKKKK0000000000000000000000000000000000000000000000000000000000000000000000~n~KKKKK0000000000000000000000000000000000000000000000000000000000000000000000~n~KKKKK00000000000000000000000000000000000000000000000000000000KKK00000000000~n~KKKKKKKKKK000000000000000000000000000000000000000000000000000KKK00000000000~n~KKKKKKKKKKKKKKKKKK0000000000000000000000000000000000000000000KK00KKKKK00000~n~KKKKKKKKKKKKKKKKKKKKKKKKKK000000000000000000000000000000000KKKK0000KKK000KK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK000000000000000000000000KKKK0000000KKKKK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK00000000000000KKKKKKKKKKKK000KK~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK00000KKKKKKKKKKKK00000~n~KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK0KKKKKKKKKKK000"},
    }

    self.Picture = nil

    self.RTimer = nil
    self.RAmount = 0

    self.DravenAxes = {}
    self.ERange     = 1000

    self.RSpeed     = 2000
    self.BaseRSpeed = 2000
    self.RTarget    = nil

    self.DravenMenu         = Menu:CreateMenu("Draven")
    ------------------------------------------------------------------------------
    self.DravenCombo        = self.DravenMenu:AddSubMenu("#Combo: ->")
    self.AutoQCombo         = self.DravenCombo:AddCheckbox("Use Q 2 Axes", 1)
    self.AutoQTimer         = self.DravenCombo:AddCheckbox("Use Q Timer", 1)
    self.UseWCombo          = self.DravenCombo:AddCheckbox("Use W", 1)
    self.UseECombo          = self.DravenCombo:AddCheckbox("Use E", 1)
    self.UseRCombo          = self.DravenCombo:AddCheckbox("Use R", 1)
    -------------------------------------------------------------------------------
    self.DravenHarass       = self.DravenMenu:AddSubMenu("#Harass: ->")
    self.AutoQHarass        = self.DravenHarass:AddCheckbox("Use Q 2 Axes", 1)
    self.AutoQTimerHarass   = self.DravenHarass:AddCheckbox("Use Q Timer", 1)
    self.UseWHarass         = self.DravenHarass:AddCheckbox("Use W", 1)
    self.UseEHarass         = self.DravenHarass:AddCheckbox("Use E", 1)
    self.UseRHarass         = self.DravenHarass:AddCheckbox("Use R", 1)
    -------------------------------------------------------------------------------
    self.DravenMisc         = self.DravenMenu:AddSubMenu("#Misc: ->")
    self.CatchQCombo        = self.DravenMisc:AddCheckbox("Catch Q Combo", 1)
    self.CatchQHarass       = self.DravenMisc:AddCheckbox("Catch Q Harass", 1)
    self.CatchQLaneclear    = self.DravenMisc:AddCheckbox("Catch Q Laneclear", 1)
    self.CatchQLasthit      = self.DravenMisc:AddCheckbox("Catch Q Lasthit", 1)
    self.DravenMisc:AddLabel("Range From Mouse 2 Axe for Catching Axes (0 == off)")
    self.CatchQRange        = self.DravenMisc:AddSlider("", 300,0,1200,25)
    self.AntigapcloseE      = self.DravenMisc:AddCheckbox("AutoE Gapcloser", 1)
    --------------------------------------------------------------------------------
    self.DravenBaseR        = self.DravenMenu:AddSubMenu("#BaseUlt R: ->")
    self.BaseUltR           = self.DravenBaseR:AddCheckbox("Use BaseUlt R", 1)
    self.BaseUltRENear      = self.DravenBaseR:AddCheckbox("Dont use if Enemies near", 1)
    self.DravenBaseR:AddLabel("Maximum of Times/Game (0 == no limit) NOT WORKING!")
    self.BaseUltR_Amount        = self.DravenBaseR:AddSlider("", 1,0,5,1)
    self.DravenBaseR:AddLabel("Use Again Only After X minutes (0 == no limit) NOT WORKING!")
    self.BaseUltR_Time          = self.DravenBaseR:AddSlider("", 1,0,60,1)
    self.DravenBaseR:AddLabel("Use Only After X PassiveStacks (0 == no limit)")
    self.BaseUltR_Stacks        = self.DravenBaseR:AddSlider("", 50,0,300,5)
    self.DravenBaseR:AddLabel("Use Only If Enemy Was Visible X Seconds Ago (0 == no limit)")
    self.BaseUltR_Visible       = self.DravenBaseR:AddSlider("", 25,0,300,1)

    --------------------------------------------------------------------------------
    self.DravenDrawings     = self.DravenMenu:AddSubMenu("#Drawings: ->")
    self.DrawQ              = self.DravenDrawings:AddCheckbox("Draw Axes", 1)
    self.DrawE              = self.DravenDrawings:AddCheckbox("Draw E", 1)
    self.QCatchRange        = self.DravenDrawings:AddCheckbox("Draw Q Catch Range", 1)
    --------------------------------------------------------------------------------
    self.DravenInfo         = self.DravenMenu:AddSubMenu("#Info: ->")
                                                                               
--[[    self.DravenInfo:AddLabel("██████╗ ██████╗  █████╗ ██╗   ██╗███████╗███╗   ██╗    ██████╗     ██████╗ ")
    self.DravenInfo:AddLabel("██╔══██╗██╔══██╗██╔══██╗██║   ██║██╔════╝████╗  ██║    ╚════██╗   ██╔═████╗")
    self.DravenInfo:AddLabel("██║  ██║██████╔╝███████║██║   ██║█████╗  ██╔██╗ ██║     █████╔╝   ██║██╔██║")
    self.DravenInfo:AddLabel("██║  ██║██╔══██╗██╔══██║╚██╗ ██╔╝██╔══╝  ██║╚██╗██║    ██╔═══╝    ████╔╝██║")
    self.DravenInfo:AddLabel("██████╔╝██║  ██║██║  ██║ ╚████╔╝ ███████╗██║ ╚████║    ███████╗██╗╚██████╔╝")
    self.DravenInfo:AddLabel("╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝    ╚══════╝╚═╝ ╚═════╝ ")]]
                                                          
    self.DravenInfo:AddLabel("==================")
    self.DravenInfo:AddLabel("Credits:")
    self.DravenInfo:AddLabel("- Scortch")
    self.DravenInfo:AddLabel("- Christoph")
    self.DravenInfo:AddLabel("- Critic")
    self.DravenInfo:AddLabel("==================")
    self.DravenInfo:AddLabel("")
    self.DravenInfo:AddLabel("==============================================")
    self.DravenInfo:AddLabel("Current Version: 2.0 Remastered by Critic")
    self.DravenInfo:AddLabel("==============================================")
    self.DravenInfo:AddLabel("")
    self.DravenInfo:AddLabel("=======================================================================")
    self.DravenInfo:AddLabel("Last Update: 24/08/2022")
    self.DravenInfo:AddLabel("- Fully reworked smarter W/E/R")
    self.DravenInfo:AddLabel("- Better BaseR (With Humanizer)!")
    self.DravenInfo:AddLabel("- Added Range from mouse 2 Q for smoother axe catching.")
    self.DravenInfo:AddLabel("^ (HotFix for tower diving/moving back to enemy while kiting via versa!)")
    self.DravenInfo:AddLabel("=======================================================================")
    self.DravenInfo:AddLabel("")
    self.DravenInfo:AddLabel("=======================================================================")
    self.DravenInfo:AddLabel("ToDo:")
    self.DravenInfo:AddLabel("- R> Flash> R combo for killing/multi targets!")
    self.DravenInfo:AddLabel("- Multiple hits with R on safe spot.")
    self.DravenInfo:AddLabel("- Use W for kiting/Evading spells")
    self.DravenInfo:AddLabel("^ (Smarter Q catch while evading spells!)")
    self.DravenInfo:AddLabel("- Smoother Q catch")
    self.DravenInfo:AddLabel("- Optimizating!")
    self.DravenInfo:AddLabel("- Using AA to minions to keep Q charge up before time ends while chasing!")
    self.DravenInfo:AddLabel("- Damage Drawings!")
    self.DravenInfo:AddLabel("- Ask for more logics!")
    self.DravenInfo:AddLabel("=======================================================================")
    --------------------------------------------------------------------------------
    Draven:LoadSettings()
end

function Draven:SaveSettings()
	SettingsManager:CreateSettings("Draven")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("AutoQ2", self.AutoQCombo.Value)
    SettingsManager:AddSettingsInt("AutoQTimer", self.AutoQTimer.Value)
    SettingsManager:AddSettingsInt("UseW", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("UseE", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("UseR", self.UseRCombo.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("AutoQHarass", self.AutoQHarass.Value)
    SettingsManager:AddSettingsInt("AutoQTimerHarass", self.AutoQTimerHarass.Value)
    SettingsManager:AddSettingsInt("UseWHarass", self.UseWHarass.Value)
    SettingsManager:AddSettingsInt("UseEHarass", self.UseEHarass.Value)
    SettingsManager:AddSettingsInt("UseRHarass", self.UseRHarass.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("CatchQCombo", self.CatchQCombo.Value)
    SettingsManager:AddSettingsInt("CatchQHarass", self.CatchQHarass.Value)
    SettingsManager:AddSettingsInt("CatchQLaneclear", self.CatchQLaneclear.Value)
    SettingsManager:AddSettingsInt("CatchQLasthit", self.CatchQLasthit.Value)
    SettingsManager:AddSettingsInt("CatchQRange", self.CatchQRange.Value)
    SettingsManager:AddSettingsInt("AntiE", self.AntigapcloseE.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("BaseRSettings")
    SettingsManager:AddSettingsInt("BaseUltR", self.BaseUltR.Value)
    SettingsManager:AddSettingsInt("BaseUltRENear", self.BaseUltRENear.Value)
    SettingsManager:AddSettingsInt("BaseUltR_Amount", self.BaseUltR_Amount.Value)
    SettingsManager:AddSettingsInt("BaseUltR_Time", self.BaseUltR_Time.Value)
    SettingsManager:AddSettingsInt("BaseUltR_Stacks", self.BaseUltR_Stacks.Value)
    SettingsManager:AddSettingsInt("BaseUltR_Visible", self.BaseUltR_Visible.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
    SettingsManager:AddSettingsInt("QCatchRange", self.QCatchRange.Value)
end

function Draven:LoadSettings()
    SettingsManager:GetSettingsFile("Draven")
    self.AutoQCombo.Value = SettingsManager:GetSettingsInt("Combo", "AutoQ2")
    self.AutoQTimer.Value = SettingsManager:GetSettingsInt("Combo", "AutoQTimer")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseW")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "UseE")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseR")
    -------------------------------------------
    self.CatchQCombo.Value = SettingsManager:GetSettingsInt("Misc", "CatchQCombo")
    self.CatchQHarass.Value = SettingsManager:GetSettingsInt("Misc", "CatchQHarass")
    self.CatchQLaneclear.Value = SettingsManager:GetSettingsInt("Misc", "CatchQLaneclear")
    self.CatchQLasthit.Value = SettingsManager:GetSettingsInt("Misc", "CatchQLasthit")
    self.CatchQRange.Value = SettingsManager:GetSettingsInt("Misc", "CatchQRange")
    self.BaseUltR.Value = SettingsManager:GetSettingsInt("Misc", "BaseUltR")
    self.AntigapcloseE.Value = SettingsManager:GetSettingsInt("Misc", "AntiE")
    -------------------------------------------
    self.BaseUltR.Value = SettingsManager:GetSettingsInt("BaseRSettings", "BaseUltR")
    self.BaseUltRENear.Value = SettingsManager:GetSettingsInt("BaseRSettings", "BaseUltRENear")
    self.BaseUltR_Amount.Value = SettingsManager:GetSettingsInt("BaseRSettings", "BaseUltR_Amount")
    self.BaseUltR_Time.Value = SettingsManager:GetSettingsInt("BaseRSettings", "BaseUltR_Time")
    self.BaseUltR_Stacks.Value = SettingsManager:GetSettingsInt("BaseRSettings", "BaseUltR_Stacks")
    self.BaseUltR_Visible.Value = SettingsManager:GetSettingsInt("BaseRSettings", "BaseUltR_Visible")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "DrawQ")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "DrawE")
    self.QCatchRange.Value = SettingsManager:GetSettingsInt("Drawings", "QCatchRange")
end

function Draven:RunGif(Gif)
    local Gif_ = Gif
    if Gif_ then
        for Picture in pairs(Gif_) do
            local Text = Picture.Text
            self.Picture = Text
            return
        end
    end
end

local function GetHeroLevel(Target)
    local totalLevel = Target:GetSpellSlot(0).Level + Target:GetSpellSlot(1).Level + Target:GetSpellSlot(2).Level + Target:GetSpellSlot(3).Level
    return totalLevel
end

local function GetDamage(rawDmg, isPhys, target)
    if isPhys then
        local Lethality = myHero.ArmorPenFlat * (0.6 + 0.4 * GetHeroLevel(target) / 18)
        local realArmor = target.Armor * myHero.ArmorPenMod
        local FinalArmor = (realArmor - Lethality)
        if FinalArmor <= 0 then
            FinalArmor = 0
        end
        return (100 / (100 + FinalArmor)) * rawDmg 
    end
    if not isPhys then
        local realMR = (target.MagicResist - myHero.MagicPenFlat) * myHero.MagicPenMod
        return (100 / (100 + realMR)) * rawDmg
    end
    return 0
end

function Draven:EnemiesInRange(Position, Range)
    local Enemies = {} 
    for _,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
            --Render:DrawCircle(Hero.Position, self.QWidth/2 + Hero.CharData.BoundingRadius,0,255,255,255)
			if Orbwalker:GetDistance(Hero.Position , Position) < Range then
	            Enemies[#Enemies + 1] = Hero			
			end
		end
    end
    return Enemies
end

function Draven:FindAxes()
    local DravenAxes = {}
    local Missiles = ObjectManager.MissileList
    for I, Missile in pairs(Missiles) do
        if Missile.Team == myHero.Team then
            if Missile.Name == "DravenSpinningReturn" then
                DravenAxes[#DravenAxes + 1] =  Missile
            end
        end
    end
    return DravenAxes
end

function Draven:SortAxes(Table)
    local SortedTable = {}
    for _, Object in pairs(Table) do
        SortedTable[#SortedTable + 1] = Object    
    end
    if #SortedTable > 1 then
        table.sort(SortedTable, function (left, right)
            return Orbwalker:GetDistance(myHero.Position, left.MissileEndPos) < Orbwalker:GetDistance(myHero.Position, right.MissileEndPos)
        end)
    end
    return SortedTable
end

function Draven:GetCatchPos(TargetPos , EndPos)
	local TargetVec 	= Vector3.new(TargetPos.x - EndPos.x, TargetPos.y - EndPos.y, TargetPos.z - EndPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length)
    local Mod           = 100
	return Vector3.new(EndPos.x + (TargetNorm.x * Mod),EndPos.y ,EndPos.z + (TargetNorm.z * Mod))
end

function Draven:CatchQ(Mode)
    local Target = Orbwalker:GetTarget(Mode, 1200)
    local CatchQRange   = self.CatchQRange.Value

    if #self.DravenAxes > 0 and Orbwalker.MovePosition == nil and Orbwalker.Attack == 0 then
        local MousePos = GameHud.MousePos
        --print(1)
        for _, Axe in pairs(self.DravenAxes) do
            local PositionToCatch = self:GetCatchPos(MousePos, Axe.MissileEndPos)
            if #self.DravenAxes > 1 then
                local NextAxe = self.DravenAxes[_ + 1]
                if NextAxe then
                    --print("WUT")
                    local RelativePos = self:GetCatchPos(MousePos, NextAxe.MissileEndPos)
                    PositionToCatch = self:GetCatchPos(RelativePos, Axe.MissileEndPos)
                end
            end
            -- if Target then
            --     PositionToCatch = self:GetCatchPos(Target.Position, PositionToCatch)
            --     if Orbwalker:GetDistance(Target.Position, PositionToCatch) < self.ERange then
            --         Orbwalker.MovePosition = PositionToCatch
            --         return      
            --     end
            -- else
            if CatchQRange > 0 then
                if (Orbwalker:GetDistance(MousePos, PositionToCatch) - 250) <= CatchQRange then
                    Orbwalker.MovePosition = PositionToCatch
                    Evade.IsMovePosisitionSetByExternal = true
                    return
                end
            else
                Orbwalker.MovePosition = PositionToCatch
                Evade.IsMovePosisitionSetByExternal = true
                return
            end
            --end
        end
    end
end

function Draven:FindR()
    local Missiles = ObjectManager.MissileList
    for _, Object in pairs(Missiles) do
        if Object.Team == myHero.Team and _ == Object.Index and Object.Name == "DravenR" then
            return Object
        end
    end
    return nil
end

function Draven:NextAADmg(Target)
    local Missiles = ObjectManager.MissileList
    local ExtraDMG = 0
    for _, Object in pairs(Missiles) do
        if Object.Team == myHero.Team and _ == Object.Index then
            if Object.TargetIndex == Target.Index  then
                --print(Object.Name)
                if string.find(Object.Name, "Attack") ~= nil and string.find(Object.Name, "Draven") ~= nil then
                    if string.find(Object.Name, "Spinning") ~= nil then
                        local QLevel = myHero:GetSpellSlot(0).Level
                        local DamagePerLevel = {40 , 45 , 50 , 55, 60}
                        local DamagePerLevelMod = {0.75 , 0.85 , 0.95 , 1.05 , 1.15}
                        local QDmg = DamagePerLevel[QLevel] + (myHero.BonusAttack*DamagePerLevelMod[QLevel])
                        if string.find(Object.Name, "Crit") ~= nil then
                            if myHero.CritChance >= 0.6 then
                                ExtraDMG = GetDamage(myHero.BaseAttack + myHero.BonusAttack + QDmg, true, Target) * 2.1
                            else
                                ExtraDMG = GetDamage(myHero.BaseAttack + myHero.BonusAttack + QDmg, true, Target) * 1.75
                            end
                        else
                            ExtraDMG = GetDamage(myHero.BaseAttack + myHero.BonusAttack + QDmg, true, Target)
                        end
                    else
                        if string.find(Object.Name, "P_RC") ~= nil then
                            if myHero.CritChance >= 0.6 then
                                ExtraDMG = GetDamage(myHero.BaseAttack + myHero.BonusAttack, true, Target) * 2.1
                            else
                                ExtraDMG = GetDamage(myHero.BaseAttack + myHero.BonusAttack, true, Target) * 1.75
                            end
                        else
                            ExtraDMG = GetDamage(myHero.BaseAttack + myHero.BonusAttack, true, Target)
                        end
                    end
                end
            end
        end
    end
    return ExtraDMG
end

--DravenSpinning
--DravenSpinningAttack
function Draven:QWER(Mode)
    local QBuff         = myHero.BuffData:GetBuff("DravenSpinningAttack") --dravenpassivestacks
    local Damage        = 0 -- TODO
    local Target        = Orbwalker:GetTarget("Combo", Orbwalker.OrbRange + 55) 
    local UltTarget     = Orbwalker:GetTarget("Combo", 3500) 
    local CatchQRange   = self.CatchQRange.Value

    --local ETarget   = Orbwalker:GetTargetSelectorList(myHero.Position, self.ERange)[1]
    if Mode == "Combo" and Engine:SpellReady("HK_SPELL4") and self.UseRCombo.Value == 1 then
        if UltTarget then
            local EDmg = 0
            if Engine:SpellReady("HK_SPELL3") and Orbwalker:GetDistance(myHero.Position, UltTarget.Position) < self.ERange then
                EDmg = GetDamage(40 + myHero:GetSpellSlot(3).Level * 35 + myHero.BonusAttack * 0.5, true, UltTarget)
            end
            --print(Draven:NextAADmg(UltTarget))
            if Orbwalker:GetDistance(myHero.Position, UltTarget.Position) >= myHero.AttackRange + 100 then
                local rDmg = self:GetRDamage(UltTarget) + Draven:NextAADmg(UltTarget) + EDmg
                if rDmg > UltTarget.Health then
                    --print("wut")
                    local PredPos = Prediction:GetPredictionPosition(UltTarget, myHero.Position, self.RSpeed, 0.5, 320, 0, 1, 0.15, 1)
                    if PredPos then
                        self.RTarget = UltTarget
                        Engine:CastSpell("HK_SPELL4", PredPos, 1)
                    end
                end
            else
                if QBuff.Count_Alt == 0 then
                    local rDmg = self:GetRDamage(UltTarget) + Draven:NextAADmg(UltTarget) + EDmg
                    local QLevel = myHero:GetSpellSlot(0).Level
                    local DamagePerLevel = {40 , 45 , 50 , 55, 60}
                    local DamagePerLevelMod = {0.75 , 0.85 , 0.95 , 1.05 , 1.15}
                    local QDmg = DamagePerLevel[QLevel] + (myHero.BonusAttack*DamagePerLevelMod[QLevel])
                    local aaDmg = myHero.BaseAttack + myHero.BonusAttack + QDmg
                    if myHero.CritChance >= 0.6 then
                        aaDmg = GetDamage(myHero.BaseAttack + myHero.BonusAttack + QDmg, true, UltTarget) * 2.1
                    else
                        if myHero.CritChance >= 0.2 then
                            aaDmg = GetDamage(myHero.BaseAttack + myHero.BonusAttack + QDmg, true, UltTarget) * 1.75
                        end
                    end

                    if aaDmg > UltTarget.Health then return nil end
                    if rDmg > UltTarget.Health then
                        local PredPos = Prediction:GetPredictionPosition(UltTarget, myHero.Position, self.RSpeed, 0.5, 320, 0, 1, 0.15, 1)
                        if PredPos then
                            self.RTarget = UltTarget
                            Engine:CastSpell("HK_SPELL4", PredPos, 1)
                        end
                    end
                end
            end
        end
    else
        self.RTarget = nil
    end

    if self.CatchQCombo.Value == 1 and QBuff.Count_Alt < 2 then
        if Target and Target.Health < Damage then else
            self:CatchQ(Mode)
        end
    end

    if self.UseWCombo.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local WBuff = myHero.BuffData:GetBuff("dravenfurybuff")
        local WSpeed = 1
        if myHero:GetSpellSlot(1).Level > 0 then
            WSpeed = 1.45 + myHero:GetSpellSlot(1).Level * 0.05
        end
        local ETarget = Orbwalker:GetTarget("Combo", self.ERange + ((myHero.MovementSpeed * WSpeed) * 0.55))
        local OrbTarget = Orbwalker:GetTarget("Combo", Orbwalker.OrbRange + ((myHero.MovementSpeed * WSpeed) * 0.55))

        if WBuff.Count_Alt == 0 then
            local AxesToCatch = #self.DravenAxes
            local PositionToCatch = nil
            if #self.DravenAxes > 0 then
                local MousePos = GameHud.MousePos
                for _, Axe in pairs(self.DravenAxes) do
                    local AxePos = Axe.MissileEndPos
                    if CatchQRange > 0 then
                        if Orbwalker:GetDistance(AxePos, MousePos) - 250 > CatchQRange then
                            AxesToCatch = AxesToCatch - 1
                        else
                            PositionToCatch = AxePos
                        end
                    else
                        PositionToCatch = AxePos
                    end
                end
            end
            local AATarget = Orbwalker:GetTarget("Combo", Orbwalker.OrbRange)
            if AATarget then
                return Engine:CastSpell("HK_SPELL2", nil ,1)
            end
            if AxesToCatch == 0 then
                if Engine:SpellReady("HK_SPELL3") then
                    if Target == nil and ETarget then
                        local QLevel = myHero:GetSpellSlot(0).Level
                        local DamagePerLevel = {40 , 45 , 50 , 55, 60}
                        local DamagePerLevelMod = {0.75 , 0.85 , 0.95 , 1.05 , 1.15}
                        local QDmg = DamagePerLevel[QLevel] + (myHero.BonusAttack*DamagePerLevelMod[QLevel])
                        local aaDmg = GetDamage(myHero.BaseAttack + myHero.BonusAttack + QDmg, true, ETarget)
                        local EDmg  = GetDamage(40 + myHero:GetSpellSlot(2).Level * 35 + myHero.BonusAttack * 0.5, true, ETarget)
                        if myHero.CritChance >= 0.6 then
                            aaDmg = GetDamage(myHero.BaseAttack + myHero.BonusAttack + QDmg, true, ETarget) * 2.1
                        else
                            if myHero.CritChance >= 0.2 then
                                aaDmg = GetDamage(myHero.BaseAttack + myHero.BonusAttack + QDmg, true, ETarget) * 1.75
                            end
                        end
                        local RDmg = 0
                        if Engine:SpellReady("HK_SPELL4") then
                            RDmg = self:GetRDamage(ETarget)
                        end
                        local MousePos = GameHud.MousePos
                        local MouseDist = Orbwalker:GetDistance(MousePos, ETarget.Position)
                        local TargetDist = Orbwalker:GetDistance(myHero.Position, ETarget.Position)
                        if MouseDist < TargetDist - 500 then
                            Render:DrawCircle(ETarget.Position, 55 ,0,255,0,255)
                            if ETarget.Health < (aaDmg * 3 + EDmg + RDmg) then
                                return Engine:CastSpell("HK_SPELL2", nil ,1)
                            end
                        end
                    end
                end
                if Target == nil and OrbTarget then
                    local MousePos = GameHud.MousePos
                    local MouseDist = Orbwalker:GetDistance(MousePos, ETarget.Position)
                    local TargetDist = Orbwalker:GetDistance(myHero.Position, ETarget.Position)
                    if MouseDist < TargetDist - 500 then
                        Render:DrawCircle(OrbTarget.Position, 55 ,255,255,0,255)
                        return Engine:CastSpell("HK_SPELL2", nil ,1)
                    end
                end
            else
                --[[if (Orbwalker:GetDistance(PositionToCatch, myHero.Position) - 100) > 10000000 then
                    return nil
                end]]
            end
        end
    end

    if self.AutoQCombo.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local PossibleAxes = QBuff.Count_Alt + #self.DravenAxes
        if PossibleAxes < 2 and Target then
            return Engine:CastSpell("HK_SPELL1", nil ,1)
        end
    end
    if self.AutoQTimer.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local Timer = QBuff.EndTime - GameClock.Time
        if Timer > 0 and Timer < 1 then
            return Engine:CastSpell("HK_SPELL1", nil ,1)
        end
    end
    if self.UseECombo.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local Enemies = self:EnemiesInRange(myHero.Position, self.ERange)
        if #Enemies > 0 and Orbwalker.Attack == 0 then
            for _, ETarget in pairs(Enemies) do
                local Distance = Orbwalker:GetDistance(ETarget.Position, myHero.Position)
                if self.RTarget and ETarget.Index == self.RTarget.Index then
                    local DravenR = Draven:FindR()
                    if DravenR then
                        local PredPos = Prediction:GetPredictionPosition(ETarget, myHero.Position, 1400, 0.25, 260, 0, 1, 0.001, 1)
                        if PredPos then
                            if Orbwalker:GetDistance(PredPos, myHero.Position) < self.ERange then
                                return Engine:CastSpell("HK_SPELL3", PredPos ,0)  
                            end    
                        end     
                    end
                end
                local QLevel = myHero:GetSpellSlot(0).Level
                local DamagePerLevel = {40 , 45 , 50 , 55, 60}
                local DamagePerLevelMod = {0.75 , 0.85 , 0.95 , 1.05 , 1.15}
                local QDmg = DamagePerLevel[QLevel] + (myHero.BonusAttack*DamagePerLevelMod[QLevel])
                local aaDmg = GetDamage(myHero.BaseAttack + myHero.BonusAttack + QDmg, true, ETarget)
                local EDmg  = GetDamage(40 + myHero:GetSpellSlot(2).Level * 35 + myHero.BonusAttack * 0.5, true, ETarget)
                if myHero.CritChance >= 0.6 then
                    aaDmg = GetDamage(myHero.BaseAttack + myHero.BonusAttack + QDmg, true, ETarget) * 2.1
                else
                    if myHero.CritChance >= 0.2 then
                        aaDmg = GetDamage(myHero.BaseAttack + myHero.BonusAttack + QDmg, true, ETarget) * 1.75
                    end
                end
                local RDmg = 0

                if Engine:SpellReady("HK_SPELL4") then
                    RDmg = self:GetRDamage(ETarget)
                end

                if ETarget.Health < (aaDmg * 3 + EDmg + RDmg) then
                    local MousePos = GameHud.MousePos
                    local MouseDist = Orbwalker:GetDistance(MousePos, ETarget.Position)
                    local TargetDist = Orbwalker:GetDistance(myHero.Position, ETarget.Position)
                    if MouseDist < TargetDist - 250 then
                        local PredPos = Prediction:GetPredictionPosition(ETarget, myHero.Position, 1400, 0.25, 260, 0, 1, 0.001, 1)
                        if PredPos then
                            if Orbwalker:GetDistance(PredPos, myHero.Position) < self.ERange then
                                return Engine:CastSpell("HK_SPELL3", PredPos ,0)  
                            end    
                        end  
                    end
                end

                local Pos2ETarget = Orbwalker:GetDistance(myHero.Position, ETarget.Position)
                if ETarget.AttackRange > Pos2ETarget - 25 then
                    local MissingHP = ((myHero.MaxHealth - myHero.Health) / myHero.MaxHealth) * 100
                    if MissingHP > 0.7 then
                        local PredPos = Prediction:GetPredictionPosition(ETarget, myHero.Position, 1400, 0.25, 260, 0, 1, 0.001, 1)
                        if PredPos then
                            if Orbwalker:GetDistance(PredPos, myHero.Position) < self.ERange then
                                return Engine:CastSpell("HK_SPELL3", PredPos ,0)  
                            end  
                        end  
                    end
                end

                local NextAA = Draven:NextAADmg(ETarget)
                if ETarget.Health < (RDmg + EDmg + NextAA * 3) then
                    local PredPos = Prediction:GetPredictionPosition(ETarget, myHero.Position, 1400, 0.25, 260, 0, 1, 0.001, 1)
                    if PredPos then
                        if Orbwalker:GetDistance(PredPos, myHero.Position) < self.ERange then
                            return Engine:CastSpell("HK_SPELL3", PredPos ,0)  
                        end  
                    end   
                end

                --[[if Orbwalker.MovePosition and #self.DravenAxes > 0 then
                    Distance = Orbwalker:GetDistance(Orbwalker.MovePosition, myHero.Position)
                    local MousePos = GameHud.MousePos
                    local MouseDist = Orbwalker:GetDistance(MousePos, ETarget.Position)
                    if Distance > Orbwalker.OrbRange + 55 and MouseDist < 550 then
                        local PredPos = Prediction:GetPredictionPosition(ETarget, myHero.Position, 1400, 0.25, 260, 0, 1, 0.85, 1)
                        if PredPos then
                            return Engine:CastSpell("HK_SPELL3", PredPos ,0)    
                        end       
                    end    
                end]]

                if ETarget.AttackRange < 350 and  Distance < ETarget.AttackRange + 75 and Orbwalker.ResetReady == 1 then
                    local PredPos = Prediction:GetPredictionPosition(ETarget, myHero.Position, 1400, 0.25, 260, 0, 1, 0.001, 1)
                    if PredPos then
                        if Orbwalker:GetDistance(PredPos, myHero.Position) < self.ERange then
                            return Engine:CastSpell("HK_SPELL3", PredPos ,0)  
                        end  
                    end           
                end
            end
        end
    end
end

function Draven:Laneclear() 
    local QBuff     = myHero.BuffData:GetBuff("DravenSpinningAttack")
    if self.CatchQLaneclear.Value == 1 and QBuff.Count_Alt < 2 then
        self:CatchQ("Laneclear")
    end
end

function Draven:Lasthit() 
    local QBuff     = myHero.BuffData:GetBuff("DravenSpinningAttack")
    if self.CatchQLasthit.Value == 1 and QBuff.Count_Alt < 2 then
        self:CatchQ("Lasthit")
    end
end


function Draven:CastRToEnemyBase()
	Engine:CastSpellMap("HK_SPELL4", self.EnemyBase ,1)
end

function Draven:GetRDamage(Target)
	local MissingHealth 			= Target.MaxHealth - Target.Health
	local RLevel 					= myHero:GetSpellSlot(3).Level
    local DamagePerLevel            = {350, 55, 750}
    local DamagePerLevelMod         = {2.2, 2.6, 3}
    local Stacks                    = myHero.BuffData:GetBuff("dravenpassivestacks").Count_Int --dravenpassivestacks
    
	local DMG 						= DamagePerLevel[RLevel] + (myHero.BonusAttack * DamagePerLevelMod[RLevel])
    local MissingHP                 = ((myHero.MaxHealth - myHero.Health) / myHero.MaxHealth) * 100 
    local Runes                     = 1
    if MissingHP > 0.45 then
        Runes = Runes + 0.05
    end
    if MissingHP > 0.55 then
        Runes = Runes + 0.02
    end
    if MissingHP > 0.65 then
        Runes = Runes + 0.02
    end
    if MissingHP > 0.75 then
        Runes = Runes + 0.02
    end
	return GetDamage(DMG, true, Target) * Runes + Stacks
end

function Draven:CheckBaseUlt()
	local Distance 					= Orbwalker:GetDistance(self.EnemyBase, myHero.Position)
	local GameTime					= GameClock.Time
	local TravelTime 				= (Distance / self.BaseRSpeed) + 0.5
	local HideTime                  = 0

	local Heros = ObjectManager.HeroList
	for I, Hero in pairs(Heros) do
		if Hero.Team ~= myHero.Team then
            local Tracker = Awareness.Tracker[Hero.Index]
			if Tracker then
                if Hero.IsVisible == false then
                    HideTime = Awareness:GetMapTimer(Hero)
                end
                if HideTime > self.BaseUltR_Visible.Value and self.BaseUltR_Visible.Value ~= 0 then return nil end

				local State = Tracker.Recall.State
				local Start = Tracker.Recall.StartTime
				local End 	= Tracker.Recall.EndTime
                if State == 6 and Start < End then
					local RDMG				= self:GetRDamage(Hero)
					local RecallTime 		= End - GameTime
                    print(RDMG)
					-- Everything calculated as health regenation ect
                    local HealthGeneration = (HideTime + 8) * ((10 + 1 * GetHeroLevel(Hero)) / 5)
					local enemyHP = Hero.Health + Hero.MaxHealth * 0.025 + HealthGeneration
					if RecallTime > 0 and RDMG > enemyHP and TravelTime >= RecallTime and TravelTime < (RecallTime + 0.75) then
                        --print("HideTime: ", HideTime, " > ", "BaseUltR_Visible:",self.BaseUltR_Visible.Value )
                        self.RTarget = Hero
                        if self.RTimer == nil then
                            self.RTimer = GameClock.Time
                        else
                            if (GameClock.Time - self.RTimer) > self.BaseUltR_Time.Value * 60 then
                                self.RTimer = GameClock.Time
                            end
                        end
                        self.RAmount = self.RAmount + 1
						return true
					end
				end
            end
		end
	end
	return false
end

function Draven:ManageQDamage()
    local QBuff     = myHero.BuffData:GetBuff("DravenSpinningAttack")
    --print(Orbwalker.ExtraDamage)
    if QBuff.Count_Alt > 0 then
        local QLevel = myHero:GetSpellSlot(0).Level
        if QLevel > 0 then
            local DamagePerLevel = {40 , 45 , 50 , 55, 60}
            local DamagePerLevelMod = {0.75 , 0.85 , 0.95 , 1.05 , 1.15}
            Orbwalker.ExtraDamage = DamagePerLevel[QLevel] + (myHero.BonusAttack*DamagePerLevelMod[QLevel])
        end
    else
        Orbwalker.ExtraDamage = 0
    end 
end

function Draven:AntiGapclose()
    if Engine:SpellReady("HK_SPELL3") and self.AntigapcloseE.Value == 1 then
		local Heros = ObjectManager.HeroList
		for I, Hero in pairs(Heros) do
			if Hero.Team ~= myHero.Team and Hero.IsTargetable then
                local HeroDistance      = Orbwalker:GetDistance(myHero.Position, Hero.Position)
                local TargetDistance    = Orbwalker:GetDistance(myHero.Position, Hero.AIData.TargetPos)
				if TargetDistance < Orbwalker.OrbRange and TargetDistance < HeroDistance and Hero.AIData.Dashing == true then
                    Engine:CastSpell("HK_SPELL3",Hero.AIData.TargetPos, 1)	
                    return								 
				end
			end
		end
    end		
end

function Draven:OnTick()
    Orbwalker.MovePosition = nil
    self:ManageQDamage()
    self.DravenAxes = self:SortAxes(self:FindAxes())

    if self.RTarget and Engine:SpellReady("HK_SPELL4") then
        local DravenR = Draven:FindR() --self.EnemyBase
        if DravenR then
            if Orbwalker:GetDistance(DravenR.Position, self.RTarget.Position) < 150 or Orbwalker:GetDistance(DravenR.Position, self.EnemyBase) < 850 then
                return Engine:CastSpell("HK_SPELL4",nil, 0)
            end
        end
    end

    if GameHud.Minimized == false and GameHud.ChatOpen == false and Orbwalker.Attack == 0 then
        self:AntiGapclose()
        if Engine:IsKeyDown("HK_COMBO") then
            self:QWER("Combo")
		end
        if Engine:IsKeyDown("HK_HARASS") then
            self:QWER("Harass")
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            self:Laneclear()
		end
		if Engine:IsKeyDown("HK_LASTHIT") then
            self:Lasthit()
        end
        if self.BaseUltR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
			if self:CheckBaseUlt() == true then
                local Stacks        = myHero.BuffData:GetBuff("dravenpassivestacks").Count_Int
                local Target        = Orbwalker:GetTarget("Combo", 750)
                if self.BaseUltRENear.Value == 1 and Target then return nil end
                --print("1Check")
                if self.BaseUltR_Stacks.Value ~= 0 and self.BaseUltR_Stacks.Value > Stacks then return nil end
                --print("2Check")
                --if self.RTimer then
                    --print("RTimer: ", (GameClock.Time - self.RTimer) / 60, " < ", "BaseUltR_Time:",self.BaseUltR_Time.Value )
                --end
                --if self.BaseUltR_Time.Value ~= 0 and self.RTimer ~= nil and (GameClock.Time - self.RTimer) < self.BaseUltR_Time.Value * 60 then return nil end
                --print("3Check")
                --if self.RAmount then
                    --print("RAmount: ", self.RAmount, " > ", "BaseUltR_Amount:",self.BaseUltR_Amount.Value )
                --end
                --if self.BaseUltR_Amount.Value ~= 0 and self.RAmount ~= nil and self.RAmount > self.BaseUltR_Amount.Value then return nil end
				self:CastRToEnemyBase()
			end
		end
    end
    --Draven:RunGif(self.TextArtGif)
end

function Draven:OnDraw()
    if myHero.IsDead == true then return end
    if #self.DravenAxes > 0 and self.DrawQ.Value == 1 then
        for _, Axe in pairs(self.DravenAxes) do
            Render:DrawCircle(Axe.MissileEndPos, 100 ,255,155,0,255)
        end
    end
    local CatchQRange   = self.CatchQRange.Value
    local MousePos = GameHud.MousePos
    if self.QCatchRange.Value == 1 and MousePos and CatchQRange > 0 then
        Render:DrawCircle(MousePos, CatchQRange ,255,0,247,255)
    end
    if self.DrawE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        Render:DrawCircle(myHero.Position, self.ERange ,255,155,0,255)
    end
end

function Draven:OnLoad()
    if myHero.ChampionName ~= "Draven" then return end
    AddEvent("OnSettingsSave" , function() Draven:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Draven:LoadSettings() end)
    Draven:__init()
    AddEvent("OnTick", function() Draven:OnTick() end)
    AddEvent("OnDraw", function() Draven:OnDraw() end)
    --print("")
    --print("")
    --print("")
    --print("")
    --print(self.Picture)
end

AddEvent("OnLoad", function() Draven:OnLoad() end)