<script setup>
import { Head, Link } from '@inertiajs/vue3';
import { h } from 'vue';
import { LaptopOutlined, BookOutlined, VideoCameraOutlined, ApiOutlined, DashboardOutlined, LoginOutlined, UserAddOutlined, ReadOutlined, PlayCircleOutlined, BellOutlined } from '@ant-design/icons-vue';

defineProps({
    canLogin: {
        type: Boolean,
    },
    canRegister: {
        type: Boolean,
    },
    laravelVersion: {
        type: String,
        required: true,
    },
    phpVersion: {
        type: String,
        required: true,
    },
});

function handleImageError() {
    document.getElementById('screenshot-container')?.classList.add('!hidden');
    document.getElementById('docs-card')?.classList.add('!row-span-1');
    document.getElementById('docs-card-content')?.classList.add('!flex-row');
    document.getElementById('background')?.classList.add('!hidden');
}
</script>

<template>
    <Head title="Welcome" />
    <div style="min-height: 100vh; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); display: flex; align-items: center; justify-content: center; padding: 24px;">
        <div style="width: 100%; max-width: 1200px;">
            <!-- Header Section -->
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 56px;">
                <div style="display: flex; align-items: center;">
                    <div style="width: 80px; height: 80px; border-radius: 20px; background: rgba(255, 255, 255, 0.2); backdrop-filter: blur(10px); display: flex; align-items: center; justify-content: center; margin-right: 24px; box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1); border: 1px solid rgba(255, 255, 255, 0.1);">
                        <LaptopOutlined style="font-size: 40px; color: white;" />
                    </div>
                    <div>
                        <h1 style="color: white; font-size: 42px; font-weight: bold; margin: 0; letter-spacing: -0.5px;">Laravel Starter Kit</h1>
                        <p style="color: rgba(255, 255, 255, 0.8); font-size: 18px; margin: 8px 0 0 0; font-weight: 500;">Modern Full-Stack Development</p>
                    </div>
                </div>

                <div v-if="canLogin" style="display: flex; gap: 20px;">
                    <Link v-if="$page.props.auth.user" :href="route('dashboard')">
                        <a-button type="primary" size="large" style="border-radius: 12px; font-weight: 600; box-shadow: 0 4px 16px rgba(24, 144, 255, 0.3);">
                            <DashboardOutlined /> Dashboard
                        </a-button>
                    </Link>

                    <template v-else>
                        <Link :href="route('login')">
                            <a-button size="large" style="border-radius: 12px; font-weight: 600; box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);">
                                <LoginOutlined /> Log in
                            </a-button>
                        </Link>

                        <Link v-if="canRegister" :href="route('register')">
                            <a-button type="primary" size="large" style="border-radius: 12px; font-weight: 600; box-shadow: 0 4px 16px rgba(24, 144, 255, 0.3);">
                                <UserAddOutlined /> Register
                            </a-button>
                        </Link>
                    </template>
                </div>
            </div>

            <!-- Welcome Message -->
            <div style="text-align: center; margin-bottom: 56px;">
                <h2 style="color: white; font-size: 48px; margin-bottom: 24px; font-weight: 700; letter-spacing: -0.5px; text-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);">
                    Welcome to Laravel + Vue 3 + TypeScript
                </h2>
                <p style="color: rgba(255, 255, 255, 0.9); font-size: 22px; margin: 0; line-height: 1.6; max-width: 800px; margin-left: auto; margin-right: auto; font-weight: 500;">
                    A modern full-stack application built with Laravel 12, Vue 3, TypeScript, Inertia.js, Pinia, and Ant Design Vue.
                </p>
            </div>

            <!-- Feature Cards -->
            <a-row :gutter="[24, 24]" style="margin-bottom: 56px;">
                <a-col :xs="24" :sm="12" :lg="6">
                    <a-card
                        hoverable
                        style="height: 100%; background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(10px); border-radius: 20px; transition: all 0.3s ease; box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15); border: 1px solid rgba(255, 255, 255, 0.2);"
                    >
                        <template #actions>
                            <a-button type="link" size="small" style="color: #1890ff; font-weight: 600;">
                                <ReadOutlined /> Read More
                            </a-button>
                        </template>
                        <div style="text-align: center;">
                            <div style="display: flex; justify-content: center; margin-bottom: 24px;">
                                <div style="width: 80px; height: 80px; border-radius: 50%; background: rgba(24, 144, 255, 0.1); display: flex; align-items: center; justify-content: center; box-shadow: 0 12px 32px rgba(24, 144, 255, 0.3);">
                                    <BookOutlined style="font-size: 40px; color: #1890ff;" />
                                </div>
                            </div>
                            <h3 style="color: #1890ff; margin-bottom: 20px; font-size: 24px; font-weight: 700;">Documentation</h3>
                            <p style="color: #666; font-size: 16px; line-height: 1.6; text-align: justify;">
                                Laravel has wonderful documentation covering every aspect of the framework. Whether you are a newcomer or have prior experience with Laravel, we recommend reading our documentation from beginning to end.
                            </p>
                        </div>
                    </a-card>
                </a-col>

                <a-col :xs="24" :sm="12" :lg="6">
                    <a-card
                        hoverable
                        style="height: 100%; background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(10px); border-radius: 20px; transition: all 0.3s ease; box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15); border: 1px solid rgba(255, 255, 255, 0.2);"
                    >
                        <template #actions>
                            <a-button type="link" size="small" style="color: #52c41a; font-weight: 600;">
                                <PlayCircleOutlined /> Watch Now
                            </a-button>
                        </template>
                        <div style="text-align: center;">
                            <div style="display: flex; justify-content: center; margin-bottom: 24px;">
                                <div style="width: 80px; height: 80px; border-radius: 50%; background: rgba(82, 196, 26, 0.1); display: flex; align-items: center; justify-content: center; box-shadow: 0 12px 32px rgba(82, 196, 26, 0.3);">
                                    <VideoCameraOutlined style="font-size: 40px; color: #52c41a;" />
                                </div>
                            </div>
                            <h3 style="color: #52c41a; margin-bottom: 20px; font-size: 24px; font-weight: 700;">Laracasts</h3>
                            <p style="color: #666; font-size: 16px; line-height: 1.6; text-align: justify;">
                                Laracasts offers thousands of video tutorials on Laravel, PHP, and JavaScript development. Check them out, see for yourself, and massively level up your development skills in the process.
                            </p>
                        </div>
                    </a-card>
                </a-col>

                <a-col :xs="24" :sm="12" :lg="6">
                    <a-card
                        hoverable
                        style="height: 100%; background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(10px); border-radius: 20px; transition: all 0.3s ease; box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15); border: 1px solid rgba(255, 255, 255, 0.2);"
                    >
                        <template #actions>
                            <a-button type="link" size="small" style="color: #fa8c16; font-weight: 600;">
                                <BellOutlined /> Subscribe
                            </a-button>
                        </template>
                        <div style="text-align: center;">
                            <div style="display: flex; justify-content: center; margin-bottom: 24px;">
                                <div style="width: 80px; height: 80px; border-radius: 50%; background: rgba(250, 140, 22, 0.1); display: flex; align-items: center; justify-content: center; box-shadow: 0 12px 32px rgba(250, 140, 22, 0.3);">
                                    <BookOutlined style="font-size: 40px; color: #fa8c16;" />
                                </div>
                            </div>
                            <h3 style="color: #fa8c16; margin-bottom: 20px; font-size: 24px; font-weight: 700;">Laravel News</h3>
                            <p style="color: #666; font-size: 16px; line-height: 1.6; text-align: justify;">
                                Laravel News is a community driven portal and newsletter aggregating all of the latest and most important news in the Laravel ecosystem, including new package releases and tutorials.
                            </p>
                        </div>
                    </a-card>
                </a-col>

                <a-col :xs="24" :sm="12" :lg="6">
                    <a-card
                        hoverable
                        style="height: 100%; background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(10px); border-radius: 20px; transition: all 0.3s ease; box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15); border: 1px solid rgba(255, 255, 255, 0.2);"
                    >
                        <template #actions>
                            <a-button type="link" size="small" style="color: #722ed1; font-weight: 600;">
                                <ApiOutlined /> Explore
                            </a-button>
                        </template>
                        <div style="text-align: center;">
                            <div style="display: flex; justify-content: center; margin-bottom: 24px;">
                                <div style="width: 80px; height: 80px; border-radius: 50%; background: rgba(114, 46, 209, 0.1); display: flex; align-items: center; justify-content: center; box-shadow: 0 12px 32px rgba(114, 46, 209, 0.3);">
                                    <ApiOutlined style="font-size: 40px; color: #722ed1;" />
                                </div>
                            </div>
                            <h3 style="color: #722ed1; margin-bottom: 20px; font-size: 24px; font-weight: 700;">Ecosystem</h3>
                            <p style="color: #666; font-size: 16px; line-height: 1.6; text-align: justify;">
                                Laravel's robust library of first-party tools and libraries help you take your projects to the next level. Powerful open source libraries like Cashier, Dusk, Echo, Horizon, Sanctum, and Telescope.
                            </p>
                        </div>
                    </a-card>
                </a-col>
            </a-row>

            <!-- Version Info -->
            <div style="text-align: center; color: rgba(255, 255, 255, 0.9); font-size: 18px; padding: 32px; background: rgba(255, 255, 255, 0.15); backdrop-filter: blur(10px); border-radius: 16px; margin-top: 32px; border: 1px solid rgba(255, 255, 255, 0.2); box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);">
                <p style="margin: 0; font-weight: 600; font-size: 20px;">Laravel v{{ laravelVersion }} (PHP v{{ phpVersion }})</p>
                <p style="margin: 12px 0 0 0; font-size: 16px; opacity: 0.9; font-weight: 500;">Built with ❤️ using modern web technologies</p>
            </div>
        </div>
    </div>
</template>
