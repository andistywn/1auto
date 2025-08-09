<script setup>
import { Head } from '@inertiajs/vue3';
import { h } from 'vue';
import { FileTextOutlined, CheckCircleOutlined, ClockCircleOutlined, SafetyOutlined } from '@ant-design/icons-vue';

defineProps({
    terms: String,
});
</script>

<template>
    <Head title="Terms of Service" />

    <div style="min-height: 100vh; background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%); display: flex; align-items: center; justify-content: center; padding: 24px;">
        <div style="width: 100%; max-width: 900px;">
            <!-- Header -->
            <div style="text-align: center; margin-bottom: 48px;">
                <div style="display: flex; justify-content: center; margin-bottom: 32px;">
                    <div style="width: 96px; height: 96px; border-radius: 50%; background: linear-gradient(135deg, #fa8c16 0%, #d46b08 100%); display: flex; align-items: center; justify-content: center; box-shadow: 0 8px 32px rgba(250, 140, 22, 0.4);">
                        <FileTextOutlined style="font-size: 48px; color: white;" />
                    </div>
                </div>
                <h1 style="color: #fa8c16; font-size: 42px; font-weight: bold; margin: 0 0 20px 0; letter-spacing: -0.5px;">
                    Terms of Service
                </h1>
                <p style="color: #666; font-size: 20px; line-height: 1.6; max-width: 600px; margin: 0 auto;">
                    By using our services, you agree to these terms and conditions.
                </p>
            </div>

            <!-- Terms Content -->
            <a-card
                style="border-radius: 16px; box-shadow: 0 8px 32px rgba(0,0,0,0.1); margin-bottom: 32px; background: linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(255, 255, 255, 0.9) 100%);"
                :bordered="false"
            >
                <template #title>
                    <div style="display: flex; align-items: center;">
                        <SafetyOutlined style="font-size: 24px; margin-right: 12px; color: #fa8c16;" />
                        <span style="font-size: 20px; font-weight: 600;">Terms of Service Agreement</span>
                    </div>
                </template>
                <template #extra>
                    <a-tag color="orange" style="font-weight: 500; border-radius: 4px;">Legal</a-tag>
                </template>

                <div
                    v-html="terms"
                    style="line-height: 1.8; color: #333; font-size: 16px; padding: 24px 0; text-align: justify;"
                />
            </a-card>

            <!-- Key Points -->
            <a-row :gutter="[24, 24]" style="margin-bottom: 32px;">
                <a-col :xs="24" :md="8">
                    <a-card
                        hoverable
                        style="text-align: center; border-radius: 16px; box-shadow: 0 8px 24px rgba(0,0,0,0.1); transition: all 0.3s ease; background: linear-gradient(135deg, rgba(24, 144, 255, 0.05) 0%, rgba(24, 144, 255, 0.1) 100%);"
                    >
                        <div style="display: flex; justify-content: center; margin-bottom: 20px;">
                            <div style="width: 64px; height: 64px; border-radius: 50%; background: rgba(24, 144, 255, 0.1); display: flex; align-items: center; justify-content: center; box-shadow: 0 8px 24px rgba(24, 144, 255, 0.2);">
                                <CheckCircleOutlined style="font-size: 32px; color: #1890ff;" />
                            </div>
                        </div>
                        <h3 style="color: #1890ff; margin-bottom: 12px; font-size: 18px; font-weight: 600;">Acceptance</h3>
                        <p style="color: #666; font-size: 15px; line-height: 1.6;">
                            By using our service, you accept these terms and conditions
                        </p>
                    </a-card>
                </a-col>
                <a-col :xs="24" :md="8">
                    <a-card
                        hoverable
                        style="text-align: center; border-radius: 16px; box-shadow: 0 8px 24px rgba(0,0,0,0.1); transition: all 0.3s ease; background: linear-gradient(135deg, rgba(82, 196, 26, 0.05) 0%, rgba(82, 196, 26, 0.1) 100%);"
                    >
                        <div style="display: flex; justify-content: center; margin-bottom: 20px;">
                            <div style="width: 64px; height: 64px; border-radius: 50%; background: rgba(82, 196, 26, 0.1); display: flex; align-items: center; justify-content: center; box-shadow: 0 8px 24px rgba(82, 196, 26, 0.2);">
                                <SafetyOutlined style="font-size: 32px; color: #52c41a;" />
                            </div>
                        </div>
                        <h3 style="color: #52c41a; margin-bottom: 12px; font-size: 18px; font-weight: 600;">Compliance</h3>
                        <p style="color: #666; font-size: 15px; line-height: 1.6;">
                            Follow all applicable laws and regulations while using our services
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
                        <h3 style="color: #722ed1; margin-bottom: 12px; font-size: 18px; font-weight: 600;">Updates</h3>
                        <p style="color: #666; font-size: 15px; line-height: 1.6;">
                            Terms may be updated from time to time with proper notification
                        </p>
                    </a-card>
                </a-col>
            </a-row>

            <!-- Footer -->
            <div style="text-align: center; color: #666; font-size: 16px; padding: 32px; background: linear-gradient(135deg, rgba(255, 255, 255, 0.9) 0%, rgba(255, 255, 255, 0.8) 100%); border-radius: 16px; box-shadow: 0 8px 24px rgba(0,0,0,0.1);">
                <div style="display: flex; align-items: center; justify-content: center; margin-bottom: 12px;">
                    <ClockCircleOutlined style="font-size: 20px; margin-right: 12px; color: #fa8c16;" />
                    <span style="font-weight: 500;">Last updated: {{ new Date().toLocaleDateString() }}</span>
                </div>
                <p style="margin: 0; font-size: 14px; color: #999;">
                    © 2024 Laravel Starter Kit. All rights reserved.
                </p>
            </div>
        </div>
    </div>
</template>
