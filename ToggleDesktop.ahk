#SingleInstance,Force
#NoEnv
CoordMode,Mouse,Screen
DetectHiddenWindows,On
OnExit,EXIT
Gosub,TRAYMENU

desktopHidden = 0
windowTitle=Team Fortress 2

Control & NumpadMult::
    If desktopHidden = 1
    {
        Gui,98:Destroy
        WinShow,Program Manager
        WinShow,ahk_class Shell_TrayWnd
        WinShow,ahk_class Button
        desktopHidden := !desktopHidden
    }
    else
    {
        IfWinExist,%windowTitle%
        {
            WinHide,Program Manager
            WinHide,ahk_class Shell_TrayWnd
            WinHide,ahk_class Button
            
            Gui,98:Destroy
            Gui,98:+ToolWindow -Border -caption 
            Gui,98:Color,Black
            Gui,98:Show,x0 y0 w%A_ScreenWidth% h%A_ScreenHeight%, cover 
            
            WinActivate,%windowTitle%
            WinSet,AlwaysOnTop,on,%windowTitle%
            desktopHidden := !desktopHidden
        }
        else
        { 
            Gui,97:Destroy
            Gui,97:Margin,20,20
            Gui,97:Font
            Gui,97:Add,Text,y+10 yp+10,%windowTitle% is not running!
            Gui,97:Show,,Error
        }
    }
Return

TRAYMENU:
    Menu,Tray,Click,1 
    Menu,Tray,NoStandard 
    Menu,Tray,DeleteAll 
    Menu,Tray,Add,E&xit,EXIT
    Menu,Tray,Tip,ToggleDesktop %_program_version%
Return

97GuiClose:
	Gui,97:Destroy
Return

EXIT:
    Gui,97:Destroy
    Gui,98:Destroy
    Gui,99:Destroy
    WinShow,Program Manager
    WinShow,ahk_class Shell_TrayWnd
    WinShow,ahk_class Button
    ExitApp
