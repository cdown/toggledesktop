; vim: set expandtab ts=4 sw=4 autoindent smartindent:

; git://github.com/cdown/toggledesktop.git

; toggledesktop
; Toggle desktop/taskbar visibility if application is running

; Copyright (c) 2011 Chris Down < base64 -d <<< Y2Rvd24udWtAZ21haWwuY29tCg== >
; This is free software under a 2-clause BSD license; see the COPYING file for
; copying conditions. There is NO warranty; not even for MERCHANTABILITY or
; FITNESS FOR A PARTICULAR PURPOSE.

_program_version=1.06

#SingleInstance,Force
#NoEnv
CoordMode,Mouse,Screen
DetectHiddenWindows,On
OnExit,EXIT
Gosub,TRAYMENU

; The window title you want to monitor
_game_title=Team Fortress 2

; Make first run hide desktop and taskbar
_desktop_hide = 1

Control & NumpadMult::
; Toggle hiding desktop/taskbar
If _desktop_hide = 0
{
	; If the black covering GUI exists, destroy it
	Gui,98:Destroy
	; Show the desktop and taskbar
	WinShow,Program Manager
	WinShow,ahk_class Shell_TrayWnd
	; Button is used on Windows 7/Vista as a start button class, doesn't have any effect on XP
	WinShow,ahk_class Button
	_desktop_hide := !_desktop_hide
}
else
{
	IfWinExist,%_game_title%
	{
		; Hide the desktop and taskbar
		WinHide,Program Manager
		WinHide,ahk_class Shell_TrayWnd
		WinHide,ahk_class Button
		; Destroy covering GUI as a precaution (this should not happen) and then create a new one
		Gui,98:Destroy
		Gui,98:+ToolWindow -Border -caption 
		Gui,98:Color,Black
		Gui,98:Show,x0 y0 w%A_ScreenWidth% h%A_ScreenHeight%, cover 
		; Bring to front
		WinActivate,%_game_title%
		WinSet,AlwaysOnTop,on,%_game_title%
		_desktop_hide := !_desktop_hide
	}
	else
	{ 
		Gui,97:Destroy
		Gui,97:Margin,20,20
		Gui,97:Font
		Gui,97:Add,Text,y+10 yp+10,%_game_title% is not running!
		Gui,97:Show,,Error
	}
}
Return

; GUI
TRAYMENU:
Menu,Tray,Click,1 
Menu,Tray,NoStandard 
Menu,Tray,DeleteAll 
Menu,Tray,Add,&About...,ABOUT
Menu,Tray,Add,E&xit,EXIT
Menu,Tray,Tip,ToggleDesktop %_program_version%
Return

ABOUT:
Gui,99:Destroy
Gui,99:Margin,20,20
Gui,99:Font,Bold
Gui,99:Add,Text,center w180,ToggleDesktop %_program_version% by Chris
Gui,99:Font
Gui,99:Add,Text,center w180 yp+17,http://fakkelbrigade.eu/chris/
Gui,99:Show,,About
Return

; On GUI closure
97GuiClose:
	Gui,97:Destroy
Return

99GuiClose:
	Gui,99:Destroy
Return

; Operations on graceful exit
EXIT:
Gui,97:Destroy
Gui,98:Destroy
Gui,99:Destroy
WinShow,Program Manager
WinShow,ahk_class Shell_TrayWnd
WinShow,ahk_class Button
ExitApp
