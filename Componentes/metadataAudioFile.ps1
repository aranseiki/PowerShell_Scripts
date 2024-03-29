﻿Set-ExecutionPolicy -Force Unrestricted -Confirm LocalMachine
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned 

Function Get-MP3MetaData 
{ 
    [CmdletBinding()] 
    [Alias()] 
    [OutputType([Psobject])] 
    Param 
    ( 
        [String] [Parameter(Mandatory=$true, ValueFromPipeline=$true)] $Directory 
    ) 
 
    Begin 
    { 
        $shell = New-Object -ComObject "Shell.Application" 
    } 
    Process 
    { 
 
        Foreach($Dir in $Directory) 
        { 
            $ObjDir = $shell.NameSpace($Dir) 
            $Files = gci $Dir| ?{$_.Extension -in '.mp3','.mp4'} 
 
            Foreach($File in $Files) 
            { 
                $ObjFile = $ObjDir.parsename($File.Name) 
                $MetaData = @{} 
                $MP3 = ($ObjDir.Items()|?{$_.path -like "*.mp3" -or $_.path -like "*.mp4"}) 
                $PropertArray = 0,1,2,12,13,14,15,16,17,18,19,20,21,22,27,28,36,220,223 
             
                Foreach($item in $PropertArray) 
                {  
                    If($ObjDir.GetDetailsOf($ObjFile, $item)) #To avoid empty values 
                    { 
                        $MetaData[$($ObjDir.GetDetailsOf($MP3,$item))] = $ObjDir.GetDetailsOf($ObjFile, $item) 
                    } 
                  
                } 
             
                New-Object psobject -Property $MetaData |select *, @{n="Directory";e={$Dir}}, @{n="Fullname";e={Join-Path $Dir $File.Name -Resolve}}, @{n="Extension";e={$File.Extension}} 
            } 
        } 
    } 
    End 
    { } 
} 
 
ForEach($item in ("D:\Nova pasta\Music\7!! (セブンウップス)\2013 - Doki Doki\01 Doki Doki.mp3" |Get-MP3MetaData)){ 
    $NewName = [regex]::Replace($(($item.Title).Split(":")[1].Trim() + $item.extension),"[*(/)\\]",{''}) 
    $Oldname = $item.Fullname 
    Rename-Item -LiteralPath $item.Fullname -NewName $NewName -Force 
}
