# deploy.ps1 - Clean Auto Deploy Script
$tomcatWebapps = "C:\apache-tomcat-11.0.24\webapps\ebook"
$targetExploded = "target\Ebook-App-0.0.1-SNAPSHOT"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " STARTING FULL BUILD AND DEPLOYMENT " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# 1. Compile Java and Package War with Maven
Write-Host "1. Compiling Java and Packaging with Maven..." -ForegroundColor Yellow
mvn clean package

if ($LASTEXITCODE -ne 0) {
    Write-Host "Build Failed! Check Java compiler errors above." -ForegroundColor Red
    exit
}

# 2. Check and Copy to Tomcat webapps
if (Test-Path $targetExploded) {
    Write-Host "2. Deploying new files to Tomcat webapps..." -ForegroundColor Yellow
    
    # Backup uploaded book images before wiping old deployment
    $bookImagesPath = "$tomcatWebapps\book"
    $tempBackup = "$env:TEMP\ebook_book_backup"
    if (Test-Path $bookImagesPath) {
        Write-Host "   Backing up uploaded book images..." -ForegroundColor Cyan
        if (Test-Path $tempBackup) { Remove-Item -Path $tempBackup -Recurse -Force }
        Copy-Item -Path $bookImagesPath -Destination $tempBackup -Recurse -Force
    }

    # Remove old tomcat deployment if exists
    if (Test-Path $tomcatWebapps) {
        Remove-Item -Path $tomcatWebapps -Recurse -Force
    }

    # Copy new build folder contents to webapps/ebook
    if (!(Test-Path $tomcatWebapps)) {
        New-Item -ItemType Directory -Force -Path $tomcatWebapps
    }
    Copy-Item -Path "$targetExploded\*" -Destination $tomcatWebapps -Recurse -Force

    # Restore backed-up book images
    if (Test-Path $tempBackup) {
        Write-Host "   Restoring uploaded book images..." -ForegroundColor Cyan
        Copy-Item -Path $tempBackup -Destination $bookImagesPath -Recurse -Force
        Remove-Item -Path $tempBackup -Recurse -Force
    }
    
    Write-Host "========================================" -ForegroundColor Green
    Write-Host " SUCCESS! Project Deployed to Tomcat." -ForegroundColor Green
    Write-Host " Refresh Browser (Ctrl + F5): http://localhost:8080/ebook/admin/add_book_admin.jsp" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
}
else {
    Write-Host "Target exploded folder not found!" -ForegroundColor Red
}