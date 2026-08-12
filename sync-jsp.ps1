# deploy.ps1 - Complete Auto Deploy Script
$tomcatWebapps = "C:\apache-tomcat-11.0.24\webapps\ebook"
$targetExploded = "target\Ebook-App-0.0.1-SNAPSHOT"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " 🚀 STARTING FULL BUILD & DEPLOYMENT " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# 1. Compile Java & Package War with Maven
Write-Host "📦 1. Compiling Java & Packaging with Maven..." -ForegroundColor Yellow
mvn clean package

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Build Failed! Check Java compiler errors above." -ForegroundColor Red
    exit
}

# 2. Check and Copy to Tomcat webapps
if (Test-Path $targetExploded) {
    Write-Host "📂 2. Deploying new files to Tomcat webapps..." -ForegroundColor Yellow
    
    # Remove old tomcat deployment if exists
    if (Test-Path $tomcatWebapps) {
        Remove-Item -Path $tomcatWebapps -Recurse -Force
    }

    # Copy new build folder to webapps and rename to 'ebook'
    Copy-Item -Path $targetExploded -Destination $tomcatWebapps -Recurse -Force
    
    Write-Host "========================================" -ForegroundColor Green
    Write-Host " SUCCESS! Project Deployed to Tomcat." -ForegroundColor Green
    Write-Host " Refresh Browser (Ctrl + F5): http://localhost:8080/ebook/admin/add_book_admin.jsp" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
}
else {
    Write-Host "❌ Target exploded folder not found!" -ForegroundColor Red
}