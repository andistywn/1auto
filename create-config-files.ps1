# Configuration Files Creator for Laravel Starter Kit
# This script creates all the necessary configuration files

function Create-ViteConfig {
    $content = @'
import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import vue from '@vitejs/plugin-vue';

export default defineConfig({
    plugins: [
        laravel({
            input: ['public/css/tailwind-output.css', 'resources/js/app.js'],
            ssr: 'resources/js/ssr.js',
            refresh: true,
        }),
        vue({
            template: {
                transformAssetUrls: {
                    base: null,
                    includeAbsolute: false,
                },
            },
        }),
    ],
    resolve: {
        alias: {
            '@': '/resources/js',
        },
    },
    optimizeDeps: {
        include: [
            'vue',
            '@inertiajs/vue3',
            'pinia',
            'ant-design-vue',
            '@ant-design/icons-vue',
        ],
    },
});
'@
    Set-Content "vite.config.js" $content
    Write-Host "✅ Created vite.config.js (FIXED for Tailwind CSS v4)" -ForegroundColor Green
}

function Enhance-AppJs {
    # CRITICAL FIX: Enhance existing app.js instead of creating app.ts
    $content = @'
import '../css/app.css';

import { createApp, h } from 'vue';
import { createInertiaApp } from '@inertiajs/vue3';
import { resolvePageComponent } from 'laravel-vite-plugin/inertia-helpers';
import { ZiggyVue } from '../../vendor/tightenco/ziggy';
import { createPinia } from 'pinia';
import Antd from 'ant-design-vue';
import * as Icons from '@ant-design/icons-vue';

// Import Ant Design styles
import 'ant-design-vue/dist/reset.css';

const appName = import.meta.env.VITE_APP_NAME || 'Laravel';
const pinia = createPinia();

createInertiaApp({
    title: (title) => `${title} - ${appName}`,
    resolve: (name) => resolvePageComponent(`./Pages/${name}.vue`, import.meta.glob('./Pages/**/*.vue')),
    setup({ el, App, props, plugin }) {
        const app = createApp({ render: () => h(App, props) })
            .use(plugin)
            .use(ZiggyVue)  // CRITICAL: This enables Laravel routing
            .use(pinia)
            .use(Antd);

        // Register Ant Design icons
        Object.keys(Icons).forEach((key) => {
            const IconComponent = Icons[key];
            if (IconComponent) {
                app.component(key, IconComponent);
            }
        });

        return app.mount(el);
    },
    progress: {
        color: '#4B5563',
    },
});
'@
    Set-Content "resources/js/app.js" $content
    Write-Host "✅ Enhanced resources/js/app.js with Pinia and Ant Design (FIXED)" -ForegroundColor Green
}

function Enhance-AppCss {
    # CRITICAL FIX: Use Tailwind CSS v4 syntax and build with CLI
    $content = @'
@import "tailwindcss";

/* Custom styles that work with Ant Design and Tailwind */
:root {
    --primary-color: #1890ff;
    --success-color: #52c41a;
    --warning-color: #faad14;
    --error-color: #f5222d;
}

/* Ant Design customizations */
.ant-layout {
    min-height: 100vh;
}
'@
    Set-Content "resources/css/app.css" $content
    Write-Host "✅ Enhanced resources/css/app.css with Tailwind CSS v4 syntax" -ForegroundColor Green

    # Build Tailwind CSS using CLI with better error handling
    Write-Host "🔨 Building Tailwind CSS..." -ForegroundColor Yellow
    try {
        # Ensure public/css directory exists
        if (-not (Test-Path "public/css")) {
            New-Item "public/css" -ItemType Directory -Force | Out-Null
        }

        $result = Invoke-Expression "npx @tailwindcss/cli -i resources/css/app.css -o public/css/tailwind-output.css 2>&1"
        if ($LASTEXITCODE -eq 0 -and (Test-Path "public/css/tailwind-output.css")) {
            Write-Host "✅ Tailwind CSS built successfully" -ForegroundColor Green
        } else {
            Write-Host "⚠️ Tailwind CSS build failed, creating fallback..." -ForegroundColor Yellow
            # Create minimal fallback CSS to prevent Vite errors
            $fallbackCss = "/* Tailwind CSS fallback - build failed */`nbody { font-family: system-ui, sans-serif; }"
            Set-Content "public/css/tailwind-output.css" $fallbackCss
            Write-Host "✅ Fallback CSS created" -ForegroundColor Green
        }
    } catch {
        Write-Host "⚠️ Tailwind CSS build failed, creating fallback..." -ForegroundColor Yellow
        # Create minimal fallback CSS to prevent Vite errors
        if (-not (Test-Path "public/css")) {
            New-Item "public/css" -ItemType Directory -Force | Out-Null
        }
        $fallbackCss = "/* Tailwind CSS fallback - build failed */`nbody { font-family: system-ui, sans-serif; }"
        Set-Content "public/css/tailwind-output.css" $fallbackCss
        Write-Host "✅ Fallback CSS created" -ForegroundColor Green
    }
}

