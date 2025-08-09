<script setup>
import { nextTick, ref } from 'vue';
import { Head, useForm } from '@inertiajs/vue3';
import { h } from 'vue';
import { LockOutlined } from '@ant-design/icons-vue';
import { message } from 'ant-design-vue';

const recovery = ref(false);

const form = useForm({
    code: '',
    recovery_code: '',
});

const recoveryCodeInput = ref(null);
const codeInput = ref(null);

const toggleRecovery = async () => {
    recovery.value ^= true;

    await nextTick();

    if (recovery.value) {
        recoveryCodeInput.value.focus();
        form.code = '';
    } else {
        codeInput.value.focus();
        form.recovery_code = '';
    }
};

const submit = () => {
    form.post(route('two-factor.login'), {
        onError: () => {
            message.error('Authentication failed. Please check your code.');
        }
    });
};
</script>

<template>
    <Head title="Two Factor Authentication" />

    <div style="min-height: 100vh; display: flex; align-items: center; justify-content: center; background: #f0f2f5">
        <a-card style="width: 400px">
            <div style="text-align: center; margin-bottom: 24px">
                <LockOutlined style="font-size: 48px; color: #1890ff; margin-bottom: 16px" />
                <h2>Two Factor Authentication</h2>
                <p style="color: #666">
                    {{ recovery ? 'Please confirm access to your account by entering one of your emergency recovery codes.' : 'Please confirm access to your account by entering the authentication code provided by your authenticator application.' }}
                </p>
            </div>

            <a-form
                :model="form"
                @finish="submit"
                layout="vertical"
            >
                <a-form-item
                    v-if="!recovery"
                    label="Code"
                    name="code"
                    :rules="[{ required: true, message: 'Please input your authentication code!' }]"
                >
                    <a-input
                        ref="codeInput"
                        v-model:value="form.code"
                        size="large"
                        placeholder="Authentication code"
                        autocomplete="one-time-code"
                    />
                </a-form-item>

                <a-form-item
                    v-else
                    label="Recovery Code"
                    name="recovery_code"
                    :rules="[{ required: true, message: 'Please input your recovery code!' }]"
                >
                    <a-input
                        ref="recoveryCodeInput"
                        v-model:value="form.recovery_code"
                        size="large"
                        placeholder="Recovery code"
                        autocomplete="one-time-code"
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
                        Log in
                    </a-button>
                </a-form-item>

                <div style="text-align: center">
                    <button
                        type="button"
                        @click="toggleRecovery"
                        style="border: none; background: none; color: #1890ff; cursor: pointer"
                    >
                        {{ recovery ? 'Use an authentication code' : 'Use a recovery code' }}
                    </button>
                </div>
            </a-form>
        </a-card>
    </div>
</template>
