; --------------------------------
; github.com/cdown/toggledesktop.git
; --------------------------------

; toggledesktop
; Toggle desktop/taskbar visibility if application is running

; Copyright (c) 2011 Chris Down <cdown.uk@gmail.com>. 

; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <http://www.gnu.org/licenses/>.

; Setup
#SingleInstance,Force
#NoEnv
CoordMode,Mouse,Screen
DetectHiddenWindows,On
OnExit,EXIT
Gosub,TRAYMENU

; The window title you want to keep in the foreground (you can use this with other games by changing this to the window title of the game)
game_title=Team Fortress 2

; Desktop and taskbar visible on launch
WinShow,Program Manager
WinShow,ahk_class Shell_TrayWnd
WinShow,ahk_class Button

; Make first run hide desktop and taskbar
desktop_toggle = 1

Control & NumpadMult::
; Toggle hiding desktop/taskbar
If desktop_toggle = 0
{
	; If the black covering GUI exists, destroy it
	Gui,98:Destroy
	; Show the desktop and taskbar
	WinShow,Program Manager
	WinShow,ahk_class Shell_TrayWnd
	; Button is used on Windows 7/Vista as a start button class, doesn't have any effect on XP
	WinShow,ahk_class Button
	desktop_toggle := !desktop_toggle
}
else
{
	IfWinExist,%game_title%
	{
		; Hide the desktop and taskbar
		WinHide,Program Manager
		WinHide,ahk_class Shell_TrayWnd
		WinHide,ahk_class Button
		; Destroy covering GUI as a precaution (should not exist) and then create a new one
		Gui,98:Destroy
		Gui,98:+ToolWindow -Border -caption 
		Gui,98:Color,Black
		Gui,98:Show,x0 y0 w%A_ScreenWidth% h%A_ScreenHeight%, cover 
		; Bring to front
		WinActivate,%game_title%
		; For some reason WinSet,AlwaysOnTop doesn't work with TF2 but does with other windows
		; I will implement it here when I find a fix
		desktop_toggle := !desktop_toggle
	}
	else
	{ 
		Gui,97:Destroy
		Gui,97:Margin,20,20
		Gui,97:Font
		Gui,97:Add,Text,y+10 yp+10,%game_title% is not running!
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
Menu,Tray,Tip,ToggleDesktop v1.04
Return

ABOUT:
Gui,99:Destroy
Gui,99:Margin,20,20
Gui,99:Font,Bold
Gui,99:Add,Text,center w180,ToggleDesktop v1.04 by Chris
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