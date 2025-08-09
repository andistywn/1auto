# Laravel Full-Stack Application Auto-Installer
# Based on Tasks-Refined.md - Error-Free Roadmap v2.0
# Author: Kiro AI Assistant
# Description: Unsupervised installation of Laravel 12 + Vue 3 + JavaScript + Inertia.js + Pinia + Ant Design Vue + Tailwind CSS v4

param(
    [string]$ProjectName = "laravel-app",
    [switch]$SkipComposer = $false,
    [switch]$SkipNpm = $false,
    [switch]$Verbose = $false
)

# Configuration
$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

# Global variables for rollback
$global:RollbackActions = @()
$global:InstallationPhase = "Starting"

function Add-RollbackAction {
    param([scriptblock]$Action, [string]$Description)
    $global:RollbackActions += @{
        Action = $Action
        Description = $Description
    }
    Write-Status "Added rollback action: $Description" $Yellow
}

function Invoke-Rollback {
    Write-Warning "Installation failed, invoking rollback actions..."

    for ($i = $global:RollbackActions.Count - 1; $i -ge 0; $i--) {
        $rollback = $global:RollbackActions[$i]
        try {
            Write-Status "Rolling back: $($rollback.Description)" $Yellow
            & $rollback.Action
        }
        catch {
            Write-Error "Rollback failed: $($rollback.Description) - $_"
        }
    }

    Write-Status "Rollback completed" $Yellow
}

# Colors for output
$Red = "Red"
$Green = "Green"
$Yellow = "Yellow"
$Blue = "Cyan"

function Write-Status {
    param([string]$Message, [string]$Color = "White")
    Write-Host "🚀 $Message" -ForegroundColor $Color
}

function Write-Success {
    param([string]$Message)
    Write-Host "✅ $Message" -ForegroundColor $Green
}

function Write-Error {
    param([string]$Message)
    Write-Host "❌ $Message" -ForegroundColor $Red
}

function Write-Warning {
    param([string]$Message)
    Write-Host "⚠️  $Message" -ForegroundColor $Yellow
}

function Test-Command {
    param([string]$Command)
    try {
        Get-Command $Command -ErrorAction Stop | Out-Null
        return $true
    }
    catch {
        return $false
    }
}

function Invoke-SafeCommand {
    param(
        [string]$Command,
        [string]$Arguments = "",
        [string]$WorkingDirectory = ".",
        [string]$SuccessMessage = "",
        [string]$ErrorMessage = "Command failed",
        [bool]$ShowOutput = $false
    )

    try {
        $originalLocation = Get-Location
        Set-Location $WorkingDirectory

        Write-Status "Executing: $Command $Arguments" $Blue

        if ($Command -eq "npm") {
            # Handle npm as PowerShell script with proper error handling
            if ($Arguments) {
                if ($ShowOutput) {
                    $result = Invoke-Expression "npm $Arguments 2>&1"
                    $exitCode = $LASTEXITCODE
                    Write-Host $result
                } else {
                    $result = Invoke-Expression "npm $Arguments 2>&1"
                    $exitCode = $LASTEXITCODE
                }
            } else {
                $result = Invoke-Expression "npm 2>&1"
                $exitCode = $LASTEXITCODE
            }
        } else {
            # Handle other commands with Start-Process
            if ($Arguments) {
                $process = Start-Process -FilePath $Command -ArgumentList $Arguments -WorkingDirectory $WorkingDirectory -Wait -PassThru -NoNewWindow -RedirectStandardOutput "nul" -RedirectStandardError "nul"
            } else {
                $process = Start-Process -FilePath $Command -WorkingDirectory $WorkingDirectory -Wait -PassThru -NoNewWindow -RedirectStandardOutput "nul" -RedirectStandardError "nul"
            }
            $exitCode = $process.ExitCode
        }

        Set-Location $originalLocation

        if ($exitCode -eq 0) {
            if ($SuccessMessage) { Write-Success $SuccessMessage }
            return $true
        } else {
            Write-Error "$ErrorMessage (Exit code: $exitCode)"
            return $false
        }
    }
    catch {
        Set-Location $originalLocation
        Write-Error "$ErrorMessage - $_"
        return $false
    }
}

