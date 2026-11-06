@echo off
rem Usage: run.sim.bat hs_ctrl or run_sim.bat muller_c
set ROOT=%~dp0..
set TB=%1
if "%TB%"=="" set TB=hs_ctrl

if not exist "%ROOT%\build" mkdir "%ROOT%\build"

iverilog -o "%ROOT%\build\%TB%.vvp" "%ROOT%\rtl\muller_c.v" "%ROOT%\rtl\hs_ctrl.v" "%ROOT%\tb\%TB%_tb.v
if errorlevel 1 goto end
vvp "%ROOT%\build\%TB%.vvp"
:end
pause
