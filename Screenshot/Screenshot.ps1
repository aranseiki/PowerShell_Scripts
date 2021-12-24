$screen = [System.Windows.Forms.SystemInformation]::VirtualScreen
$width = [System.Windows.Forms.SystemInformation]::VirtualScreen.Width
$height = [System.Windows.Forms.SystemInformation]::VirtualScreen.Height
$left = [System.Windows.Forms.SystemInformation]::VirtualScreen.Left
$top = [System.Windows.Forms.SystemInformation]::VirtualScreen.Top
$bitmap = New-Object System.Drawing.Bitmap $width, $height
$graphic = [System.Drawing.Graphics]::FromImage($bitmap)
$graphic.CopyFromScreen( $left, $top, 0, 0, $bitmap.Size)
$File = '.\New Bitmap Image.bmp'
$bitmap.Save($File)