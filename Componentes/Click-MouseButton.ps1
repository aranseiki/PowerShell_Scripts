function Click-MouseButton($MouseCode) {
    
    $signature=@' 
      [DllImport("user32.dll",CharSet=CharSet.Auto, CallingConvention=CallingConvention.StdCall)]
      public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);
'@ 

    $SendMouseClick = Add-Type -memberDefinition $signature -name "Win32MouseEventNew" -namespace Win32Functions -passThru 
        
        if ( $MouseCode.ToUpper() -eq 'MOVED' ) {
            
            $SendMouseClick::mouse_event(0x00000001, 0, 0, 0, 0); # 左ボタン Moved

        } elseif ( $MouseCode.ToUpper() -eq 'LEFT' ) {
            
            $SendMouseClick::mouse_event(0x00000002, 0, 0, 0, 0); # 左ボタン Down
            $SendMouseClick::mouse_event(0x00000004, 0, 0, 0, 0); # 左ボタン Up

        } elseif ( $MouseCode.ToUpper() -eq 'RIGHT' ) {
            
            $SendMouseClick::mouse_event(0x00000008, 0, 0, 0, 0); # 左ボタン Down
            $SendMouseClick::mouse_event(0x00000010, 0, 0, 0, 0); # 左ボタン Up

        } elseif ( $MouseCode.ToUpper() -eq 'MIDDLE' ) {

            $SendMouseClick::mouse_event(0x00000020, 0, 0, 0, 0); # 左ボタン Down
            $SendMouseClick::mouse_event(0x00000040, 0, 0, 0, 0); # 左ボタン Up

        } elseif ( $MouseCode.ToUpper() -eq 'WHEEL' ) {
            
            $SendMouseClick::mouse_event(0x00000080, 0, 0, 0, 0); # 左ボタン Wheel

        } elseif ( $MouseCode.ToUpper() -eq 'XDOWN' ) { 

            $SendMouseClick::mouse_event(0x00000100, 0, 0, 0, 0); # 左ボタン XDown

        } elseif ( $MouseCode.ToUpper() -eq 'XUP' ) {

            $SendMouseClick::mouse_event(0x00000200, 0, 0, 0, 0); # 左ボタン XUp

        } elseif ( $MouseCode.ToUpper() -eq 'ABSOLUTE' ) {
            
            $SendMouseClick::mouse_event(0x00008000, 0, 0, 0, 0); # 左ボタン Absolute

        }

}


Clear-Host

$MouseCode = 'left'
sleep 10 | Click-MouseButton($MouseCode)

Click-MouseButton($MouseCode)

<#
    MOUSEEVENTF_MOVED      = 0x0001 ;
    MOUSEEVENTF_LEFTDOWN   = 0x0002 ;  # 左ボタン Down
    MOUSEEVENTF_LEFTUP     = 0x0004 ;  # 左ボタン Up
    MOUSEEVENTF_RIGHTDOWN  = 0x0008 ;  # 右ボタン Down
    MOUSEEVENTF_RIGHTUP    = 0x0010 ;  # 右ボタン Up
    MOUSEEVENTF_MIDDLEDOWN = 0x0020 ;  # 中ボタン Down
    MOUSEEVENTF_MIDDLEUP   = 0x0040 ;  # 中ボタン Up
    MOUSEEVENTF_WHEEL      = 0x0080 ;
    MOUSEEVENTF_XDOWN      = 0x0100 ;
    MOUSEEVENTF_XUP        = 0x0200 ;
    MOUSEEVENTF_ABSOLUTE   = 0x8000 ;
#>