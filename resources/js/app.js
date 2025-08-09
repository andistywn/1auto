import '../css/app.css';

import { createApp, h } from 'vue';
import { createInertiaApp } from '@inertiajs/vue3';
import { resolvePageComponent } from 'laravel-vite-plugin/inertia-helpers';
import { ZiggyVue } from '../../vendor/tightenco/ziggy';
import { createPinia } from 'pinia';
import Antd from 'ant-design-vue';
import * as Icons from '@ant-design/icons-vue';

// Import Ant Design styles
import 'ant-design-vue/dist/reset.css';

const appName = import.meta.env.VITE_APP_NAME || 'Laravel';
const pinia = createPinia();

createInertiaApp({
    title: (title) => `${title} - ${appName}`,
    resolve: (name) => resolvePageComponent(`./Pages/${name}.vue`, import.meta.glob('./Pages/**/*.vue')),
    setup({ el, App, props, plugin }) {
        const app = createApp({ render: () => h(App, props) })
            .use(plugin)
            .use(ZiggyVue)  // CRITICAL: This enables Laravel routing
            .use(pinia)
            .use(Antd);

        // Register Ant Design icons
        Object.keys(Icons).forEach((key) => {
            const IconComponent = Icons[key];
            if (IconComponent) {
                app.component(key, IconComponent);
            }
        });

        return app.mount(el);
    },
    progress: {
        color: '#4B5563',
    },
});
