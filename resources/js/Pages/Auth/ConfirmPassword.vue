<script setup>
import { ref } from 'vue';
import { Head, useForm } from '@inertiajs/vue3';
import { h } from 'vue';
import { LockOutlined } from '@ant-design/icons-vue';
import { message } from 'ant-design-vue';

const form = useForm({
    password: '',
});

const passwordInput = ref(null);

const submit = () => {
    form.post(route('password.confirm'), {
        onFinish: () => {
            form.reset();
            message.success('Password confirmed successfully!');
        },
        onError: () => {
            message.error('Password confirmation failed. Please try again.');
        }
    });
};
</script>

<template>
    <Head title="Confirm Password" />

    <div style="min-height: 100vh; display: flex; align-items: center; justify-content: center; background: #f0f2f5">
        <a-card style="width: 400px">
            <div style="text-align: center; margin-bottom: 24px">
                <LockOutlined style="font-size: 48px; color: #1890ff; margin-bottom: 16px" />
                <h2>Confirm Password</h2>
                <p style="color: #666">
                    This is a secure area of the application. Please confirm your password before continuing.
                </p>
            </div>

            <a-form
                :model="form"
                @finish="submit"
                layout="vertical"
            >
                <a-form-item
                    label="Password"
                    name="password"
                    :rules="[{ required: true, message: 'Please input your password!' }]"
                >
                    <a-input-password
                        ref="passwordInput"
                        v-model:value="form.password"
                        size="large"
                        :prefix="h(LockOutlined)"
                        placeholder="Password"
                        autocomplete="current-password"
                        autofocus
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
                        Confirm
                    </a-button>
                </a-form-item>
            </a-form>
        </a-card>
    </div>
</template>
