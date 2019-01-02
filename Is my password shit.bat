@echo off
	cd /D "%~dp0"
	(
		echo Created lib folder for dictionaries...
		if not exist "lib" mkdir lib
	)
	cls
:start
	echo Hey, welcome to my trash tool for checking if your password is secure, 
	echo feel free to add more dictionaries into the dictionaries folder or grab them
	echo with the HTML option!
	echo.
	echo if your password is trash it'll display it, or others similar on the screen
	echo if it appears I'd recommend changing it for your safety.
	echo.
	echo This program can pull any .txt file provided it is accessable publically, you know, incase
	echo you wanted to use one from the internet.
	echo.
	echo This piece of trash was created by Magnus Hellstrom,
	echo Add me on discord at Trazyn the Infinite#8665 if you got any questions, tho this is simple af anyway.
	echo so I doubt you'd have any.
	echo.
	pause
	cls
	goto :update
:afterupdate
	cls
	echo Please enter a string to search the lib folder for, this will display results similar in addition:
	
	SET /P _inputstring=
	(
		echo %_inputstring%
	) >> lib\_inputstringlog.ini
	
	FINDSTR -s "\<%_inputstring%\>" lib\*.txt
	
	IF %ERRORLEVEL%==0 (
		goto :error0
	)
	IF %ERRORLEVEL%==1 (
		goto :error1
	)
	IF %ERRORLEVEL%==2 (
		goto :error2
	)

:error0
	echo.
	echo.
	echo.
	echo Change that fucker right now.
	pause
	goto :choice

:error1
	echo File/String Not found, congrats!
	pause
	goto :choice

:error2
	echo Syntax Error, how the fuck did you break it?
	pause
	goto :choice
	
:userupdatechoice
cls
CHOICE /C ABC /M "Would you like to use a HTML link, a File Path or go back?"
	IF %ERRORLEVEL%==1 (
		goto :userupdatehtml
	)	
	IF %ERRORLEVEL%==2 (
		goto :userupdatepath
	)
	IF %ERRORLEVEL%==3 (
		goto :update
	)
	
:userupdatehtml
cls
	CHOICE /C YN /M "Grab your own library from a HTML link?"
	IF %ERRORLEVEL%==1 (
		cls
		echo Please enter a HTML link to grab the dict.
		(
			powershell -Command "Invoke-WebRequest %_link% -OutFile default.txt"
		)
		echo Name the file please.
		SET /P _name=
		rename default.txt %_name%.txt
		Echo n|MOVE /y %name%.txt lib\
		IF %ERRORLEVEL%==0 (
			echo Something went wrong!
			pause
			goto :afterupdate
		)
		echo Processed, press any button to restart.
		pause
		call "Is my password shit.bat"
		goto :eof
	)
	IF %ERRORLEVEL%==2 (
		goto :afterupdate
	)
	
:userupdatepath
	CHOICE /C YN /M "Grab your own dict from your PC?"
	IF %ERRORLEVEL%==1 (
		cls
		echo Please paste in the path link, the script will grab whatever it is targeted at.
		SET /P _filepath=
		echo And now the target filename and extension, for example, dict.txt
		set /p _filename=
		MOVE /y "%_filepath%\%_filename%" lib\
		IF %ERRORLEVEL%==1 (
			echo Something went wrong!
			pause
			goto :update
		)
		echo Success!, press any button to restart.	
		pause
		call "Is my password shit.bat"
	)
	IF %ERRORLEVEL%==2 (
		goto :afterupdate
	)
	
:update
	cls
	CHOICE /C ABC /M "Grab the latest dictionary file from the server, Grab a library from your own source or skip this step entirely?"
	IF %ERRORLEVEL%==1 (
		echo Grabbing latest dict file...
		(
			powershell -Command "Invoke-WebRequest https://dl.dropboxusercontent.com/s/k8j1hvz20pnrssx/unified_dict.txt?dl=0 -OutFile unified_dict.txt"
		)
		Echo n|MOVE /y unified_dict.txt lib\
		echo Success!, press any button to restart.	
		pause
		call "Is my password shit.bat"
	)
	
	IF %ERRORLEVEL%==2 (
		goto :userupdatechoice
	)
	
	IF %ERRORLEVEL%==3 (
		goto :afterupdate
	)

:Choice
	cls
	CHOICE /C YN /M "Would you like to do another?"
	IF %ERRORLEVEL%==1 (
		cls
		goto :afterupdate
	)
	IF %ERRORLEVEL%==2 (
		goto :eof
	)
	//FINDSTR -s %_inputstring% lib\*.txt