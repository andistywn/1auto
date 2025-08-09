<script setup>
import { computed } from 'vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import { h } from 'vue';
import { MailOutlined } from '@ant-design/icons-vue';
import { message } from 'ant-design-vue';

const props = defineProps({
    status: String,
});

const form = useForm({});

const submit = () => {
    form.post(route('verification.send'), {
        onError: () => {
            message.error('Failed to send verification email. Please try again.');
        }
    });
};

const verificationLinkSent = computed(() => props.status === 'verification-link-sent');
</script>

<template>
    <Head title="Verify Your Email" />

    <div style="min-height: 100vh; display: flex; align-items: center; justify-content: center; background: #f0f2f5">
        <a-card style="width: 400px">
            <div style="text-align: center">
                <MailOutlined style="font-size: 48px; color: #1890ff; margin-bottom: 16px" />
                <h2 style="margin-bottom: 16px">Verify Your Email</h2>
                <p style="margin-bottom: 24px; color: #666">
                    Thanks for signing up! Before getting started, could you verify your email address by clicking on the link we just emailed to you?
                </p>
            </div>

            <div v-if="verificationLinkSent" style="margin-bottom: 16px">
                <a-alert
                    message="A new verification link has been sent to your email address."
                    type="success"
                    show-icon
                />
            </div>

            <a-form @finish="submit" layout="vertical">
                <a-form-item>
                    <a-button
                        type="primary"
                        html-type="submit"
                        size="large"
                        block
                        :loading="form.processing"
                    >
                        Resend Verification Email
                    </a-button>
                </a-form-item>
            </a-form>

            <div style="text-align: center; margin-top: 16px">
                <Link :href="route('logout')" method="post" as="button" style="border: none; background: none; color: #1890ff; cursor: pointer">
                    Log Out
                </Link>
            </div>
        </a-card>
    </div>
</template>
