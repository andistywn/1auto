<script setup>
import { Head } from '@inertiajs/vue3';
import { h } from 'vue';
import { ShieldOutlined, FileTextOutlined, ClockCircleOutlined } from '@ant-design/icons-vue';

defineProps({
    policy: String,
});
</script>

<template>
    <Head title="Privacy Policy" />

    <div style="min-height: 100vh; background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%); display: flex; align-items: center; justify-content: center; padding: 24px;">
        <div style="width: 100%; max-width: 900px;">
            <!-- Header -->
            <div style="text-align: center; margin-bottom: 56px;">
                <div style="display: flex; justify-content: center; margin-bottom: 40px;">
                    <div style="width: 120px; height: 120px; border-radius: 50%; background: linear-gradient(135deg, #1890ff 0%, #096dd9 100%); display: flex; align-items: center; justify-content: center; box-shadow: 0 16px 48px rgba(24, 144, 255, 0.4); border: 4px solid rgba(255, 255, 255, 0.2);">
                        <ShieldOutlined style="font-size: 60px; color: white;" />
                    </div>
                </div>
                <h1 style="color: #1890ff; font-size: 48px; font-weight: bold; margin: 0 0 24px 0; letter-spacing: -0.5px; text-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);">
                    Privacy Policy
                </h1>
                <p style="color: #666; font-size: 22px; line-height: 1.6; max-width: 600px; margin: 0 auto; font-weight: 500;">
                    Your privacy is important to us. This policy explains how we collect, use, and protect your information.
                </p>
            </div>

            <!-- Policy Content -->
            <a-card
                style="border-radius: 20px; box-shadow: 0 12px 40px rgba(0,0,0,0.15); margin-bottom: 40px; background: linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(255, 255, 255, 0.9) 100%); border: 1px solid rgba(0,0,0,0.05);"
                :bordered="false"
            >
                <template #title>
                    <div style="display: flex; align-items: center;">
                        <FileTextOutlined style="font-size: 28px; margin-right: 16px; color: #1890ff;" />
                        <span style="font-size: 24px; font-weight: 700;">Privacy Policy Details</span>
                    </div>
                </template>
                <template #extra>
                    <a-tag color="blue" style="font-weight: 600; border-radius: 6px; font-size: 14px; padding: 4px 12px;">Official</a-tag>
                </template>

                <div
                    v-html="policy"
                    style="line-height: 2; color: #333; font-size: 18px; padding: 32px 0; text-align: justify; font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;"
                />
            </a-card>

            <!-- Key Points -->
            <a-row :gutter="[24, 24]" style="margin-bottom: 32px;">
                <a-col :xs="24" :md="8">
                    <a-card
                        hoverable
                        style="text-align: center; border-radius: 16px; box-shadow: 0 8px 24px rgba(0,0,0,0.1); transition: all 0.3s ease; background: linear-gradient(135deg, rgba(82, 196, 26, 0.05) 0%, rgba(82, 196, 26, 0.1) 100%);"
                    >
                        <div style="display: flex; justify-content: center; margin-bottom: 20px;">
                            <div style="width: 64px; height: 64px; border-radius: 50%; background: rgba(82, 196, 26, 0.1); display: flex; align-items: center; justify-content: center; box-shadow: 0 8px 24px rgba(82, 196, 26, 0.2);">
                                <ShieldOutlined style="font-size: 32px; color: #52c41a;" />
                            </div>
                        </div>
                        <h3 style="color: #52c41a; margin-bottom: 12px; font-size: 18px; font-weight: 600;">Secure</h3>
                        <p style="color: #666; font-size: 15px; line-height: 1.6;">
                            Your data is encrypted and stored securely with industry-standard protocols
                        </p>
                    </a-card>
                </a-col>
                <a-col :xs="24" :md="8">
                    <a-card
                        hoverable
                        style="text-align: center; border-radius: 16px; box-shadow: 0 8px 24px rgba(0,0,0,0.1); transition: all 0.3s ease; background: linear-gradient(135deg, rgba(24, 144, 255, 0.05) 0%, rgba(24, 144, 255, 0.1) 100%);"
                    >
                        <div style="display: flex; justify-content: center; margin-bottom: 20px;">
                            <div style="width: 64px; height: 64px; border-radius: 50%; background: rgba(24, 144, 255, 0.1); display: flex; align-items: center; justify-content: center; box-shadow: 0 8px 24px rgba(24, 144, 255, 0.2);">
                                <FileTextOutlined style="font-size: 32px; color: #1890ff;" />
                            </div>
                        </div>
                        <h3 style="color: #1890ff; margin-bottom: 12px; font-size: 18px; font-weight: 600;">Transparent</h3>
                        <p style="color: #666; font-size: 15px; line-height: 1.6;">
                            We are clear about how we use your data and provide full control over your information
                        </p>
                    </a-card>
                </a-col>
                <a-col :xs="24" :md="8">
                    <a-card
                        hoverable
                        style="text-align: center; border-radius: 16px; box-shadow: 0 8px 24px rgba(0,0,0,0.1); transition: all 0.3s ease; background: linear-gradient(135deg, rgba(114, 46, 209, 0.05) 0%, rgba(114, 46, 209, 0.1) 100%);"
                    >
                        <div style="display: flex; justify-content: center; margin-bottom: 20px;">
                            <div style="width: 64px; height: 64px; border-radius: 50%; background: rgba(114, 46, 209, 0.1); display: flex; align-items: center; justify-content: center; box-shadow: 0 8px 24px rgba(114, 46, 209, 0.2);">
                                <ClockCircleOutlined style="font-size: 32px; color: #722ed1;" />
                            </div>
                        </div>
                        <h3 style="color: #722ed1; margin-bottom: 12px; font-size: 18px; font-weight: 600;">Updated</h3>
                        <p style="color: #666; font-size: 15px; line-height: 1.6;">
                            Regularly reviewed and updated to comply with the latest regulations
                        </p>
                    </a-card>
                </a-col>
            </a-row>

            <!-- Footer -->
            <div style="text-align: center; color: #666; font-size: 16px; padding: 32px; background: linear-gradient(135deg, rgba(255, 255, 255, 0.9) 0%, rgba(255, 255, 255, 0.8) 100%); border-radius: 16px; box-shadow: 0 8px 24px rgba(0,0,0,0.1);">
                <div style="display: flex; align-items: center; justify-content: center; margin-bottom: 12px;">
                    <ClockCircleOutlined style="font-size: 20px; margin-right: 12px; color: #1890ff;" />
                    <span style="font-weight: 500;">Last updated: {{ new Date().toLocaleDateString() }}</span>
                </div>
                <p style="margin: 0; font-size: 14px; color: #999;">
                    © 2024 Laravel Starter Kit. All rights reserved.
                </p>
            </div>
        </div>
    </div>
</template>
