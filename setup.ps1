# Library Management System Setup Script
# This script helps set up and run the project

Write-Host "Library Management System - Setup Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check for PHP
Write-Host "Checking for PHP..." -ForegroundColor Yellow
$phpPath = $null

# Check common PHP locations
$phpLocations = @(
    "C:\xampp\php\php.exe",
    "C:\wamp64\bin\php\php*\php.exe",
    "C:\php\php.exe",
    "$env:ProgramFiles\PHP\php.exe"
)

foreach ($location in $phpLocations) {
    if (Test-Path $location) {
        $phpPath = (Resolve-Path $location).Path
        Write-Host "Found PHP at: $phpPath" -ForegroundColor Green
        break
    }
}

# Check if PHP is in PATH
if (-not $phpPath) {
    try {
        $phpVersion = php --version 2>&1
        if ($LASTEXITCODE -eq 0) {
            $phpPath = "php"
            Write-Host "PHP found in PATH" -ForegroundColor Green
        }
    } catch {
        # PHP not in PATH
    }
}

if (-not $phpPath) {
    Write-Host "PHP not found!" -ForegroundColor Red
    Write-Host "Please install PHP or XAMPP/WAMP" -ForegroundColor Yellow
    Write-Host "Download XAMPP: https://www.apachefriends.org/" -ForegroundColor Cyan
    exit 1
}

# Check for MySQL
Write-Host ""
Write-Host "Checking for MySQL..." -ForegroundColor Yellow
$mysqlPath = $null

$mysqlLocations = @(
    "C:\xampp\mysql\bin\mysql.exe",
    "C:\wamp64\bin\mysql\mysql*\bin\mysql.exe",
    "C:\Program Files\MySQL\MySQL Server *\bin\mysql.exe"
)

foreach ($location in $mysqlLocations) {
    $found = Get-ChildItem -Path $location -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($found) {
        $mysqlPath = $found.FullName
        Write-Host "Found MySQL at: $mysqlPath" -ForegroundColor Green
        break
    }
}

# Check if MySQL is in PATH
if (-not $mysqlPath) {
    try {
        $mysqlVersion = mysql --version 2>&1
        if ($LASTEXITCODE -eq 0) {
            $mysqlPath = "mysql"
            Write-Host "MySQL found in PATH" -ForegroundColor Green
        }
    } catch {
        # MySQL not in PATH
    }
}

if (-not $mysqlPath) {
    Write-Host "MySQL not found!" -ForegroundColor Red
    Write-Host "Please install MySQL or XAMPP/WAMP" -ForegroundColor Yellow
    Write-Host "Note: You can still run the PHP server, but database setup will need to be done manually" -ForegroundColor Yellow
}

# Check database configuration
Write-Host ""
Write-Host "Checking database configuration..." -ForegroundColor Yellow
if (Test-Path "config.php") {
    Write-Host "config.php found" -ForegroundColor Green
} else {
    Write-Host "config.php not found!" -ForegroundColor Red
    exit 1
}

# Check SQL files
Write-Host ""
Write-Host "Checking SQL files..." -ForegroundColor Yellow
$schemaFile = "Library Management.sql"
$sampleFile = "sample_data.sql"

if (Test-Path $schemaFile) {
    Write-Host "$schemaFile found" -ForegroundColor Green
} else {
    Write-Host "$schemaFile not found!" -ForegroundColor Red
}

if (Test-Path $sampleFile) {
    Write-Host "$sampleFile found" -ForegroundColor Green
} else {
    Write-Host "$sampleFile not found!" -ForegroundColor Yellow
}

# Database setup prompt
if ($mysqlPath) {
    Write-Host ""
    Write-Host "Do you want to set up the database now? (y/n)" -ForegroundColor Cyan
    $setupDB = Read-Host
    
    if ($setupDB -eq "y" -or $setupDB -eq "Y") {
        Write-Host ""
        Write-Host "Setting up database..." -ForegroundColor Yellow
        
        if (Test-Path $schemaFile) {
            Write-Host "Importing schema..." -ForegroundColor Yellow
            if ($mysqlPath -eq "mysql") {
                mysql -u root -e "source `"$PWD\$schemaFile`""
            } else {
                & $mysqlPath -u root -e "source `"$PWD\$schemaFile`""
            }
        }
        
        if (Test-Path $sampleFile) {
            Write-Host "Importing sample data..." -ForegroundColor Yellow
            $sqlContent = Get-Content $sampleFile -Raw
            if ($mysqlPath -eq "mysql") {
                $sqlContent | mysql -u root library_management
            } else {
                $sqlContent | & $mysqlPath -u root library_management
            }
        }
        
        Write-Host "Database setup complete!" -ForegroundColor Green
    }
}

# Start PHP server
Write-Host ""
Write-Host "Starting PHP development server..." -ForegroundColor Yellow
Write-Host "Server will be available at: http://localhost:8000" -ForegroundColor Cyan
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host ""

if ($phpPath -eq "php") {
    php -S localhost:8000
} else {
    & $phpPath -S localhost:8000
}

