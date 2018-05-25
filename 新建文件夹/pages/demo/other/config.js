
export default {

  tabTitles: [
    {
      title: '业务咨询',
      icon: 'bmlocal://assets/咨询.png',
      activeIcon: 'bmlocal://assets/咨询_G.png',
    },
    {
      title: '业务攻略',
      icon: 'bmlocal://assets/攻略.png',
      activeIcon: 'bmlocal://assets/攻略_G.png'
    },
    {
      title: '办事指南',
      icon: 'bmlocal://assets/指南针.png',
      activeIcon: 'bmlocal://assets/指南针_G.png'
    },
    {
      title: '留言区',
      icon: 'bmlocal://assets/留言.png',
      activeIcon: 'bmlocal://assets/留言_G.png'
    },
    {
      title: '我的',
      icon: 'bmlocal://assets/人像.png',
      activeIcon: 'bmlocal://assets/人像_G.png'
    }
  ],
  tabStyles: {
    bgColor: '#FFFFFF',
    titleColor: '#666666',
    activeTitleColor: '#3D3D3D',
    activeBgColor: '#FFFFFF',
    isActiveTitleBold: true,
    iconWidth: 60,
    iconHeight: 60,
    width: 160,
    height: 120,
    fontSize: 24,
    hasActiveBottom: true,
    activeBottomColor: '#FFC900',
    activeBottomHeight: 6,
    activeBottomWidth: 120,
    textPaddingLeft: 10,
    textPaddingRight: 10
  },
  // 使用 iconfont 模式的tab title配置
  tabIconFontTitles: [
    {
      title: '业务咨询',
      codePoint: '\ue623'
    },
    {
      title: '业务攻略',
      codePoint: '\ue608'
    },
    {
      title: '办事指南',
      codePoint: '\ue752',
      badge: 5
    },
    {
      title: '留言区',
      codePoint: '\ue601',
      dot: true
    },
    {
      title: '我的',
      codePoint: '\ue601',
      dot: true
    }
  ],
  tabIconFontStyles: {
    bgColor: '#FFFFFF',
    titleColor: '#666666',
    activeTitleColor: '#3D3D3D',
    activeBgColor: '#FFFFFF',
    isActiveTitleBold: true,
    width: 160,
    height: 120,
    fontSize: 24,
    textPaddingLeft: 10,
    textPaddingRight: 10,
    iconFontSize: 50,
    iconFontColor: '#333333',
    iconFontMarginBottom: 8,
    activeIconFontColor: 'red',
    iconFontUrl: '//at.alicdn.com/t/font_501019_mauqv15evc1pp66r.ttf'
  }
}