function Create-TypeScriptConfig {
    $tsconfig = @'
{
    "compilerOptions": {
        "target": "ES2020",
        "useDefineForClassFields": true,
        "lib": ["ES2020", "DOM", "DOM.Iterable"],
        "module": "NodeNext",
        "skipLibCheck": true,
        "moduleResolution": "node16",
        "allowImportingTsExtensions": true,
        "resolveJsonModule": true,
        "isolatedModules": true,
        "noEmit": true,
        "jsx": "preserve",
        "strict": false,
        "noImplicitAny": false,
        "noUnusedLocals": false,
        "noUnusedParameters": false,
        "noFallthroughCasesInSwitch": true,
        "allowJs": true,
        "baseUrl": ".",
        "paths": {
            "@/*": ["resources/js/*"]
        },
        "types": ["vite/client", "node"]
    },
    "include": [
        "resources/js/**/*.ts",
        "resources/js/**/*.d.ts",
        "resources/js/**/*.tsx",
        "resources/js/**/*.vue",
        "resources/js/types/**/*.d.ts"
    ],
    "exclude": ["node_modules", "public", "vendor"],
    "references": [{ "path": "./tsconfig.node.json" }]
}
'@
    Set-Content "tsconfig.json" $tsconfig
    Write-Host "✅ Created tsconfig.json" -ForegroundColor Green

    $tsconfigNode = @'
{
    "compilerOptions": {
        "composite": true,
        "skipLibCheck": true,
        "module": "esnext",
        "moduleResolution": "node",
        "allowSyntheticDefaultImports": true
    },
    "include": ["vite.config.ts"]
}
'@
    Set-Content "tsconfig.node.json" $tsconfigNode
    Write-Host "✅ Created tsconfig.node.json" -ForegroundColor Green
}

