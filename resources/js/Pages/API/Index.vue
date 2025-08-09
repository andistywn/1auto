<script setup>
import ApiTokenManager from '@/Pages/API/Partials/ApiTokenManager.vue';
import AppLayout from '@/Layouts/AppLayout.vue';
import { ApiOutlined, InfoCircleOutlined, SettingOutlined } from '@ant-design/icons-vue';

defineProps({
    tokens: Array,
    availablePermissions: Array,
    defaultPermissions: Array,
});
</script>

<template>
    <AppLayout>
        <template #header>
            <a-page-header
                title="API Tokens"
                sub-title="Manage your API access tokens"
                style="background: white; padding: 24px; border-radius: 8px; margin-bottom: 24px;"
            >
                <template #extra>
                    <a-button type="primary" size="large" icon>
                        <ApiOutlined /> New Token
                    </a-button>
                </template>
            </a-page-header>
        </template>

        <div style="padding: 0 24px;">
            <a-card
                title="Token Management"
                style="border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);"
                :bordered="false"
            >
                <template #extra>
                    <a-space>
                        <a-button type="link" size="small">
                            <InfoCircleOutlined /> Help
                        </a-button>
                        <a-button type="link" size="small">
                            <SettingOutlined /> Settings
                        </a-button>
                    </a-space>
                </template>

                <ApiTokenManager
                    :tokens="tokens"
                    :available-permissions="availablePermissions"
                    :default-permissions="defaultPermissions"
                />
            </a-card>
        </div>
    </AppLayout>
</template>
