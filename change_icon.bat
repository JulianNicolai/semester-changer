:: Programmed by Julian Nicolai, April 27th 2020

@echo off
mode con: cols=100 lines=9
setlocal EnableDelayedExpansion

set "data_file=%cd%\data.txt"
set def=0
if not exist "%data_file%" @echo %def% > "%data_file%"
set /p old_season=<"%data_file%"
:: fall season:   0
:: winter season: 1
:: summer season: 2

set "current_term_folder=%userprofile%\Documents\Personal Documents\School Documents\Current Term"
set "class_folders_root=%userprofile%\Documents\Personal Documents\School Documents"
set "icons=%userprofile%\Pictures\Misc\Icons"

set "fall=%icons%\fall_sem.ico"
set "winter=%icons%\winter_sem.ico"
set "summer=%icons%\summer_sem.ico"
set "month=%date:~5,2%"
set /a year=%date:~0,4%
set /a year_add1=%year% + 1
set /a year_sub1=%year% - 1

:loop
for %%G in (09,10,11,12) do (
    if %month% == %%G (
        set "season=%fall%"
        set current_season=0
        :: echo fall semester
        goto set_icon
    )
)
for %%G in (01,02,03,04) do (
    if %month% == %%G (
        set "season=%winter%"
        set current_season=1
        :: echo winter semester
        goto set_icon
    )
)
for %%G in (05,06,07,08) do (
    if %month% == %%G (
        set "season=%summer%"
        set current_season=2
        ::echo summer semester
        goto set_icon
    )
)

:set_icon
if not !old_season! == !current_season! (
    goto changing
) else (
    goto same
)

:changing

set old_season=!current_season!
@echo !old_season!>"%data_file%"

::echo season change

attrib -h -s "%current_term_folder%\desktop.ini" 2>nul 
(
echo/[.ShellClassInfo]
echo/IconResource="%season%",0
echo/[ViewState]
echo/Mode=
echo/Vid=
echo/FolderType=Documents
) > "%current_term_folder%\desktop.ini"

attrib +h +s +a "%current_term_folder%\desktop.ini"

::echo icon updated, moving directories

set /a year_add1=%year% + 1
set /a year_sub1=%year% - 1

::echo %current_season%
::echo %class_folders_root%

if !current_season! == 0 (
    set "current_class_folders=%class_folders_root%\%year%-%year_add1%\Fall"
) else if !current_season! == 1 (
    set "current_class_folders=%class_folders_root%\%year_sub1%-%year%\Winter"
) else if !current_season! == 2 (
    set "current_class_folders=%class_folders_root%\%year_sub1%-%year%\Summer"
)

if not exist "%current_class_folders%" md "%current_class_folders%"

set /a last_season=%current_season% - 1

if !last_season! == -1 set last_season=2
if !last_season! == 0 set /a year-=1

set /a year_add1=%year% + 1
set /a year_sub1=%year% - 1

if !last_season! == 0 (
    set "last_class_folders=%class_folders_root%\%year%-%year_add1%\Fall"
) else if !last_season! == 1 (
    set "last_class_folders=%class_folders_root%\%year_sub1%-%year%\Winter"
) else if !last_season! == 2 (
    set "last_class_folders=%class_folders_root%\%year_sub1%-%year%\Summer"
)

::echo %last_class_folders%
::echo %current_class_folders%

robocopy /move /e "%current_term_folder%" "%last_class_folders%"  /NFL /NDL /NJH /NJS /np /XF "%current_term_folder%\desktop.ini"
robocopy /move /e "%current_class_folders%" "%current_term_folder%" /NFL /NDL /NJH /NJS /np /XF "%current_class_folders%\desktop.ini"
if not exist "%current_class_folders%" md "%current_class_folders%"

title NOTICE OF CHANGES
cls
echo.
echo The current semester has changed. The following has updated:
echo.
echo ^<^> Last semester files have been moved from the Current Term folder to their original destination. 
echo ^<^> Current semester files have been moved to your Current Term folder. 
echo ^<^> The Icon has been updated accordingly.
echo.
pause

:same