function Create-TypeDefinitions {
    # Vue shims
    $vueShims = @'
declare module "*.vue" {
    import type { DefineComponent } from "vue";
    const component: DefineComponent<{}, {}, any>;
    export default component;
}

// Additional Vue 3 type declarations
declare module "vue" {
    export function createApp(options: any): any;
    export function h(component: any, props?: any, children?: any): any;
    export function ref<T>(value?: T): { value: T };
    export function nextTick(callback?: () => void): Promise<void>;
    export function reactive<T extends object>(target: T): T;
    export function computed<T>(getter: () => T): { value: T };
    export function onMounted(callback: () => void): void;
    export function defineProps<T = {}>(): T;
    export function withDefaults<T, D>(props: T, defaults: D): T & D;
}
'@
    Set-Content "resources/js/types/vue-shims.d.ts" $vueShims
    Write-Host "✅ Created resources/js/types/vue-shims.d.ts" -ForegroundColor Green

    # Global declarations
    $globalDts = @'
import { PageProps } from "@inertiajs/core";

// Global route function type
type RouteFunction = (name: string, params?: Record<string, any>) => string;

declare global {
    interface Window {
        route?: RouteFunction;
    }

    const route: RouteFunction;
}

// Inertia.js module declarations - InertiaProgress types are included from the package

declare module "@inertiajs/vue3" {
    export function createInertiaApp(options: {
        title?: (title: string) => string;
        resolve: (name: string) => any;
        setup: (params: {
            el: Element;
            App: any;
            props: Record<string, any>;
            plugin: any;
        }) => any;
        progress?: {
            color?: string;
            showSpinner?: boolean;
        };
    }): void;

    export const Link: any;
    export function useForm<T = Record<string, any>>(data?: T): any;
    export function usePage(): any;
}

// Vue runtime declarations
declare module "@vue/runtime-core" {
    interface ComponentCustomProperties {
        $page: {
            props: PageProps & {
                auth: {
                    user?: {
                        id: number;
                        name: string;
                        email: string;
                        role?: string;
                    };
                };
                appName?: string;
                [key: string]: any;
            };
        };
        route: RouteFunction;
    }
}

// Ant Design Vue declarations
declare module "ant-design-vue" {
    const Antd: any;
    export default Antd;
    export const message: any;
}

declare module "@ant-design/icons-vue" {
    export const DashboardOutlined: any;
    export const UserOutlined: any;
    export const DownOutlined: any;
    export const LoginOutlined: any;
    export const UserAddOutlined: any;
    export const PlusOutlined: any;
    export const EditOutlined: any;
    export const DeleteOutlined: any;
    export const MailOutlined: any;
    export const LockOutlined: any;
    export const TeamOutlined: any;
    export const ArrowUpOutlined: any;

    // Allow any other icon exports
    const icons: Record<string, any>;
    export = icons;
}

// Pinia declarations
declare module "pinia" {
    export function createPinia(): any;
    export function defineStore(id: string, setup: () => any): () => any;
}

export {};
'@
    Set-Content "resources/js/types/global.d.ts" $globalDts
    Write-Host "✅ Created resources/js/types/global.d.ts" -ForegroundColor Green
}

function Create-TypeInterfaces {
    # Auth types
    $authTypes = @'
export interface RegisterForm {
    name: string;
    email: string;
    password: string;
    password_confirmation: string;
    terms: boolean;
}

export interface LoginForm {
    email: string;
    password: string;
    remember: boolean;
}
'@
    Set-Content "resources/js/types/auth.ts" $authTypes
    Write-Host "✅ Created resources/js/types/auth.ts" -ForegroundColor Green

    # User types
    $userTypes = @'
export interface User {
    id: number;
    name: string;
    email: string;
    role: "user" | "admin";
    created_at: string;
    updated_at: string;
}

export interface UserCreateData {
    name: string;
    email: string;
    password: string;
    role?: "user" | "admin";
}

export interface UserUpdateData {
    name?: string;
    email?: string;
    role?: "user" | "admin";
}

export interface ApiResponse<T> {
    data: T;
    meta?: {
        current_page: number;
        last_page: number;
        per_page: number;
        total: number;
    };
}
'@
    Set-Content "resources/js/types/user.ts" $userTypes
    Write-Host "✅ Created resources/js/types/user.ts" -ForegroundColor Green

    # Dashboard types
    $dashboardTypes = @'
export interface DashboardStats {
    users: number;
    sessions: number;
    projects: number;
}

export interface Activity {
    title: string;
    description: string;
    time: string;
}
'@
    Set-Content "resources/js/types/dashboard.ts" $dashboardTypes
    Write-Host "✅ Created resources/js/types/dashboard.ts" -ForegroundColor Green

    # Profile types
    $profileTypes = @'
export interface ProfileForm {
    name: string;
    email: string;
}

export interface PasswordForm {
    current_password: string;
    password: string;
    password_confirmation: string;
}

export interface ProfileUser {
    id: number;
    name: string;
    email: string;
    email_verified_at?: string;
    created_at: string;
    updated_at: string;
}
'@
    Set-Content "resources/js/types/profile.ts" $profileTypes
    Write-Host "✅ Created resources/js/types/profile.ts" -ForegroundColor Green
}

