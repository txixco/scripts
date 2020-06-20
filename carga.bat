@echo off

for %%f in (%1) do (
  echo Cargando %%~nf
  echo sqlldr usrcobamex@cobdprod/3ktc0b4m3x! control=ta_enganches.ctl data=%%f log=%%~nf.log skip=1
)

pause
