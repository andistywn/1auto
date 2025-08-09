<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
import { h } from 'vue';
import { UserOutlined, MailOutlined, LockOutlined } from '@ant-design/icons-vue';
import { message } from 'ant-design-vue';

const form = useForm({
    name: '',
    email: '',
    password: '',
    password_confirmation: '',
    terms: false,
});

const submit = () => {
    form.post(route('register'), {
        onFinish: () => form.reset('password', 'password_confirmation'),
        onError: () => {
            message.error('Registration failed. Please check your information.');
        }
    });
};
</script>

<template>
    <Head title="Register" />

    <div style="min-height: 100vh; display: flex; align-items: center; justify-content: center; background: #f0f2f5">
        <a-card style="width: 400px">
            <h2 style="text-align: center; margin-bottom: 24px">Register</h2>

            <a-form
                :model="form"
                @finish="submit"
                layout="vertical"
            >
                <a-form-item
                    label="Name"
                    name="name"
                    :rules="[{ required: true, message: 'Please input your name!' }]"
                >
                    <a-input
                        v-model:value="form.name"
                        size="large"
                        :prefix="h(UserOutlined)"
                        placeholder="Name"
                    />
                </a-form-item>

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

                <a-form-item v-if="$page.props.jetstream.hasTermsAndPrivacyPolicyFeature">
                    <a-checkbox v-model:checked="form.terms">
                        I agree to the terms and conditions
                    </a-checkbox>
                </a-form-item>

                <a-form-item>
                    <a-button
                        type="primary"
                        html-type="submit"
                        size="large"
                        block
                        :loading="form.processing"
                    >
                        Register
                    </a-button>
                </a-form-item>

                <div style="text-align: center">
                    <span style="color: #666">Already have an account?</span>
                    <Link :href="route('login')" style="color: #1890ff; margin-left: 8px; font-weight: 500">
                        Login
                    </Link>
                </div>
            </a-form>
        </a-card>
    </div>
</template>
