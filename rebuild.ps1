# Build and Deploy Script
$projectDir = "C:\Users\ADMIN\Desktop\ebook"
$tomcatDir = "C:\Users\ADMIN\.rsp\redhat-community-server-connector\runtimes\installations\tomcat-10.1.23\apache-tomcat-10.1.23"
$env:CATALINA_HOME = $tomcatDir

Write-Host "[BUILD] Building project..." -ForegroundColor Cyan

# Try different Maven locations
$mvnPaths = @(
    "C:\Users\ADMIN\.maven\maven-3.9.15\bin\mvn.cmd",
    "C:\Users\ADMIN\.maven\maven-3.10.0-rc-1\bin\mvn.cmd",
    "C:\Tools\apache-maven-3.9.9\bin\mvn.cmd",
    "C:\Program Files\Apache\Maven\bin\mvn.cmd",
    "C:\Program Files (x86)\Apache\Maven\bin\mvn.cmd"
)

$mvnFound = $false
foreach ($mvnPath in $mvnPaths) {
    if (Test-Path $mvnPath) {
        Write-Host "Found Maven at: $mvnPath" -ForegroundColor Green
        & $mvnPath clean package -DskipTests -f $projectDir\pom.xml
        $mvnFound = $true
        break
    }
}

if (-not $mvnFound) {
    Write-Host "Maven not found in any known path!" -ForegroundColor Red
    exit 1
}

if ($LASTEXITCODE -ne 0) {
    Write-Host "[FAIL] Build failed!" -ForegroundColor Red
    exit 1
}

Write-Host "[OK] Build successful!" -ForegroundColor Green

# Deploy - find the WAR file dynamically
Write-Host "[DEPLOY] Deploying to Tomcat..." -ForegroundColor Cyan

$war = Get-ChildItem "$projectDir\target\*.war" | Select-Object -First 1
if ($war) {
    Write-Host "Found WAR: $($war.Name)" -ForegroundColor Green
    Remove-Item "$tomcatDir\webapps\ebook" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "$tomcatDir\webapps\ebook.war" -Force -ErrorAction SilentlyContinue
    Copy-Item $war.FullName -Destination "$tomcatDir\webapps\ebook.war" -Force

    Write-Host "[STOP] Stopping Tomcat..." -ForegroundColor Cyan
    & "$tomcatDir\bin\shutdown.bat" 2>$null
    Start-Sleep -Seconds 3

    Write-Host "[START] Starting Tomcat..." -ForegroundColor Cyan
    & "$tomcatDir\bin\startup.bat"
    Start-Sleep -Seconds 8

    Write-Host "[OK] Deployment complete!" -ForegroundColor Green
    Write-Host "Try: http://localhost:8080/ebook/register.jsp" -ForegroundColor Yellow
} else {
    Write-Host "[FAIL] No WAR file found in $projectDir\target\" -ForegroundColor Red
    exit 1
}
