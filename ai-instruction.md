# 🚀 Laravel Full-Stack Auto-Installer Agent Prompt

## **Objective**
Install a complete Laravel 12 + Vue 3 + JavaScript + Inertia.js + Pinia + Ant Design Vue + Tailwind CSS v4 starter kit with Jetstream authentication.

## **Prerequisites Check**
Before starting, verify these tools are installed:
- **PHP 8.2+** (`php --version`)
- **Composer** (`composer --version`) 
- **Node.js 18+** and **NPM** (`node --version` && `npm --version`)

## **Installation Steps**

### **Step 1: Download Installer Scripts**
Ensure you have both files in your project directory:
- `install-laravel-starter.ps1` (main installer)
- `create-config-files.ps1` (configuration creator)

### **Step 2: Run the Main Installer**
Execute in PowerShell:
```powershell
# Basic installation
.\install-laravel-starter.ps1

# With custom project name
.\install-laravel-starter.ps1 -ProjectName "my-awesome-app"

# Skip Composer (if handling manually)
.\install-laravel-starter.ps1 -SkipComposer

# Skip NPM (if handling manually)  
.\install-laravel-starter.ps1 -SkipNpm

# Verbose output for debugging
.\install-laravel-starter.ps1 -Verbose
```

### **Step 3: Build Assets**
After installation completes:
```powershell
# Build Tailwind CSS + Vite assets
npm run build

# OR for development with auto-rebuild
npm run dev
```

### **Step 4: Start Application**
```powershell
# Start Laravel server
php artisan serve

# Visit: http://localhost:8000
```

## **What Gets Installed**

### **Backend Stack:**
- ✅ Laravel 12 with Jetstream authentication
- ✅ Inertia.js with SSR support
- ✅ SQLite database (pre-configured)
- ✅ ZiggyVue for Laravel routing in Vue

### **Frontend Stack:**
- ✅ Vue 3 with Composition API (JavaScript only)
- ✅ Pinia for state management
- ✅ Ant Design Vue + Icons
- ✅ Tailwind CSS v4 with new `@import "tailwindcss";` syntax
- ✅ Vite build system with hot reload

### **Key Features:**
- ✅ Complete authentication system (login, register, profile)
- ✅ Responsive design with Tailwind CSS
- ✅ Modern Vue 3 components
- ✅ Type-safe routing with ZiggyVue
- ✅ Production-ready build process
- ✅ **NO TypeScript conflicts** (pure JavaScript)

## **Troubleshooting**

### **Common Issues:**

1. **"Execution Policy" Error:**
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

2. **NPM Dependency Conflicts:**
   ```powershell
   # Clear cache and reinstall
   npm cache clean --force
   rm -rf node_modules package-lock.json
   npm install --legacy-peer-deps
   ```

3. **Tailwind CSS Build Fails:**
   - The installer creates fallback CSS automatically
   - Manually rebuild: `npm run build:css`

4. **Port Already in Use:**
   ```powershell
   php artisan serve --port=8080
   ```

## **Development Workflow**

### **Available NPM Scripts:**
```json
{
  "build": "npm run build:css && vite build",
  "build:css": "npx @tailwindcss/cli -i resources/css/app.css -o public/css/tailwind-output.css",
  "build:css:watch": "npx @tailwindcss/cli -i resources/css/app.css -o public/css/tailwind-output.css --watch",
  "dev": "concurrently \"npm run build:css:watch\" \"vite\"",
  "build-only": "vite build",
  "preview": "vite preview"
}
```

### **Development Commands:**
```powershell
# Start development with auto-rebuild
npm run dev

# In another terminal, start Laravel
php artisan serve

# Build for production
npm run build
```

## **Project Structure**
```
your-project/
├── app/
│   ├── Http/Controllers/
│   ├── Services/           # Business logic
│   └── Repositories/       # Data access
├── resources/
│   ├── js/
│   │   ├── Components/     # Vue components
│   │   ├── Layouts/        # Layout components  
│   │   ├── Pages/          # Inertia pages
│   │   ├── Stores/         # Pinia stores
│   │   └── app.js          # Main app file
│   └── css/
│       └── app.css         # Tailwind CSS
├── public/css/
│   └── tailwind-output.css # Built Tailwind CSS
└── database/
    └── database.sqlite     # SQLite database
```

## **Success Indicators**
- ✅ No errors during installation
- ✅ `npm run build` completes successfully  
- ✅ `php artisan serve` starts without issues
- ✅ Can access http://localhost:8000
- ✅ Registration/login works
- ✅ Dashboard loads with proper styling
- ✅ Ant Design components render correctly

## **Next Steps After Installation**
1. **Customize the dashboard** in `resources/js/Pages/Dashboard.vue`
2. **Add new pages** in `resources/js/Pages/`
3. **Create Pinia stores** in `resources/js/Stores/`
4. **Modify Tailwind styles** in `resources/css/app.css`
5. **Add API endpoints** in `routes/api.php`

---

**This installer provides a production-ready Laravel + Vue 3 starter kit with modern tooling and zero configuration conflicts!** 🎉