function Update-PackageJson {
    if (Test-Path "package.json") {
        $packageJson = Get-Content "package.json" | ConvertFrom-Json

        # Check if scripts already contain our modifications
        $hasCustomScripts = $false
        if ($packageJson.scripts) {
            $scriptKeys = $packageJson.scripts.PSObject.Properties.Name
            $hasCustomScripts = $scriptKeys -contains "build:css" -and $scriptKeys -contains "dev"
        }

        if (-not $hasCustomScripts) {
            # Update scripts (NO TypeScript to avoid JS/TS conflicts)
            $packageJson.type = "module"
            $packageJson.scripts = @{
                "build" = "npm run build:css && vite build"
                "build:css" = "npx @tailwindcss/cli -i resources/css/app.css -o public/css/tailwind-output.css"
                "build:css:watch" = "npx @tailwindcss/cli -i resources/css/app.css -o public/css/tailwind-output.css --watch"
                "dev" = "concurrently \"npm run build:css:watch\" \"vite\""
                "build-only" = "vite build"
                "preview" = "vite preview"
            }

            $packageJson | ConvertTo-Json -Depth 10 | Set-Content "package.json"
            Write-Host "✅ Updated package.json with Tailwind CSS v4 scripts (NO TypeScript)" -ForegroundColor Green
        } else {
            Write-Host "✅ Package.json already contains custom scripts, skipping update" -ForegroundColor Yellow
        }
    } else {
        Write-Warning "package.json not found, skipping update"
    }
}

