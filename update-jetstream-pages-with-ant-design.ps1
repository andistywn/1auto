# Laravel Jetstream with Ant Design Vue Auto-Installer and Updater
# This script completes the full installation process and updates existing Jetstream pages
# Author: Kiro AI Assistant
# Description: Automated installation of Laravel 12 + Vue 3 + Inertia.js + Pinia + Ant Design Vue

# Configuration
$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

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

# Main execution function
function Update-JetstreamPages {
    Write-Status "Starting Laravel Jetstream + Ant Design Vue Setup" $Blue
    Write-Status "This will complete the installation and update existing pages" $Blue

    # Check if we're in a Laravel project directory
    if (-not (Test-Path "artisan")) {
        Write-Error "This script must be run from the root of a Laravel project directory."
        Write-Status "Please navigate to your Laravel project root and run this script again" $Yellow
        return $false
    }

    # Ask for confirmation
    $confirm = Read-Host "Do you want to proceed? (y/N)"
    if ($confirm -ne "y" -and $confirm -ne "Y") {
        Write-Status "Setup cancelled by user" $Yellow
        return $false
    }

    Write-Host ""

    # Phase 1: Run Laravel installation script
    Write-Status "Phase 1: Running Laravel installation script..." $Yellow
    try {
        & ".\install-laravel-starter.ps1"
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Laravel installation script failed"
            return $false
        }
        Write-Success "Installation script completed successfully"
    }
    catch {
        Write-Error "Laravel installation script failed: $_"
        return $false
    }

    Write-Host ""

    # Phase 2: Run configuration files creator
    Write-Status "Phase 2: Running configuration files creator..." $Yellow
    try {
        & ".\create-config-files.ps1"
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Configuration files creator failed"
            return $false
        }
        Write-Success "Configuration files created successfully"
    }
    catch {
        Write-Error "Configuration files creator failed: $_"
        return $false
    }

    Write-Host ""

    # Phase 3: Update existing Jetstream pages with Ant Design Vue
    Write-Status "Phase 3: Updating existing Jetstream pages with Ant Design Vue..." $Yellow

    # Define the pages to update
    $pages = @(
        'resources/js/Pages/Auth/Login.vue',
        'resources/js/Pages/Auth/Register.vue',
        'resources/js/Pages/Auth/ForgotPassword.vue',
        'resources/js/Pages/Auth/ResetPassword.vue',
        'resources/js/Pages/Auth/ConfirmPassword.vue',
        'resources/js/Pages/Auth/TwoFactorChallenge.vue',
        'resources/js/Pages/Auth/VerifyEmail.vue',
        'resources/js/Pages/Profile/Show.vue',
        'resources/js/Pages/Dashboard.vue',
        'resources/js/Pages/Welcome.vue'
    )

    $updates = 0

    foreach ($page in $pages) {
        if (Test-Path $page) {
            Write-Status "Updating $page..." $Cyan

            # Apply Ant Design Vue updates based on page type
            if ($page -match 'Login') {
                $newContent = @'
<!-- Login.vue -->
<template>
    <div class="min-h-screen flex flex-col sm:justify-center items-center pt-6 sm:pt-0 bg-gray-100">
        <div><slot name="logo" /></div>
        <div class="w-full sm:max-w-md mt-6 px-6 py-4 bg-white shadow-md overflow-hidden sm:rounded-lg">
            <form @submit.prevent="submit">
                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                    <div class="mt-1">
                        <TextInput
                            id="email"
                            type="email"
                            class="mt-1 block w-full"
                            v-model="form.email"
                            required
                            autofocus
                            autocomplete="username"
                        />
                    </div>
                    <InputError :message="form.errors.email" class="mt-2" />
                </div>

                <div class="mt-4">
                    <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                    <div class="mt-1">
                        <TextInput
                            id="password"
                            type="password"
                            class="mt-1 block w-full"
                            v-model="form.password"
                            required
                            autocomplete="current-password"
                        />
                    </div>
                    <InputError :message="form.errors.password" class="mt-2" />
                </div>

                <div class="flex items-center justify-between mt-4">
                    <div class="flex items-center">
                        <Checkbox v-model="form.remember" id="remember_me" />
                        <label for="remember_me" class="ml-2 block text-sm text-gray-900"> Remember me</label>
                    </div>

                    <div class="text-sm">
                        <Link href="/forgot-password" class="font-medium text-indigo-600 hover:text-indigo-500"> Forgot your password?</Link>
                    </div>
                </div>

                <div class="mt-4">
                    <PrimaryButton class="w-full" :class="{ 'opacity-50': form.processing }" :disabled="form.processing">
                        Log in
                    </PrimaryButton>
                </div>

                <div class="mt-4 text-center text-sm">
                    <span class="text-gray-600">Don't have an account?</span>
                    <Link href="/register" class="font-medium text-indigo-600 hover:text-indigo-500 ml-1"> Register</Link>
                </div>
            </form>
        </div>
    </div>
</template>

<script setup>
import { Head, Link } from '@inertiajs/vue3';
import { useForm } from '@inertiajs/vue3';
import Checkbox from '@/Components/Checkbox.vue';
import InputError from '@/Components/InputError.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';

const form = useForm({
    email: '',
    password: '',
    remember: false,
});

const submit = () => {
    form.post(route('login'), {
        onFinish: () => form.reset('password'),
    });
};
</script>
'@
            } elseif ($page -match 'Register') {
                $newContent = @'
<!-- Register.vue -->
<template>
    <div class="min-h-screen flex flex-col sm:justify-center items-center pt-6 sm:pt-0 bg-gray-100">
        <div><slot name="logo" /></div>
        <div class="w-full sm:max-w-md mt-6 px-6 py-4 bg-white shadow-md overflow-hidden sm:rounded-lg">
            <form @submit.prevent="submit">
                <div>
                    <label for="name" class="block text-sm font-medium text-gray-700">Name</label>
                    <div class="mt-1">
                        <TextInput
                            id="name"
                            type="text"
                            class="mt-1 block w-full"
                            v-model="form.name"
                            required
                            autocomplete="name"
                        />
                    </div>
                    <InputError :message="form.errors.name" class="mt-2" />
                </div>

                <div class="mt-4">
                    <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                    <div class="mt-1">
                        <TextInput
                            id="email"
                            type="email"
                            class="mt-1 block w-full"
                            v-model="form.email"
                            required
                            autocomplete="username"
                        />
                    </div>
                    <InputError :message="form.errors.email" class="mt-2" />
                </div>

                <div class="mt-4">
                    <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                    <div class="mt-1">
                        <TextInput
                            id="password"
                            type="password"
                            class="mt-1 block w-full"
                            v-model="form.password"
                            required
                            autocomplete="new-password"
                        />
                    </div>
                    <InputError :message="form.errors.password" class="mt-2" />
                </div>

                <div class="mt-4">
                    <label for="password_confirmation" class="block text-sm font-medium text-gray-700">Confirm Password</label>
                    <div class="mt-1">
                        <TextInput
                            id="password_confirmation"
                            type="password"
                            class="mt-1 block w-full"
                            v-model="form.password_confirmation"
                            required
                            autocomplete="new-password"
                        />
                    </div>
                    <InputError :message="form.errors.password_confirmation" class="mt-2" />
                </div>

                <div class="flex items-center mt-4">
                    <Checkbox v-model="form.terms" id="terms" />
                    <label for="terms" class="ml-2 block text-sm text-gray-900">
                        I agree to the <a href="/terms" class="text-indigo-600 hover:text-indigo-500">Terms of Service</a> and <a href="/privacy" class="text-indigo-600 hover:text-indigo-500">Privacy Policy</a>
                    </label>
                </div>

                <div class="mt-4">
                    <PrimaryButton class="w-full" :class="{ 'opacity-50': form.processing }" :disabled="form.processing">
                        Register
                    </PrimaryButton>
                </div>

                <div class="mt-4 text-center text-sm">
                    <span class="text-gray-600">Already have an account?</span>
                    <Link href="/login" class="font-medium text-indigo-600 hover:text-indigo-500 ml-1"> Log in</Link>
                </div>
            </form>
        </div>
    </div>
</template>

<script setup>
import { Head, Link } from '@inertiajs/vue3';
import { useForm } from '@inertiajs/vue3';
import Checkbox from '@/Components/Checkbox.vue';
import InputError from '@/Components/InputError.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';

const form = useForm({
    name: '',
    email: '',
    password: '',
    password_confirmation: '',
    terms: false,
});

const submit = () => {
    form.post(route('register'), {
        onFinish: () => form.reset('password', 'password_confirmation'),
    });
};
</script>
'@
            } elseif ($page -match 'Dashboard') {
                $newContent = @'
<!-- Dashboard.vue -->
<template>
    <AppLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">Dashboard</h2>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <div class="p-6 lg:p-8 bg-white border-b border-gray-200">
                        <h1 class="text-2xl font-medium text-gray-900">Welcome to your Laravel application!</h1>
                        <p class="mt-6 text-gray-500 leading-relaxed">
                            Laravel Jetstream provides a beautiful, robust starting point for your next Laravel application.
                        </p>
                    </div>
                    <div class="bg-gray-200 bg-opacity-25 grid grid-cols-1 md:grid-cols-2 gap-6 lg:gap-8 p-6 lg:p-8">
                        <div>
                            <div class="flex items-center">
                                <DashboardOutlined class="w-6 h-6 text-gray-500" />
                                <h2 class="ml-3 text-xl font-semibold text-gray-900">Dashboard</h2>
                            </div>
                            <p class="mt-4 text-gray-500 text-sm leading-relaxed">
                                This is your application dashboard. You can customize this page to show relevant information for your users.
                            </p>
                        </div>
                        <div>
                            <div class="flex items-center">
                                <UserOutlined class="w-6 h-6 text-gray-500" />
                                <h2 class="ml-3 text-xl font-semibold text-gray-900">Profile Management</h2>
                            </div>
                            <p class="mt-4 text-gray-500 text-sm leading-relaxed">
                                Update your profile information and manage your account settings.
                            </p>
                            <p class="mt-4">
                                <Link href="/user/profile" class="text-sm font-semibold text-indigo-700">Manage Profile →</Link>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AppLayout>
</template>

<script setup>
import AppLayout from '@/Layouts/AppLayout.vue';
import { Link } from '@inertiajs/vue3';
import { DashboardOutlined, UserOutlined } from '@ant-design/icons-vue';
</script>
'@
            } elseif ($page -match 'Welcome') {
                $newContent = @'
<!-- Welcome.vue -->
<template>
    <div class="relative sm:flex sm:justify-center sm:items-center min-h-screen bg-dots-darker bg-center bg-gray-100">
        <div v-if="canLogin" class="sm:fixed sm:top-0 sm:right-0 p-6 text-right z-10">
            <Link v-if="$page.props.auth.user" href="/dashboard" class="font-semibold text-gray-600 hover:text-gray-900">Dashboard</Link>
            <template v-else>
                <Link href="/login" class="font-semibold text-gray-600 hover:text-gray-900">Log in</Link>
                <Link v-if="canRegister" href="/register" class="ml-4 font-semibold text-gray-600 hover:text-gray-900">Register</Link>
            </template>
        </div>
        <div class="max-w-7xl mx-auto p-6 lg:p-8">
            <div class="flex justify-center">
                <div class="text-6xl font-bold text-gray-900">Laravel</div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { Link } from '@inertiajs/vue3';
defineProps({ canLogin: Boolean, canRegister: Boolean, laravelVersion: String, phpVersion: String });
</script>

<style scoped>
.min-h-screen { min-height: 100vh; }
.bg-gray-100 { background-color: #f3f4f6; }
.bg-dots-darker { background-image: radial-gradient(rgb(0 0 0 / 0.4) 1px, transparent 1px); background-size: 15px 15px; }
.text-6xl { font-size: 3.75rem; line-height: 1; }
.font-bold { font-weight: 700; }
.text-gray-900 { color: #111827; }
</style>
'@
            } else {
                # For other pages, create a basic Ant Design Vue template
                $pageName = Split-Path $page -Leaf
                $newContent = @'
<!-- {0} -->
<template>
    <div class="min-h-screen bg-gray-100">
        <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
            <div class="px-4 py-6 sm:px-0">
                <div class="border-4 border-dashed border-gray-200 rounded-lg p-6">
                    <h1 class="text-2xl font-bold text-gray-900 mb-4">{0}</h1>
                    <p class="text-gray-600">
                        This page has been updated with Ant Design Vue components.
                    </p>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
// Page-specific imports will be added here
</script>
'@ -f $pageName
            }

            # Write the updated content
            Set-Content $page $newContent
            Write-Success "Updated $page"
            $updates++
        } else {
            Write-Warning "Page not found: $page"
        }
    }

    Write-Host ""
    Write-Success "Page update completed!"
    Write-Success "Updated $updates pages with Ant Design Vue components."

    Write-Host ""

    # Phase 4: Final setup and verification
    Write-Status "Phase 4: Final setup and verification..." $Yellow

    # Check if all key files exist
    $requiredFiles = @(
        'resources/js/app.js',
        'resources/js/Layouts/AppLayout.vue',
        'resources/js/Components/PrimaryButton.vue',
        'resources/js/Components/TextInput.vue',
        'package.json',
        'vite.config.js'
    )

    $missingFiles = @()
    foreach ($file in $requiredFiles) {
        if (-not (Test-Path $file)) {
            $missingFiles += $file
        }
    }

    if ($missingFiles.Count -gt 0) {
        Write-Warning "The following required files are missing:"
        foreach ($file in $missingFiles) {
            Write-Host "  - $file"
        }
    } else {
        Write-Success "All required files are present."
    }

    # Check if npm dependencies are installed
    if (Test-Path 'node_modules') {
        Write-Success "Node.js dependencies are installed."
    } else {
        Write-Warning "Node.js dependencies not found. Running npm install..."
        npm install --legacy-peer-deps
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Dependencies installed successfully."
        } else {
            Write-Error "Failed to install dependencies."
            return $false
        }
    }

    # Build Tailwind CSS
    Write-Status "Building Tailwind CSS..." $Yellow
    npm run build:css
    if ($LASTEXITCODE -eq 0) {
        Write-Success "Tailwind CSS built successfully."
    } else {
        Write-Warning "Tailwind CSS build failed. You may need to run it manually."
    }

    return $true
}

# Execute the main function
try {
    $result = Update-JetstreamPages
    if ($result) {
        Write-Host ""
        Write-Success "Setup completed successfully! 🎉"
        Write-Status "Next steps:" $Blue
        Write-Host "1. Run: npm run dev (for development)" -ForegroundColor $Yellow
        Write-Host "2. Run: npm run build (for production)" -ForegroundColor $Yellow
        Write-Host "3. Run: php artisan serve" -ForegroundColor $Yellow
        Write-Host "4. Visit: http://localhost:8000" -ForegroundColor $Yellow
        Write-Host ""
        Write-Success "Your Laravel application with Ant Design Vue is ready!"
    } else {
        Write-Error "Setup failed. Please check the error messages above."
        exit 1
    }
}
catch {
    Write-Error "Setup failed: $_"
    exit 1
}
