@echo off

set DOWNLOADS=%UserProfile%\downloads\
set POSTGRES="https://drive.google.com/uc?export=download&confirm=t&id=15KmNWi82l0YJxmTVF9yCu0tCrkvGadSG"
set RUBYROOT=C:\Ruby30-x64

:: UTIL ENVIRONMENT 
setx PATH "C:\Program Files\PostgreSQL\12\bin;"%path%
setx PGDATABASE postgres
setx PGUSER postgres

cls

for /F "tokens=1,2,3 delims=<>" %%a in (programas.txt) do (
  if exist %%b (
    echo "Ya tienes el programa %%c"
  )else (
      if exist %USERPROFILE%%%b (
	echo "Ya tienes el programa %%c"
      ) else ( 
      http.exe -c --no-check-certificate %%a -O %DOWNLOADS%setup.exe
      if %%a == %POSTGRES% (
        %DOWNLOADS%setup.exe --mode unattended --debuglevel 0 --disable-components pgAdmin,stackbuilder --superpassword postgres
      )else (
        %DOWNLOADS%setup.exe /ALLUSERS /SILENT /SP- /NOCANCEL /NORESTART /CLOSEAPPLICATIONS 
      )
      DEL /F /A %DOWNLOADS%setup.exe
    )
  )
)

if exist %RUBYROOT%\bin\gem.cmd (%RUBYROOT%\bin\gem.cmd install rails --no-document) else (
  echo "No tienes ruby instalado"
)

echo "Proceso completado. Presiona Enter para salir..."
pause>nul