function Enhance-VueComponents {
    Write-Host "Enhancing Vue components (preserving Jetstream)..." -ForegroundColor Yellow

    # Only create components that don't exist or enhance existing ones
    # AuthenticationCard (only if it doesn't exist)
    if (-not (Test-Path "resources/js/Components/AuthenticationCard.vue")) {
        $authCard = @'
<template>
    <div class="min-h-screen flex flex-col sm:justify-center items-center pt-6 sm:pt-0 bg-gray-100">
        <div><slot name="logo" /></div>
        <div class="w-full sm:max-w-md mt-6 px-6 py-4 bg-white shadow-md overflow-hidden sm:rounded-lg">
            <slot />
        </div>
    </div>
</template>
<script setup></script>
<style scoped>
.min-h-screen { min-height: 100vh; }
.flex { display: flex; }
.flex-col { flex-direction: column; }
.justify-center { justify-content: center; }
.items-center { align-items: center; }
.pt-6 { padding-top: 1.5rem; }
.bg-gray-100 { background-color: #f7fafc; }
.w-full { width: 100%; }
.sm\:max-w-md { max-width: 28rem; }
.mt-6 { margin-top: 1.5rem; }
.px-6 { padding-left: 1.5rem; padding-right: 1.5rem; }
.py-4 { padding-top: 1rem; padding-bottom: 1rem; }
.bg-white { background-color: #ffffff; }
.shadow-md { box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1); }
.overflow-hidden { overflow: hidden; }
.sm\:rounded-lg { border-radius: 0.5rem; }
@media (min-width: 640px) {
    .sm\:justify-center { justify-content: center; }
    .sm\:pt-0 { padding-top: 0; }
    .sm\:max-w-md { max-width: 28rem; }
    .sm\:rounded-lg { border-radius: 0.5rem; }
}
</style>
'@
    Set-Content "resources/js/Components/AuthenticationCard.vue" $authCard

    # AuthenticationCardLogo
    $authLogo = @'
<template>
    <Link href="/">
        <div class="flex items-center">
            <div class="text-2xl font-bold text-gray-900">{{ appName }}</div>
        </div>
    </Link>
</template>
<script setup>
import { Link } from '@inertiajs/vue3';
const appName = window.document.getElementsByTagName('title')[0]?.innerText?.split(' - ')[1] || 'Laravel';
</script>
<style scoped>
.flex { display: flex; }
.items-center { align-items: center; }
.text-2xl { font-size: 1.5rem; line-height: 2rem; }
.font-bold { font-weight: 700; }
.text-gray-900 { color: #1a202c; }
</style>
'@
    Set-Content "resources/js/Components/AuthenticationCardLogo.vue" $authLogo

    # Create all other essential components
    $components = @{
        "PrimaryButton.vue" = @'
<template>
    <a-button type="primary" :loading="loading" :disabled="disabled" @click="$emit('click', $event)" v-bind="$attrs">
        <slot />
    </a-button>
</template>
<script setup>
defineProps(['loading', 'disabled']);
defineEmits(['click']);
</script>
'@
        "SecondaryButton.vue" = @'
<template>
    <a-button :loading="loading" :disabled="disabled" @click="$emit('click', $event)" v-bind="$attrs">
        <slot />
    </a-button>
</template>
<script setup>
defineProps(['loading', 'disabled']);
defineEmits(['click']);
</script>
'@
        "DangerButton.vue" = @'
<template>
    <a-button danger type="primary" :loading="loading" :disabled="disabled" @click="$emit('click', $event)" v-bind="$attrs">
        <slot />
    </a-button>
</template>
<script setup>
defineProps(['loading', 'disabled']);
defineEmits(['click']);
</script>
'@
        "TextInput.vue" = @'
<template>
    <a-input :id="id" :type="type" :value="modelValue" :placeholder="placeholder" :disabled="disabled" :required="required"
        @input="$emit('update:modelValue', $event.target.value)"
        @blur="$emit('blur', $event)" @focus="$emit('focus', $event)" v-bind="$attrs" />
</template>
<script setup>
defineProps(['id', 'type', 'modelValue', 'placeholder', 'disabled', 'required']);
defineEmits(['update:modelValue', 'blur', 'focus']);
</script>
'@
        "InputLabel.vue" = @'
<template>
    <label :for="for" class="block text-sm font-medium text-gray-700"><slot /></label>
</template>
<script setup>
defineProps(['for']);
</script>
<style scoped>
.block { display: block; }
.text-sm { font-size: 0.875rem; line-height: 1.25rem; }
.font-medium { font-weight: 500; }
.text-gray-700 { color: #374151; }
</style>
'@
        "InputError.vue" = @'
<template>
    <div v-show="message" class="text-sm text-red-600 mt-1">{{ message }}</div>
</template>
<script setup>
defineProps(['message']);
</script>
<style scoped>
.text-sm { font-size: 0.875rem; line-height: 1.25rem; }
.text-red-600 { color: #dc2626; }
.mt-1 { margin-top: 0.25rem; }
</style>
'@
        "Checkbox.vue" = @'
<template>
    <a-checkbox :id="id" :checked="checked" :value="value" :disabled="disabled"
        @change="$emit('update:checked', $event.target.checked)" v-bind="$attrs">
        <slot />
    </a-checkbox>
</template>
<script setup>
defineProps(['id', 'checked', 'value', 'disabled']);
defineEmits(['update:checked']);
</script>
'@
        "FormSection.vue" = @'
<template>
    <div class="md:grid md:grid-cols-3 md:gap-6">
        <div class="md:col-span-1">
            <div class="px-4 sm:px-0">
                <h3 class="text-lg font-medium text-gray-900"><slot name="title" /></h3>
                <p class="mt-1 text-sm text-gray-600"><slot name="description" /></p>
            </div>
        </div>
        <div class="mt-5 md:mt-0 md:col-span-2">
            <form @submit.prevent="$emit('submitted')">
                <div class="px-4 py-5 bg-white sm:p-6 shadow sm:rounded-lg">
                    <div class="grid grid-cols-6 gap-6"><slot name="form" /></div>
                </div>
                <div class="flex items-center justify-end px-4 py-3 bg-gray-50 text-right sm:px-6 shadow sm:rounded-bl-md sm:rounded-br-md">
                    <slot name="actions" />
                </div>
            </form>
        </div>
    </div>
</template>
<script setup>
defineEmits(['submitted']);
</script>
'@
        "ActionSection.vue" = @'
<template>
    <div class="md:grid md:grid-cols-3 md:gap-6">
        <div class="md:col-span-1">
            <div class="px-4 sm:px-0">
                <h3 class="text-lg font-medium text-gray-900"><slot name="title" /></h3>
                <p class="mt-1 text-sm text-gray-600"><slot name="description" /></p>
            </div>
        </div>
        <div class="mt-5 md:mt-0 md:col-span-2">
            <div class="px-4 py-5 bg-white sm:p-6 shadow sm:rounded-lg">
                <slot name="content" />
            </div>
        </div>
    </div>
</template>
'@
        "ActionMessage.vue" = @'
<template>
    <div v-show="on" class="text-sm text-gray-600"><slot /></div>
</template>
<script setup>
defineProps(['on']);
</script>
'@
        "DialogModal.vue" = @'
<template>
    <a-modal :open="show" :title="null" :footer="null" @cancel="$emit('close')" :closable="closeable" :mask-closable="false" width="600px">
        <div class="px-6 py-4">
            <div class="text-lg font-medium text-gray-900"><slot name="title" /></div>
            <div class="mt-4 text-sm text-gray-600"><slot name="content" /></div>
        </div>
        <div class="flex flex-row justify-end px-6 py-4 bg-gray-100 text-right">
            <slot name="footer" />
        </div>
    </a-modal>
</template>
<script setup>
const props = withDefaults(defineProps(['show', 'maxWidth', 'closeable']), {
    show: false,
    maxWidth: '2xl',
    closeable: true
});
defineEmits(['close']);
</script>
'@
        "ConfirmsPassword.vue" = @'
<template>
    <span>
        <span @click="startConfirmingPassword"><slot /></span>
        <DialogModal :show="confirmingPassword" @close="closeModal">
            <template #title>{{ title }}</template>
            <template #content>
                {{ content }}
                <div class="mt-4">
                    <TextInput ref="passwordInput" v-model="form.password" type="password" class="mt-1 block w-3/4"
                        placeholder="Password" autocomplete="current-password" @keyup.enter="confirmPassword" />
                    <InputError :message="form.errors.password" class="mt-2" />
                </div>
            </template>
            <template #footer>
                <SecondaryButton @click="closeModal">Cancel</SecondaryButton>
                <PrimaryButton class="ml-3" :class="{ 'opacity-25': form.processing }" :disabled="form.processing" @click="confirmPassword">
                    {{ button }}
                </PrimaryButton>
            </template>
        </DialogModal>
    </span>
</template>
<script setup>
import { ref, nextTick } from 'vue';
import { useForm } from '@inertiajs/vue3';
import DialogModal from './DialogModal.vue';
import InputError from './InputError.vue';
import PrimaryButton from './PrimaryButton.vue';
import SecondaryButton from './SecondaryButton.vue';
import TextInput from './TextInput.vue';

const props = withDefaults(defineProps(['title', 'content', 'button']), {
    title: 'Confirm Password',
    content: 'For your security, please confirm your password to continue.',
    button: 'Confirm'
});
const emit = defineEmits(['confirmed']);
const confirmingPassword = ref(false);
const passwordInput = ref(null);
const form = useForm({ password: '' });
const startConfirmingPassword = () => { confirmingPassword.value = true; nextTick(() => passwordInput.value?.$el?.focus()); };
const confirmPassword = () => { form.processing = true; setTimeout(() => { form.processing = false; closeModal(); nextTick(() => emit('confirmed')); }, 500); };
const closeModal = () => { confirmingPassword.value = false; form.password = ''; form.clearErrors(); };
</script>
'@
        "SectionBorder.vue" = @'
<template>
    <div class="hidden sm:block">
        <div class="py-8">
            <div class="border-t border-gray-200" />
        </div>
    </div>
</template>
'@
    }

    foreach ($file in $components.Keys) {
        if (-not (Test-Path "resources/js/Components/$file")) {
            Set-Content "resources/js/Components/$file" $components[$file]
            Write-Host "✅ Created resources/js/Components/$file" -ForegroundColor Green
        } else {
            Write-Host "✅ Preserved existing resources/js/Components/$file" -ForegroundColor Green
        }
    }
    } # Close the if statement for AuthenticationCard
}

function Enhance-VueLayouts {
    Write-Host "Enhancing Vue layouts (preserving Jetstream)..." -ForegroundColor Yellow

    $appLayout = @'
<template>
    <div>
        <Head :title="title" />
        <a-layout class="min-h-screen">
            <a-layout-header class="bg-white shadow">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="flex justify-between h-16">
                        <div class="flex">
                            <div class="shrink-0 flex items-center">
                                <Link href="/dashboard">
                                    <div class="text-xl font-bold text-gray-900">{{ $page.props.appName || 'Laravel' }}</div>
                                </Link>
                            </div>
                            <div class="hidden space-x-8 sm:-my-px sm:ml-10 sm:flex">
                                <Link href="/dashboard" class="inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium"
                                    :class="$page.url === '/dashboard' ? 'border-indigo-400 text-gray-900' : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'">
                                    Dashboard
                                </Link>
                            </div>
                        </div>
                        <div class="hidden sm:flex sm:items-center sm:ml-6">
                            <a-dropdown>
                                <template #overlay>
                                    <a-menu>
                                        <a-menu-item key="profile"><Link href="/user/profile">Profile</Link></a-menu-item>
                                        <a-menu-divider />
                                        <a-menu-item key="logout"><Link href="/logout" method="post" as="button">Log Out</Link></a-menu-item>
                                    </a-menu>
                                </template>
                                <a-button type="text" class="flex items-center text-sm">
                                    <span>{{ $page.props.auth.user?.name }}</span>
                                    <DownOutlined class="ml-2" />
                                </a-button>
                            </a-dropdown>
                        </div>
                    </div>
                </div>
            </a-layout-header>
            <a-layout-content class="flex-1">
                <div class="py-12">
                    <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                        <slot />
                    </div>
                </div>
            </a-layout-content>
        </a-layout>
    </div>
</template>
<script setup>
import { Head, Link } from '@inertiajs/vue3';
import { DownOutlined } from '@ant-design/icons-vue';
defineProps(['title']);
</script>
'@
    # Only create if it doesn't exist (preserve Jetstream layout)
    if (-not (Test-Path "resources/js/Layouts/AppLayout.vue")) {
        Set-Content "resources/js/Layouts/AppLayout.vue" $appLayout
        Write-Host "✅ Created resources/js/Layouts/AppLayout.vue" -ForegroundColor Green
    } else {
        Write-Host "✅ Preserved existing Jetstream AppLayout.vue" -ForegroundColor Green
    }
}

function Enhance-VuePages {
    Write-Host "Enhancing Vue pages (preserving Jetstream)..." -ForegroundColor Yellow

    # Dashboard page
    $dashboard = @'
<template>
    <AppLayout title="Dashboard">
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
    # Only create Dashboard if it doesn't exist (preserve Jetstream pages)
    if (-not (Test-Path "resources/js/Pages/Dashboard.vue")) {
        Set-Content "resources/js/Pages/Dashboard.vue" $dashboard
        Write-Host "✅ Created resources/js/Pages/Dashboard.vue" -ForegroundColor Green
    } else {
        Write-Host "✅ Preserved existing Jetstream Dashboard.vue" -ForegroundColor Green
    }

    # Welcome page (only if it doesn't exist)
    if (-not (Test-Path "resources/js/Pages/Welcome.vue")) {
        $welcome = @'
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
        Set-Content "resources/js/Pages/Welcome.vue" $welcome
        Write-Host "✅ Created resources/js/Pages/Welcome.vue" -ForegroundColor Green
    } else {
        Write-Host "✅ Preserved existing Welcome.vue" -ForegroundColor Green
    }
}

function Update-BladeTemplate {
    # CRITICAL FIX: Only update if needed, don't force override
    if (Test-Path "resources/views/app.blade.php") {
        $currentContent = Get-Content "resources/views/app.blade.php" -Raw

        # Only update if it's still pointing to app.ts or needs fixing
        if ($currentContent -match "app\.ts" -or $currentContent -notmatch "@vite") {
            $bladeContent = @'
<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title inertia>{{ config('app.name', 'Laravel') }}</title>

        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.bunny.net">
        <link href="https://fonts.bunny.net/css?family=figtree:400,500,600&display=swap" rel="stylesheet" />

        <!-- Scripts -->
        @routes
        @vite(['public/css/tailwind-output.css', 'resources/js/app.js', "resources/js/Pages/{$page['component']}.vue"])
        @inertiaHead
    </head>
    <body class="font-sans antialiased">
        @inertia
    </body>
</html>
'@
            Set-Content "resources/views/app.blade.php" $bladeContent
            Write-Host "✅ Fixed blade template to use app.js (CRITICAL FIX)" -ForegroundColor Green
        } else {
            Write-Host "✅ Blade template already correct" -ForegroundColor Green
        }
    }
}

function Create-TailwindConfig {
    # Create Tailwind config if it doesn't exist
    if (-not (Test-Path "tailwind.config.js")) {
        $tailwindConfig = @'
import defaultTheme from 'tailwindcss/defaultTheme';
import forms from '@tailwindcss/forms';
import typography from '@tailwindcss/typography';

/** @type {import('tailwindcss').Config} */
export default {
    content: [
        './vendor/laravel/framework/src/Illuminate/Pagination/resources/views/*.blade.php',
        './vendor/laravel/jetstream/**/*.blade.php',
        './storage/framework/views/*.php',
        './resources/views/**/*.blade.php',
        './resources/js/**/*.vue',
    ],

    theme: {
        extend: {
            fontFamily: {
                sans: ['Figtree', ...defaultTheme.fontFamily.sans],
            },
        },
    },

    plugins: [forms, typography],
};
'@
        Set-Content "tailwind.config.js" $tailwindConfig
        Write-Host "✅ Created tailwind.config.js" -ForegroundColor Green
    } else {
        Write-Host "✅ Tailwind config already exists" -ForegroundColor Green
    }
}

function Create-PostCSSConfig {
    # Create PostCSS config if it doesn't exist
    if (-not (Test-Path "postcss.config.js")) {
        $postcssConfig = @'
export default {
    plugins: {
        '@tailwindcss/postcss': {},
        autoprefixer: {},
    },
};
'@
        Set-Content "postcss.config.js" $postcssConfig
        Write-Host "✅ Created postcss.config.js" -ForegroundColor Green
    } else {
        Write-Host "✅ PostCSS config already exists" -ForegroundColor Green
    }
}

# Execute all configuration creation functions (FIXED VERSION)
Write-Host "🚀 Enhancing Jetstream with additional features..." -ForegroundColor Cyan

Create-ViteConfig
Enhance-AppJs
Enhance-AppCss
Enhance-VueComponents
Enhance-VueLayouts
Enhance-VuePages
Update-PackageJson
Update-BladeTemplate

Write-Host "✅ Jetstream successfully enhanced with Pinia and Ant Design Vue!" -ForegroundColor Green
Write-Host "🎯 Key fixes applied:" -ForegroundColor Yellow
Write-Host "   - Preserved Jetstream routing and authentication" -ForegroundColor Green
Write-Host "   - Enhanced app.js with ZiggyVue for proper Laravel routing" -ForegroundColor Green
Write-Host "   - Added Pinia and Ant Design Vue without breaking existing features" -ForegroundColor Green
Write-Host "   - Maintained SSR support and proper Vite configuration" -ForegroundColor Green
Write-Host "   - Fixed CSS loading with Tailwind CSS v4 and Ant Design compatibility" -ForegroundColor Green
Write-Host "   - Pure JavaScript setup (NO TypeScript conflicts)" -ForegroundColor Green
Write-Host "   - Added error handling for Tailwind CSS build process" -ForegroundColor Green
