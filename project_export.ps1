$gameName = "RandomPixelArt"
$7z_path = "C:/Program Files/7-Zip/7z.exe"
$jsonData = (Get-Content ".vscode\settings.json" | ConvertFrom-Json)

$godot_path = $jsonData."godot_tools.editor_path"
# Write-Output($godot_path)

Remove-Item -LiteralPath "project_export/" -Force -Recurse
New-Item -ItemType File -Force -Path "./project_export/.gdignore"

# Windows export
New-Item -ItemType Directory -Force -Path "./project_export/windows"
Start-Process -FilePath $godot_path -ArgumentList "--verbose --export `"Windows Desktop`" $("project_export/windows/"+$gameName+".exe")" -Wait
Set-Location "./project_export/windows"
Start-Process -FilePath $7z_path -ArgumentList "a -mx=9 $("../"+$gameName+"_windows.zip") ./*" -NoNewWindow -Wait
Set-Location "../../"

# Linux Export
New-Item -ItemType Directory -Force -Path "project_export/linux"
Start-Process -FilePath $godot_path -ArgumentList "--verbose --export `"Linux/X11`" $("project_export/linux/"+$gameName+".x86_64")" -Wait
Set-Location "project_export/linux"
Start-Process -FilePath $7z_path -ArgumentList "a -mx=9 $("../"+$gameName+"_linux.zip") ./*" -NoNewWindow -Wait
Set-Location "../../"

# HTML5 Export
New-Item -ItemType Directory -Force -Path "./project_export/html5"
Start-Process -FilePath $godot_path -ArgumentList "--verbose --export `"HTML5`" $("project_export/html5/"+$gameName+".html")" -Wait
Set-Location "./project_export/html5"
Rename-Item -Path ($gameName + ".html") -NewName "index.html"
Start-Process -FilePath $7z_path -ArgumentList "a -mx=9 $("../"+$gameName+"_html5.zip") ./*" -NoNewWindow -Wait
Set-Location "../../"
