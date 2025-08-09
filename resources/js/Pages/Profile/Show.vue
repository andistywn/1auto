<script setup>
import { reactive } from 'vue';
import { useForm } from '@inertiajs/vue3';
import AppLayout from '@/Layouts/AppLayout.vue';
import { UserOutlined, GlobalOutlined, DeleteOutlined, SettingOutlined } from '@ant-design/icons-vue';
import { message } from 'ant-design-vue';

const props = defineProps({
    user: {
        type: Object,
        required: true,
        default: () => ({
            name: '',
            email: '',
            created_at: new Date().toISOString(),
        })
    },
    confirmsTwoFactorAuthentication: Boolean,
    sessions: {
        type: Array,
        default: () => []
    },
});

const profileForm = reactive({
    name: props.user?.name || '',
    email: props.user?.email || '',
});

const passwordForm = reactive({
    current_password: '',
    password: '',
    password_confirmation: '',
});

const updateProfile = () => {
    const form = useForm(profileForm);
    form.put(route('user-profile-information.update'), {
        onSuccess: () => message.success('Profile updated successfully'),
        onError: () => message.error('Failed to update profile'),
    });
};

const updatePassword = () => {
    const form = useForm(passwordForm);
    form.put(route('user-password.update'), {
        onSuccess: () => {
            message.success('Password updated successfully');
            passwordForm.current_password = '';
            passwordForm.password = '';
            passwordForm.password_confirmation = '';
        },
        onError: () => message.error('Failed to update password'),
    });
};
</script>

