@ECHO OFF
SETLOCAL EnableDelayedExpansion
FOR /f "delims=" %%x IN (tracks.cfg) DO (SET line=%%x & IF NOT "!line:~0,1!" == "#" SET "%%x")

ECHO Chrono Trigger MSU-1 Conversion Script By Qwertymodo

IF NOT EXIST output MKDIR output

bin\sox "!TRACK50FILE!" -r 44.1k output\track-50_noscream.wav gain -h -1 trim !TRACK50START!s =!TRACK50TRIM!s
bin\sox LavosScream.wav -r 44.1k output\track-50_scream.wav gain -n -6
FOR %%f IN ("!TRACK50FILE!") DO SET TRACK50FILE=output\%%~nxf
bin\sox output\track-50_scream.wav output\track-50_noscream.wav -r 44.1k "!TRACK50FILE!" gain -h -1

SET /A TRACK50LOOP=!TRACK50LOOP!-!TRACK50START!
SET /A TRACK50TRIM=!TRACK50TRIM!-!TRACK50START!
SET TRACK50START=
SET /A TRACK50LOOP=!TRACK50LOOP!+!TRACK50INTRO!
SET /A TRACK50TRIM=!TRACK50TRIM!+!TRACK50INTRO!
DEL output\track-50*.wav

bin\sox "!TRACK84FILE!" -r 44.1k output\track-84_intro.wav gain -h -1 trim !TRACK84START!s =!TRACK84LOOP!s
bin\sox "!TRACK84FILE!" -r 44.1k output\track-84_abloop.wav gain -h -1 trim !TRACK84LOOP!s =!TRACK84TRIM!s
bin\sox "!TRACK84FILE!" -r 44.1k output\track-84_ending.wav gain -h -1 trim !TRACK84TRIM!s
FOR %%f IN ("!TRACK84FILE!") DO SET TRACK84FILE=output\%%~nxf
bin\sox output\track-84_intro.wav output\track-84_abloop.wav output\track-84_abloop.wav output\track-84_ending.wav -r 44.1k "!TRACK84FILE!"

SET TRACK84START=
SET TRACK84LOOP=
SET TRACK84TRIM=
DEL output\track-84*.wav

FOR /l %%i IN (1,1,%NUMTRACKS%) DO (
    IF "!TRACK%%iFILE!" == "" SET TRACK%%iFILE=%TRACKPREFIX%-%%i.%INPUTFILETYPE%
    IF EXIST "!TRACK%%iFILE!" (
        FOR %%f IN ("!TRACK%%iFILE!") DO SET TRACK%%iTITLE=%%~nf
        FOR /F "tokens=2 delims=-" %%t IN ("!TRACK%%iTITLE!") DO ECHO Track %%i: %%t
        
        IF "!TRACK%%iLOOP!" == "" SET TRACK%%iLOOP=0
        
        IF NOT "!TRACK%%iCROSSFADE!" == "" (
            SET /A TRACK%%iCROSSFADEASTART=!TRACK%%iTRIM!-!TRACK%%iCROSSFADE!
            SET /A TRACK%%iCROSSFADEBSTART=!TRACK%%iLOOP!-!TRACK%%iCROSSFADE!
            SET /A TRACK%%iCROSSFADEOUT=!TRACK%%iCROSSFADE!/2

            bin\sox "!TRACK%%iFILE!" -r 44.1k output\__track-%%i.wav ^
                gain -h -1 rate trim 0 =!TRACK%%iTRIM!s ^
                fade t 0 !TRACK%%iTRIM!s !TRACK%%iCROSSFADEOUT!s
            bin\sox "!TRACK%%iFILE!" -r 44.1k output\__track-%%i_crossfade.wav ^
                gain -h -1 rate trim !TRACK%%iCROSSFADEBSTART!s =!TRACK%%iLOOP!s ^
                fade t !TRACK%%iCROSSFADE!s pad !TRACK%%iCROSSFADEASTART!s
            FOR %%f IN ("!TRACK%%iFILE!") DO SET TRACK%%iFILE=output\___track-%%i.wav
            bin\sox -m output\__track-%%i.wav output\__track-%%i_crossfade.wav "!TRACK%%iFILE!" gain -h -1

            DEL output\__track-%%i*.wav
        )
        
        IF "!OUTPUTPREFIX!" == "" (SET OUTPUTNAME=!TRACK%%iTITLE!) ELSE (SET OUTPUTNAME=%OUTPUTPREFIX%-%%i)

        IF "!TRACK%%iNORMALIZATION!" == "" SET TRACK%%iNORMALIZATION=%NORMALIZATION%
        IF "!TRACK%%iSTART!" == "" (SET TRACK%%iSTART=0s) ELSE (SET DOTRIM=1 & SET /A TRACK%%iLOOP=!TRACK%%iLOOP!-!TRACK%%iSTART! & SET TRACK%%iSTART=!TRACK%%iSTART!s)
        IF NOT "!TRACK%%iTRIM!" == "" SET DOTRIM=1 & SET TRACK%%iTRIM==!TRACK%%iTRIM!s
        
        IF DEFINED DOTRIM SET TRACK%%iTRIM=rate trim !TRACK%%iSTART! !TRACK%%iTRIM!

        bin\sox.exe !TRACK%%iFORMAT! "!TRACK%%iFILE!" -e signed-integer -L -r 44.1k -b 16 "output\!OUTPUTNAME!.wav" gain -h -1 !TRACK%%iTRIM! !TRACK%%iEFFECTS! !EFFECTS!

        IF NOT "!TRACK%%iNORMALIZATION!" == "" bin\normalize.exe -a !TRACK%%iNORMALIZATION!dBFS "output\!OUTPUTNAME!.wav" 2> NUL

        SET TRACK%%iLOOP=-l !TRACK%%iLOOP!

        bin\wav2msu.exe "output\!OUTPUTNAME!.wav" !TRACK%%iLOOP!

        DEL "output\!OUTPUTNAME!.wav"
        IF EXIST "output\___track-%%i.wav" DEL "output\___track-%%i.wav"
    )
)

DEL "!TRACK50FILE!"
DEL "!TRACK84FILE!"