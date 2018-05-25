
<template>
    <tabs :tabItems="tabItems" @tabsOnClick="tabsOnClick"></tabs>
</template>
<script>
import 'Config'
import tabs from 'Components/tabs/bar'
const GZT ='bmlocal://assets/咨询.png'
const SELECTED_GZT = 'bmlocal://assets/咨询_G.png'
const WDSW ='bmlocal://assets/攻略.png'
const SELECTED_WDSW = 'bmlocal://assets/攻略_G.png'
const TXL ='bmlocal://assets/指南针.png'
const SELECTED_TXL = 'bmlocal://assets/指南针_G.png'
const GRZX ='bmlocal://assets/留言.png'
const SELECTED_GRZX = 'bmlocal://assets/留言_G.png'
const ME ='bmlocal://assets/人像.png'
const SELECTED_ME = 'bmlocal://assets/人像_G.png'
export default {
    globalEvent: {
        appActive() {
            console.log('active')
        },
        appDeactive() {
            console.log('deactive')
        }
    },
    data() {
        return {
            tabItems: [{
                index: 0,
                title: '业务咨询',
                titleColor: '#f39800',
                icon: '',
                image: GZT,
                selectedImage: SELECTED_GZT,
                src: `${weex.config.eros.jsServer}/dist/js/pages/login.js`,
                visibility: 'visible',
            },
            {
                index: 1,
                title: '业务攻略',
                titleColor: '#f39800',
                icon: '',
                image: WDSW,
                selectedImage: SELECTED_WDSW,
                src: 'http://localhost:8889/dist/js/pages/demo/other/waterfall.js',
                visibility: 'hidden',
            },
            {
                index: 2,
                title: '办事指南',
                titleColor: '#f39800',
                icon: '',
               image: TXL,
                selectedImage: SELECTED_TXL,
                src: `${weex.config.eros.jsServer}/dist/js/pages/demo/other/waterfall.js`,
                visibility: 'hidden',
            },
            {
                index: 3,
                title: '留言区',
                titleColor: '#f39800',
                icon: '',
                image: GRZX,
                selectedImage: SELECTED_GRZX,
                src: `${weex.config.env.jsServer}/dist/js/pages/demo/other/waterfall.js`,
                visibility: 'hidden',
            },
            {
                index: 4,
                title: '我的',
                titleColor: '#f39800',
                icon: '',
                image: ME,
                selectedImage: SELECTED_ME,
                src: `${weex.config.env.jsServer}/dist/js/pages/demo/other/waterfall.js`,
                visibility: 'hidden',
            }],
        }
    },
    components: {
        tabs
    },
    methods: {
        tabsOnClick(e) {
            console.log('tabsOnClick', e.index)
        }
    }
}
</script>