# Main installation function
function Install-LaravelStarter {
    Write-Status "🎯 Starting Laravel Full-Stack Application Installation" $Blue
    Write-Status "Project: $ProjectName" $Blue
    Write-Status "Directory: $(Get-Location)" $Blue

    # Phase 1: Prerequisites Check
    Write-Status "Phase 1: Checking Prerequisites" $Yellow

    # Check PHP version
    if (-not (Test-Command "php")) {
        Write-Error "PHP is not installed or not in PATH"
        exit 1
    }

    try {
        $phpVersion = php -r "echo PHP_MAJOR_VERSION . '.' . PHP_MINOR_VERSION;"
        Write-Status "PHP version: $phpVersion" $Blue

        if ($phpVersion -lt "8.1") {
            Write-Warning "PHP 8.1+ is recommended for Laravel 12"
        }
    }
    catch {
        Write-Warning "Could not determine PHP version"
    }

    # Check Composer
    if (-not $SkipComposer) {
        if (-not (Test-Command "composer")) {
            Write-Error "Composer is not installed or not in PATH"
            exit 1
        }

        try {
            $composerVersion = composer --version | Select-String -Pattern "version (\d+\.\d+\.\d+)" -AllMatches | Select-Object -ExpandProperty Matches | Select-Object -ExpandProperty Value
            Write-Status "Composer version: $composerVersion" $Blue
        }
        catch {
            Write-Warning "Could not determine Composer version"
        }
    }

    # Check Node.js and NPM
    if (-not $SkipNpm) {
        if (-not (Test-Command "npm")) {
            Write-Error "Node.js/NPM is not installed or not in PATH"
            exit 1
        }

        try {
            $nodeVersion = node --version
            $npmVersion = npm --version
            Write-Status "Node.js version: $nodeVersion" $Blue
            Write-Status "NPM version: $npmVersion" $Blue

            if ($nodeVersion -lt "v18") {
                Write-Warning "Node.js 18+ is recommended for modern Vue 3 development"
            }
        }
        catch {
            Write-Warning "Could not determine Node.js/NPM version"
        }
    }

    Write-Success "All prerequisites met"

    # Phase 2: Project Initialization
    Write-Status "Phase 2: Creating Laravel Project" $Yellow

    if (-not $SkipComposer) {
        Write-Status "Creating Laravel project..."
        $result = Invoke-SafeCommand "composer" "create-project laravel/laravel temp --no-interaction" "." "Laravel project created"
        if (-not $result) { exit 1 }

        # Move files from temp to current directory
        if (Test-Path "temp") {
            Get-ChildItem "temp" | Move-Item -Destination "." -Force
            Remove-Item "temp" -Recurse -Force
            Write-Success "Project files moved to current directory"
        }
    }

    # Generate application key
    Write-Status "Generating application key..."
    Invoke-SafeCommand "php" "artisan key:generate --no-interaction" "." "Application key generated"

    # Configure environment
    Write-Status "Configuring environment..."
    if (-not (Test-Path ".env")) {
        Copy-Item ".env.example" ".env"
        Write-Success "Environment file created"
    }

    # Update .env for SQLite
    $envContent = Get-Content ".env" -Raw
    $envContent = $envContent -replace "DB_CONNECTION=mysql", "DB_CONNECTION=sqlite"
    $envContent = $envContent -replace "DB_HOST=.*", "# DB_HOST=127.0.0.1"
    $envContent = $envContent -replace "DB_PORT=.*", "# DB_PORT=3306"
    $envContent = $envContent -replace "DB_DATABASE=.*", "# DB_DATABASE=laravel"
    $envContent = $envContent -replace "DB_USERNAME=.*", "# DB_USERNAME=root"
    $envContent = $envContent -replace "DB_PASSWORD=.*", "# DB_PASSWORD="
    Set-Content ".env" $envContent
    Write-Success "Database configured for SQLite"

    # Phase 3: Install Jetstream
    Write-Status "Phase 3: Installing Laravel Jetstream" $Yellow

    if (-not $SkipComposer) {
        Invoke-SafeCommand "composer" "require laravel/jetstream --no-interaction" "." "Jetstream installed"
        Invoke-SafeCommand "php" "artisan jetstream:install inertia --ssr --no-interaction" "." "Jetstream configured with Inertia"
    }

    # Phase 4: Backup Jetstream structure (CRITICAL FIX)
    Write-Status "Phase 4: Backing up Jetstream structure" $Yellow

    # Create backup of original Jetstream files before any modifications
    if (Test-Path "resources/js") {
        Copy-Item "resources/js" "resources/js_jetstream_backup" -Recurse -Force
        Write-Success "Jetstream structure backed up"
    }

    # Don't remove any config files - we'll enhance them instead
    Write-Success "Preserving all Jetstream configuration files"

    # DON'T remove app.js, Components, Layouts, or Pages - we'll enhance them instead
    Write-Success "Jetstream core structure preserved"

    # Phase 5: Install NPM Dependencies (FIXED)
    Write-Status "Phase 5: Installing NPM Dependencies" $Yellow

    if (-not $SkipNpm) {
        try {
            # Install base dependencies first (keep existing Jetstream packages)
            Write-Status "Installing base dependencies..."
            $npmInstallResult = Invoke-SafeCommand "npm" "install --legacy-peer-deps" "." "Base dependencies installed" $true
            if (-not $npmInstallResult) { exit 1 }

            # Add our additional packages without removing existing ones
            Write-Status "Adding Pinia and Ant Design Vue..."
            $additionalPackages = "pinia@latest ant-design-vue@latest @ant-design/icons-vue@latest"
            $additionalInstallResult = Invoke-SafeCommand "npm" "install $additionalPackages --legacy-peer-deps" "." "Additional packages installed" $true
            if (-not $additionalInstallResult) { exit 1 }

            # Skip TypeScript to avoid JS/TS conflicts
            Write-Status "Skipping TypeScript to avoid conflicts..."
            Write-Success "Pure JavaScript setup maintained"

            # CRITICAL: Install Tailwind CSS v4 with specific version
            Write-Status "Installing Tailwind CSS v4..."
            $tailwindPackages = "tailwindcss@4.1.11 @tailwindcss/cli@4.1.11 @tailwindcss/postcss@4.1.11"
            $tailwindInstallResult = Invoke-SafeCommand "npm" "install $tailwindPackages --legacy-peer-deps" "." "Tailwind CSS v4 installed" $true
            if (-not $tailwindInstallResult) { exit 1 }

            # Install concurrently for dev scripts
            Write-Status "Installing concurrently for development..."
            $concurrentlyInstallResult = Invoke-SafeCommand "npm" "install concurrently --legacy-peer-deps" "." "Concurrently installed" $true
            if (-not $concurrentlyInstallResult) { exit 1 }

            # Note: We keep existing Jetstream packages and add our enhancements
            Write-Success "All dependencies installed while preserving Jetstream structure"
        }
        catch {
            Write-Error "NPM installation failed: $_"
            exit 1
        }
    }

    # Phase 6: Create additional directory structure
    Write-Status "Phase 6: Creating additional directory structure" $Yellow

    # Only create directories that don't exist (don't overwrite Jetstream structure)
    $directories = @(
        "resources/js/Stores",
        "resources/js/Utils",
        "resources/js/types",
        "app/Services",
        "app/Repositories",
        "app/Http/Controllers/Api",
        "app/Http/Requests/Api",
        "app/Http/Resources"
    )

    foreach ($dir in $directories) {
        if (-not (Test-Path $dir)) {
            New-Item $dir -ItemType Directory -Force | Out-Null
            Write-Success "Created $dir"
        } else {
            Write-Success "$dir already exists"
        }
    }

    # Phase 7: Enhance Jetstream with our additions
    Write-Status "Phase 7: Enhancing Jetstream with Pinia and Ant Design" $Yellow

    # Run the configuration files creator (now enhanced to work with Jetstream)
    if (Test-Path "create-config-files.ps1") {
        Write-Status "Running enhanced configuration creator..."
        & ".\create-config-files.ps1"
        Write-Success "Jetstream enhanced with additional features"
    } else {
        Write-Warning "create-config-files.ps1 not found, skipping configuration creation"
    }

    # Phase 8: Database setup
    Write-Status "Phase 8: Setting up database" $Yellow

    # Create SQLite database file
    if (-not (Test-Path "database/database.sqlite")) {
        New-Item "database/database.sqlite" -ItemType File -Force | Out-Null
        Write-Success "SQLite database file created"
    }

    # Run migrations
    Invoke-SafeCommand "php" "artisan migrate --no-interaction" "." "Database migrations completed"

    Write-Success "Laravel starter kit installation completed! 🎉"
    Write-Status "Next steps:" $Blue
    Write-Host "1. Run: npm run build (builds Tailwind CSS v4 + assets)" -ForegroundColor $Yellow
    Write-Host "2. Run: php artisan serve" -ForegroundColor $Yellow
    Write-Host "3. Visit: http://localhost:8000" -ForegroundColor $Yellow
    Write-Host "" -ForegroundColor $Yellow
    Write-Host "For development:" -ForegroundColor $Blue
    Write-Host "- Run: npm run dev (auto-rebuilds CSS + hot reload)" -ForegroundColor $Yellow
}

# Execute installation
try {
    Install-LaravelStarter
    Write-Success "Installation completed successfully!"
}
catch {
    Write-Error "Installation failed: $_"
    Invoke-Rollback
    exit 1
}
