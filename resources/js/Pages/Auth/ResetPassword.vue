<script setup>
import { Head, useForm } from '@inertiajs/vue3';
import { h } from 'vue';
import { MailOutlined, LockOutlined } from '@ant-design/icons-vue';
import { message } from 'ant-design-vue';

const props = defineProps({
    email: String,
    token: String,
});

const form = useForm({
    token: props.token,
    email: props.email,
    password: '',
    password_confirmation: '',
});

const submit = () => {
    form.post(route('password.update'), {
        onFinish: () => form.reset('password', 'password_confirmation'),
        onError: () => {
            message.error('Failed to reset password. Please try again.');
        }
    });
};
</script>

<template>
    <Head title="Reset Password" />

    <div style="min-height: 100vh; display: flex; align-items: center; justify-content: center; background: #f0f2f5">
        <a-card style="width: 400px">
            <h2 style="text-align: center; margin-bottom: 24px">Reset Password</h2>

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

                <a-form-item
                    label="Password"
                    name="password"
                    :rules="[{ required: true, min: 8, message: 'Password must be at least 8 characters!' }]"
                >
                    <a-input-password
                        v-model:value="form.password"
                        size="large"
                        :prefix="h(LockOutlined)"
                        placeholder="Password"
                    />
                </a-form-item>

                <a-form-item
                    label="Confirm Password"
                    name="password_confirmation"
                    :rules="[{ required: true, message: 'Please confirm your password!' }]"
                >
                    <a-input-password
                        v-model:value="form.password_confirmation"
                        size="large"
                        :prefix="h(LockOutlined)"
                        placeholder="Confirm Password"
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
                        Reset Password
                    </a-button>
                </a-form-item>
            </a-form>
        </a-card>
    </div>
</template>