<template>
    <AppLayout>
        <template #header>
            <a-page-header
                title="Profile"
                sub-title="Manage your account settings and preferences"
                style="background: white; padding: 24px; border-radius: 12px; margin-bottom: 24px; box-shadow: 0 4px 12px rgba(0,0,0,0.1);"
            >
                <template #extra>
                    <a-space>
                        <a-button type="primary" size="large" icon style="border-radius: 8px; font-weight: 500;">
                            <SettingOutlined /> Settings
                        </a-button>
                        <a-button size="large" icon style="border-radius: 8px; font-weight: 500;">
                            <UserOutlined /> Edit Profile
                        </a-button>
                    </a-space>
                </template>
            </a-page-header>
        </template>

        <div style="padding: 0 24px;">
            <a-row :gutter="[24, 24]">
                <!-- Left Column - Profile Information -->
                <a-col :xs="24" :lg="8">
                    <!-- Profile Card -->
                    <a-card
                        title="Profile Information"
                        style="border-radius: 16px; box-shadow: 0 8px 24px rgba(0,0,0,0.1); margin-bottom: 24px; transition: all 0.3s ease; background: linear-gradient(135deg, rgba(24, 144, 255, 0.05) 0%, rgba(24, 144, 255, 0.1) 100%);"
                        :bordered="false"
                    >
                        <div style="text-align: center; margin-bottom: 32px;">
                            <a-avatar
                                :size="96"
                                style="border: 4px solid #f0f0f0; box-shadow: 0 8px 24px rgba(24, 144, 255, 0.3);"
                                :style="{ backgroundColor: '#1890ff' }"
                            >
                                <UserOutlined style="font-size: 40px; color: white;" />
                            </a-avatar>
                            <h3 style="margin: 20px 0 12px 0; color: #1890ff; font-size: 22px; font-weight: 600;">{{ user?.name || 'User' }}</h3>
                            <p style="color: #666; margin: 0; font-size: 16px;">{{ user?.email || 'user@example.com' }}</p>
                        </div>

                        <a-descriptions :column="1" size="middle">
                            <a-descriptions-item label="Member Since">
                                {{ user?.created_at ? new Date(user.created_at).toLocaleDateString() : 'N/A' }}
                            </a-descriptions-item>
                            <a-descriptions-item label="Account Status">
                                <a-tag color="green" style="border-radius: 4px; font-size: 14px; font-weight: 500;">Active</a-tag>
                            </a-descriptions-item>
                            <a-descriptions-item label="Account Type">
                                <a-tag color="blue" style="border-radius: 4px; font-size: 14px; font-weight: 500;">Premium</a-tag>
                            </a-descriptions-item>
                        </a-descriptions>
                    </a-card>

                    <!-- Update Password Card -->
                    <a-card
                        title="Update Password"
                        style="border-radius: 16px; box-shadow: 0 8px 24px rgba(0,0,0,0.1); transition: all 0.3s ease; background: linear-gradient(135deg, rgba(250, 140, 22, 0.05) 0%, rgba(250, 140, 22, 0.1) 100%);"
                        :bordered="false"
                    >
                        <template #extra>
                            <a-tag color="orange" style="border-radius: 4px; font-size: 12px; font-weight: 500;">Security</a-tag>
                        </template>
                        <a-form
                            :model="passwordForm"
                            layout="vertical"
                            @finish="updatePassword"
                        >
                            <a-form-item label="Current Password" required>
                                <a-input-password
                                    v-model:value="passwordForm.current_password"
                                    placeholder="Enter current password"
                                    size="large"
                                    style="border-radius: 8px;"
                                />
                            </a-form-item>
                            <a-form-item label="New Password" required>
                                <a-input-password
                                    v-model:value="passwordForm.password"
                                    placeholder="Enter new password"
                                    size="large"
                                    style="border-radius: 8px;"
                                />
                            </a-form-item>
                            <a-form-item label="Confirm Password" required>
                                <a-input-password
                                    v-model:value="passwordForm.password_confirmation"
                                    placeholder="Confirm new password"
                                    size="large"
                                    style="border-radius: 8px;"
                                />
                            </a-form-item>
                            <a-form-item>
                                <a-button
                                    type="primary"
                                    html-type="submit"
                                    block
                                    size="large"
                                    :loading="false"
                                    style="border-radius: 8px; font-weight: 500;"
                                >
                                    Update Password
                                </a-button>
                            </a-form-item>
                        </a-form>
                    </a-card>
                </a-col>

                <!-- Right Column - Settings -->
                <a-col :xs="24" :lg="16">
                    <!-- Two Factor Authentication -->
                    <a-card
                        title="Two Factor Authentication"
                        style="border-radius: 16px; box-shadow: 0 8px 24px rgba(0,0,0,0.1); margin-bottom: 24px; transition: all 0.3s ease; background: linear-gradient(135deg, rgba(82, 196, 26, 0.05) 0%, rgba(82, 196, 26, 0.1) 100%);"
                        :bordered="false"
                    >
                        <template #extra>
                            <a-switch checked-children="On" un-checked-children="Off" default-checked style="border-radius: 4px;" />
                        </template>

                        <a-alert
                            message="Two factor authentication is currently enabled"
                            type="success"
                            show-icon
                            style="margin-bottom: 20px; border-radius: 8px;"
                        />
                        <p style="color: #666; margin-bottom: 20px; font-size: 15px; line-height: 1.6;">
                            Add an extra layer of security to your account by requiring a second form of verification when you log in.
                        </p>
                        <a-space>
                            <a-button type="primary" size="large" style="border-radius: 8px; font-weight: 500;">Manage Two Factor</a-button>
                            <a-button size="large" style="border-radius: 8px; font-weight: 500;">View Recovery Codes</a-button>
                        </a-space>
                    </a-card>

                    <!-- Browser Sessions -->
                    <a-card
                        title="Browser Sessions"
                        style="border-radius: 16px; box-shadow: 0 8px 24px rgba(0,0,0,0.1); margin-bottom: 24px; transition: all 0.3s ease; background: linear-gradient(135deg, rgba(114, 46, 209, 0.05) 0%, rgba(114, 46, 209, 0.1) 100%);"
                        :bordered="false"
                    >
                        <template #extra>
                            <a-button type="link" size="small" style="font-weight: 500;">
                                <GlobalOutlined /> Current: {{ sessions?.length || 0 }}
                            </a-button>
                        </template>

                        <p style="color: #666; margin-bottom: 20px; font-size: 15px; line-height: 1.6;">
                            Manage and log out your active sessions on other browsers and devices.
                        </p>
                        <a-list :data-source="sessions || []" size="middle">
                            <template #renderItem="{ item }">
                                <a-list-item style="border-bottom: 1px solid #f0f0f0; padding: 16px 0;">
                                    <a-list-item-meta>
                                        <template #avatar>
                                            <a-avatar :style="{ backgroundColor: item.color || '#1890ff' }">
                                                <GlobalOutlined />
                                            </a-avatar>
                                        </template>
                                        <template #title>
                                            <span style="font-weight: 600; font-size: 15px;">{{ item.browser }}</span>
                                        </template>
                                        <template #description>
                                            <span style="color: #666; font-size: 14px;">{{ item.ip_address }}</span>
                                        </template>
                                    </a-list-item-meta>
                                    <template #actions>
                                        <span style="color: #999; font-size: 13px; font-weight: 500;">{{ item.last_active }}</span>
                                    </template>
                                </a-list-item>
                            </template>
                        </a-list>
                        <div style="text-align: center; margin-top: 20px;">
                            <a-button type="primary" danger style="border-radius: 8px; font-weight: 500;">
                                <DeleteOutlined /> Log Out Other Browser Sessions
                            </a-button>
                        </div>
                    </a-card>

                    <!-- Delete Account -->
                    <a-card
                        title="Delete Account"
                        style="border-radius: 16px; box-shadow: 0 8px 24px rgba(0,0,0,0.1); transition: all 0.3s ease; background: linear-gradient(135deg, rgba(255, 77, 79, 0.05) 0%, rgba(255, 77, 79, 0.1) 100%);"
                        :bordered="false"
                    >
                        <template #extra>
                            <a-tag color="red" style="border-radius: 4px; font-size: 12px; font-weight: 500;">Danger</a-tag>
                        </template>
                        <a-alert
                            message="Permanently delete account"
                            description="Once your account is deleted, all of its resources and data will be permanently deleted. Please be certain."
                            type="error"
                            show-icon
                            style="margin-bottom: 20px; border-radius: 8px;"
                        />
                        <a-button type="primary" danger style="border-radius: 8px; font-weight: 500;">
                            <DeleteOutlined /> Delete Account
                        </a-button>
                    </a-card>
                </a-col>
            </a-row>
        </div>
    </AppLayout>
</template>
