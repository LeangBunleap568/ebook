# sync-jsp.ps1
$source = "src/main/webapp"
$dest = "C:/path/to/your/tomcat/webapps/ebook" # Update with your actual Tomcat exploded webapp path

Write-Host "Syncing JSP/HTML/CSS files..." -ForegroundColor Cyan
Copy-Item -Path "$source\*" -Destination $dest -Recurse -Force
Write-Host "Sync complete!" -ForegroundColor Green