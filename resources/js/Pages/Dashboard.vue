<script setup>
import { h } from 'vue';
import AppLayout from '@/Layouts/AppLayout.vue';
import { UserOutlined, TeamOutlined, ArrowUpOutlined, ClockCircleOutlined, PlusOutlined, BellOutlined, MessageOutlined, SettingOutlined } from '@ant-design/icons-vue';

defineProps({
    stats: {
        type: Object,
        default: () => ({
            users: 0,
            sessions: 0,
            teams: 0
        })
    },
    activities: {
        type: Array,
        default: () => []
    }
});
</script>

<template>
    <AppLayout>
        <template #header>
            <a-page-header
                title="Dashboard"
                sub-title="Welcome to your application dashboard"
                style="background: white; padding: 28px; border-radius: 16px; margin-bottom: 28px; box-shadow: 0 8px 24px rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.05);"
            >
                <template #extra>
                    <a-space size="large">
                        <a-badge count="3" dot>
                            <a-button type="primary" size="large" icon style="border-radius: 12px; font-weight: 600; box-shadow: 0 4px 16px rgba(24, 144, 255, 0.3);">
                                <PlusOutlined /> Quick Actions
                            </a-button>
                        </a-badge>
                        <a-badge count="5">
                            <a-button size="large" icon style="border-radius: 12px; font-weight: 600; box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);">
                                <BellOutlined /> Notifications
                            </a-button>
                        </a-badge>
                        <a-dropdown>
                            <a-button size="large" icon style="border-radius: 12px; font-weight: 600; box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);">
                                <SettingOutlined /> Settings
                            </a-button>
                            <template #overlay>
                                <a-menu style="border-radius: 8px; box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);">
                                    <a-menu-item key="profile" style="border-radius: 8px;">
                                        <UserOutlined /> Profile Settings
                                    </a-menu-item>
                                    <a-menu-item key="preferences" style="border-radius: 8px;">
                                        <SettingOutlined /> System Preferences
                                    </a-menu-item>
                                    <a-menu-item key="security" style="border-radius: 8px;">
                                        <SafetyOutlined /> Security
                                    </a-menu-item>
                                </a-menu>
                            </template>
                        </a-dropdown>
                    </a-space>
                </template>
            </a-page-header>
        </template>

        <div style="padding: 0 24px;">
            <!-- Statistics Cards -->
            <a-row :gutter="[24, 24]" style="margin-bottom: 36px;">
                <a-col :xs="24" :sm="12" :lg="6">
                    <a-card
                        hoverable
                        style="border-radius: 20px; box-shadow: 0 12px 32px rgba(0,0,0,0.15); transition: all 0.3s ease; background: linear-gradient(135deg, rgba(24, 144, 255, 0.05) 0%, rgba(24, 144, 255, 0.1) 100%); border: 1px solid rgba(24, 144, 255, 0.1);"
                    >
                        <div style="display: flex; align-items: center; justify-content: space-between;">
                            <div>
                                <div style="color: #666; font-size: 15px; margin-bottom: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Total Users</div>
                                <div style="font-size: 42px; font-weight: bold; color: #1890ff; line-height: 1;">{{ stats.users }}</div>
                                <div style="color: #52c41a; font-size: 14px; margin-top: 12px; font-weight: 600; display: flex; align-items: center;">
                                    <ArrowUpOutlined style="margin-right: 4px;" /> 12% from last month
                                </div>
                            </div>
                            <div style="width: 80px; height: 80px; border-radius: 50%; background: rgba(24, 144, 255, 0.1); display: flex; align-items: center; justify-content: center; box-shadow: 0 12px 32px rgba(24, 144, 255, 0.3);">
                                <UserOutlined style="font-size: 40px; color: #1890ff;" />
                            </div>
                        </div>
                    </a-card>
                </a-col>
                <a-col :xs="24" :sm="12" :lg="6">
                    <a-card
                        hoverable
                        style="border-radius: 20px; box-shadow: 0 12px 32px rgba(0,0,0,0.15); transition: all 0.3s ease; background: linear-gradient(135deg, rgba(82, 196, 26, 0.05) 0%, rgba(82, 196, 26, 0.1) 100%); border: 1px solid rgba(82, 196, 26, 0.1);"
                    >
                        <div style="display: flex; align-items: center; justify-content: space-between;">
                            <div>
                                <div style="color: #666; font-size: 15px; margin-bottom: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Active Sessions</div>
                                <div style="font-size: 42px; font-weight: bold; color: #52c41a; line-height: 1;">{{ stats.sessions }}</div>
                                <div style="color: #52c41a; font-size: 14px; margin-top: 12px; font-weight: 600; display: flex; align-items: center;">
                                    <ArrowUpOutlined style="margin-right: 4px;" /> 8% from last month
                                </div>
                            </div>
                            <div style="width: 80px; height: 80px; border-radius: 50%; background: rgba(82, 196, 26, 0.1); display: flex; align-items: center; justify-content: center; box-shadow: 0 12px 32px rgba(82, 196, 26, 0.3);">
                                <TeamOutlined style="font-size: 40px; color: #52c41a;" />
                            </div>
                        </div>
                    </a-card>
                </a-col>
                <a-col :xs="24" :sm="12" :lg="6">
                    <a-card
                        hoverable
                        style="border-radius: 20px; box-shadow: 0 12px 32px rgba(0,0,0,0.15); transition: all 0.3s ease; background: linear-gradient(135deg, rgba(114, 46, 209, 0.05) 0%, rgba(114, 46, 209, 0.1) 100%); border: 1px solid rgba(114, 46, 209, 0.1);"
                    >
                        <div style="display: flex; align-items: center; justify-content: space-between;">
                            <div>
                                <div style="color: #666; font-size: 15px; margin-bottom: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Total Teams</div>
                                <div style="font-size: 42px; font-weight: bold; color: #722ed1; line-height: 1;">{{ stats.teams }}</div>
                                <div style="color: #52c41a; font-size: 14px; margin-top: 12px; font-weight: 600; display: flex; align-items: center;">
                                    <ArrowUpOutlined style="margin-right: 4px;" /> 15% from last month
                                </div>
                            </div>
                            <div style="width: 80px; height: 80px; border-radius: 50%; background: rgba(114, 46, 209, 0.1); display: flex; align-items: center; justify-content: center; box-shadow: 0 12px 32px rgba(114, 46, 209, 0.3);">
                                <TeamOutlined style="font-size: 40px; color: #722ed1;" />
                            </div>
                        </div>
                    </a-card>
                </a-col>
                <a-col :xs="24" :sm="12" :lg="6">
                    <a-card
                        hoverable
                        style="border-radius: 20px; box-shadow: 0 12px 32px rgba(0,0,0,0.15); transition: all 0.3s ease; background: linear-gradient(135deg, rgba(250, 140, 22, 0.05) 0%, rgba(250, 140, 22, 0.1) 100%); border: 1px solid rgba(250, 140, 22, 0.1);"
                    >
                        <div style="display: flex; align-items: center; justify-content: space-between;">
                            <div>
                                <div style="color: #666; font-size: 15px; margin-bottom: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Growth Rate</div>
                                <div style="font-size: 42px; font-weight: bold; color: #fa8c16; line-height: 1;">11.28%</div>
                                <div style="color: #52c41a; font-size: 14px; margin-top: 12px; font-weight: 600; display: flex; align-items: center;">
                                    <ArrowUpOutlined style="margin-right: 4px;" /> 3% from last month
                                </div>
                            </div>
                            <div style="width: 80px; height: 80px; border-radius: 50%; background: rgba(250, 140, 22, 0.1); display: flex; align-items: center; justify-content: center; box-shadow: 0 12px 32px rgba(250, 140, 22, 0.3);">
                                <ArrowUpOutlined style="font-size: 40px; color: #fa8c16;" />
                            </div>
                        </div>
                    </a-card>
                </a-col>
            </a-row>

            <!-- Recent Activities -->
            <a-card
                title="Recent Activities"
                style="border-radius: 20px; box-shadow: 0 12px 32px rgba(0,0,0,0.15); margin-bottom: 32px; background: linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(255, 255, 255, 0.9) 100%); border: 1px solid rgba(0,0,0,0.05);"
                :bordered="false"
            >
                <template #extra>
                    <a-button type="link" size="small" style="font-weight: 600; color: #1890ff;">
                        View All
                    </a-button>
                </template>

                <a-list :data-source="activities" :loading="activities.length === 0">
                    <template #renderItem="{ item }">
                        <a-list-item style="border-bottom: 1px solid #f0f0f0; padding: 20px 0;">
                            <a-list-item-meta>
                                <template #avatar>
                                    <a-avatar :style="{ backgroundColor: item.color || '#1890ff', border: '3px solid #f0f0f0', boxShadow: '0 4px 12px rgba(0,0,0,0.1)' }" size="large">
                                        <component :is="item.icon || h(MessageOutlined)" />
                                    </a-avatar>
                                </template>
                                <template #title>
                                    <span style="font-weight: 700; font-size: 16px; color: #262626;">{{ item.title }}</span>
                                </template>
                                <template #description>
                                    <span style="color: #666; font-size: 15px; line-height: 1.5;">{{ item.description }}</span>
                                </template>
                            </a-list-item-meta>
                            <template #actions>
                                <span style="color: #999; font-size: 14px; font-weight: 600; padding: 4px 8px; background: rgba(0,0,0,0.02); border-radius: 4px;">{{ item.time }}</span>
                            </template>
                        </a-list-item>
                    </template>

                    <template #empty>
                        <div style="text-align: center; padding: 64px 0; color: #999;">
                            <ClockCircleOutlined style="font-size: 64px; margin-bottom: 24px; opacity: 0.2;" />
                            <p style="font-size: 18px; font-weight: 600; margin-bottom: 8px;">No recent activities</p>
                            <p style="font-size: 14px; opacity: 0.7;">Your activities will appear here once you start using the application</p>
                        </div>
                    </template>
                </a-list>
            </a-card>

            <!-- Quick Actions -->
            <a-row :gutter="[24, 24]">
                <a-col :xs="24" :sm="12" :lg="8">
                    <a-card
                        hoverable
                        style="border-radius: 20px; box-shadow: 0 12px 32px rgba(0,0,0,0.15); text-align: center; transition: all 0.3s ease; background: linear-gradient(135deg, rgba(24, 144, 255, 0.02) 0%, rgba(24, 144, 255, 0.08) 100%); border: 1px solid rgba(24, 144, 255, 0.1);"
                    >
                        <div style="display: flex; justify-content: center; margin-bottom: 24px;">
                            <div style="width: 80px; height: 80px; border-radius: 50%; background: rgba(24, 144, 255, 0.1); display: flex; align-items: center; justify-content: center; box-shadow: 0 12px 32px rgba(24, 144, 255, 0.3);">
                                <UserOutlined style="font-size: 40px; color: #1890ff;" />
                            </div>
                        </div>
                        <h3 style="color: #1890ff; margin-bottom: 16px; font-size: 20px; font-weight: 700;">Manage Users</h3>
                        <p style="color: #666; font-size: 16px; margin-bottom: 24px; line-height: 1.6;">
                            Add, edit, and manage user accounts with advanced permissions
                        </p>
                        <a-button type="primary" size="large" style="border-radius: 12px; font-weight: 600; box-shadow: 0 4px 16px rgba(24, 144, 255, 0.3);">
                            Go to Users
                        </a-button>
                    </a-card>
                </a-col>
                <a-col :xs="24" :sm="12" :lg="8">
                    <a-card
                        hoverable
                        style="border-radius: 20px; box-shadow: 0 12px 32px rgba(0,0,0,0.15); text-align: center; transition: all 0.3s ease; background: linear-gradient(135deg, rgba(82, 196, 26, 0.02) 0%, rgba(82, 196, 26, 0.08) 100%); border: 1px solid rgba(82, 196, 26, 0.1);"
                    >
                        <div style="display: flex; justify-content: center; margin-bottom: 24px;">
                            <div style="width: 80px; height: 80px; border-radius: 50%; background: rgba(82, 196, 26, 0.1); display: flex; align-items: center; justify-content: center; box-shadow: 0 12px 32px rgba(82, 196, 26, 0.3);">
                                <TeamOutlined style="font-size: 40px; color: #52c41a;" />
                            </div>
                        </div>
                        <h3 style="color: #52c41a; margin-bottom: 16px; font-size: 20px; font-weight: 700;">Team Settings</h3>
                        <p style="color: #666; font-size: 16px; margin-bottom: 24px; line-height: 1.6;">
                            Configure team preferences and permissions with role-based access
                        </p>
                        <a-button type="primary" size="large" style="border-radius: 12px; font-weight: 600; box-shadow: 0 4px 16px rgba(82, 196, 26, 0.3);">
                            Manage Teams
                        </a-button>
                    </a-card>
                </a-col>
                <a-col :xs="24" :sm="12" :lg="8">
                    <a-card
                        hoverable
                        style="border-radius: 20px; box-shadow: 0 12px 32px rgba(0,0,0,0.15); text-align: center; transition: all 0.3s ease; background: linear-gradient(135deg, rgba(114, 46, 209, 0.02) 0%, rgba(114, 46, 209, 0.08) 100%); border: 1px solid rgba(114, 46, 209, 0.1);"
                    >
                        <div style="display: flex; justify-content: center; margin-bottom: 24px;">
                            <div style="width: 80px; height: 80px; border-radius: 50%; background: rgba(114, 46, 209, 0.1); display: flex; align-items: center; justify-content: center; box-shadow: 0 12px 32px rgba(114, 46, 209, 0.3);">
                                <SettingOutlined style="font-size: 40px; color: #722ed1;" />
                            </div>
                        </div>
                        <h3 style="color: #722ed1; margin-bottom: 16px; font-size: 20px; font-weight: 700;">System Settings</h3>
                        <p style="color: #666; font-size: 16px; margin-bottom: 24px; line-height: 1.6;">
                            Configure application settings and preferences with advanced options
                        </p>
                        <a-button type="primary" size="large" style="border-radius: 12px; font-weight: 600; box-shadow: 0 4px 16px rgba(114, 46, 209, 0.3);">
                            Configure
                        </a-button>
                    </a-card>
                </a-col>
            </a-row>
        </div>
    </AppLayout>
</template>
