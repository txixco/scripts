@ECHO OFF

2>NUL CALL :CASE_%1
IF ERRORLEVEL 1 CALL :DEFAULT_CASE

EXIT /B

:CASE_STOP
  NET STOP vpnagent
  GOTO END_CASE
:CASE_START
  NET START vpnagent
  START "" "C:\Program Files (x86)\Cisco\Cisco AnyConnect Secure Mobility Client\vpnui.exe"
  GOTO END_CASE
:DEFAULT_CASE
  ECHO Unknown option, it should be START or STOP
  GOTO END_CASE
:END_CASE
  VER > NUL # reset ERRORLEVEL
  GOTO :EOF # return from CALL
