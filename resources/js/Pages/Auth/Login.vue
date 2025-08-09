<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
import { h } from 'vue';
import { MailOutlined, LockOutlined } from '@ant-design/icons-vue';
import { message } from 'ant-design-vue';

defineProps({
    canResetPassword: Boolean,
    status: String,
});

const form = useForm({
    email: '',
    password: '',
    remember: false,
});

const submit = () => {
    form.transform(data => ({
        ...data,
        remember: form.remember ? 'on' : '',
    })).post(route('login'), {
        onFinish: () => form.reset('password'),
        onError: () => {
            message.error('Login failed. Please check your credentials.');
        }
    });
};
</script>

<template>
    <Head title="Log in" />

    <div style="min-height: 100vh; display: flex; align-items: center; justify-content: center; background: #f0f2f5">
        <a-card style="width: 400px">
            <h2 style="text-align: center; margin-bottom: 24px">Login</h2>

            <a-form
                :model="form"
                @finish="submit"
                layout="vertical"
            >
                <a-form-item
                    label="Email"
                    name="email"
                    :rules="[{ required: true, message: 'Please input your email!' }]"
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
                    :rules="[{ required: true, message: 'Please input your password!' }]"
                >
                    <a-input-password
                        v-model:value="form.password"
                        size="large"
                        :prefix="h(LockOutlined)"
                        placeholder="Password"
                    />
                </a-form-item>

                <a-form-item>
                    <a-checkbox v-model:checked="form.remember">Remember me</a-checkbox>
                </a-form-item>

                <a-form-item>
                    <a-button
                        type="primary"
                        html-type="submit"
                        size="large"
                        block
                        :loading="form.processing"
                    >
                        Log in
                    </a-button>
                </a-form-item>

                <div style="text-align: center">
                    <Link v-if="canResetPassword" :href="route('password.request')">Forgot your password?</Link>
                </div>
            </a-form>

            <div style="text-align: center; margin-top: 16px">
                <span style="color: #666">Don't have an account?</span>
                <Link :href="route('register')" style="color: #1890ff; margin-left: 8px; font-weight: 500">
                    Register
                </Link>
            </div>
        </a-card>
    </div>
</template>
