<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
import { h } from 'vue';
import { MailOutlined, LockOutlined } from '@ant-design/icons-vue';
import { message } from 'ant-design-vue';

defineProps({
    status: String,
});

const form = useForm({
    email: '',
});

const submit = () => {
    form.post(route('password.email'), {
        onError: () => {
            message.error('Failed to send password reset email. Please try again.');
        }
    });
};
</script>

<template>
    <Head title="Forgot Password" />

    <div style="min-height: 100vh; display: flex; align-items: center; justify-content: center; background: #f0f2f5">
        <a-card style="width: 400px">
            <h2 style="text-align: center; margin-bottom: 24px">Forgot Password</h2>

            <div v-if="status" style="margin-bottom: 16px">
                <a-alert :message="status" type="success" show-icon />
            </div>

            <a-form
                :model="form"
                @finish="submit"
                layout="vertical"
            >
                <a-form-item
                    label="Email"
                    name="email"
                    :rules="[{ required: true, type: 'email', message: 'Please input a valid email!' }]"
                >
                    <a-input
                        v-model:value="form.email"
                        type="email"
                        size="large"
                        :prefix="h(MailOutlined)"
                        placeholder="Email"
                    />
                </a-form-item>

                <a-form-item>
                    <a-button
                        type="primary"
                        html-type="submit"
                        size="large"
                        block
                        :loading="form.processing"
                    >
                        Send Password Reset Link
                    </a-button>
                </a-form-item>
            </a-form>

            <div style="text-align: center; margin-top: 16px">
                <Link :href="route('login')">Back to Login</Link>
            </div>
        </a-card>
    </div>
</template>
