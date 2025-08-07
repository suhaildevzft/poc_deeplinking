# 🚀 Deep Link POC - Complete Implementation

This project demonstrates a complete deep linking solution that intelligently detects if a mobile app is installed and provides appropriate fallback behavior.

## 📁 Project Structure

```
poc_deeplinking/
├── index.html          # Main deep link handler page
├── demo.html           # Demo page with test links
├── README.md          # This file
└── deeplink_poc/      # Flutter mobile app
    ├── lib/main.dart  # App with deep link handling
    ├── android/       # Android configuration
    ├── ios/          # iOS configuration
    └── ...
```

## 🎯 Features

### ✨ Smart App Detection
- **Multiple Detection Methods**: Uses visibility change, page blur, timeout, and custom URL schemes
- **Platform-Specific Logic**: Different approaches for iOS, Android, and web
- **Fallback Handling**: Graceful degradation when app is not installed

### 📱 Mobile App Integration
- **Custom URL Schemes**: `deeplinkpoc://example.com/dashboard`
- **Universal Links**: `https://suhaildevzft.github.io/poc_deeplinking/app/`
- **Parameter Support**: Pass `userId`, `token`, and custom paths
- **Cross-Platform**: Works on both iOS and Android

### 🌐 Web Integration
- **Meta Tags**: Proper Open Graph and App Links meta tags
- **Smart Banners**: iOS Smart App Banner support
- **SEO Friendly**: Proper meta tags for social sharing

## 🚀 Quick Start

### 1. Host the Web Page
Upload `index.html` and `demo.html` to your web server:
```bash
# Example using GitHub Pages
git add .
git commit -m "Add deep linking pages"
git push origin main
```

### 2. Update Configuration
Edit the configuration in `index.html`:

```javascript
const CONFIG = {
    deepLinkScheme: 'deeplinkpoc://example.com/dashboard',
    iosAppStoreUrl: 'https://apps.apple.com/app/6739358459',
    androidPlayStoreUrl: 'https://play.google.com/store/apps/details?id=app.slavic.customer.uat',
    webFallbackUrl: 'https://ww2staging.slavic401k.com/participant-portal-uat/dashboard',
    appDetectionTimeout: 3000
};
```

### 3. Update Meta Tags
Replace placeholder values in the HTML head:

```html
<!-- iOS Meta Tags -->
<meta name="apple-itunes-app" content="app-id=YOUR_ACTUAL_IOS_APP_ID">
<meta property="al:ios:app_store_id" content="YOUR_ACTUAL_IOS_APP_ID">

<!-- Android Meta Tags -->
<meta property="al:android:package" content="com.your.actual.package">
```

## 📱 Mobile App Setup

### Android Configuration

#### 1. Update AndroidManifest.xml
```xml
<activity android:name=".MainActivity" android:exported="true">
    <!-- Custom Scheme Intent Filter -->
    <intent-filter android:autoVerify="true">
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="deeplinkpoc" />
    </intent-filter>
    
    <!-- Universal Link Intent Filter -->
    <intent-filter android:autoVerify="true">
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="https"
              android:host="suhaildevzft.github.io"
              android:pathPrefix="/poc_deeplinking/app" />
    </intent-filter>
</activity>
```

#### 2. Add Dependencies (pubspec.yaml)
```yaml
dependencies:
  app_links: ^6.3.5
  url_launcher: ^6.2.4
  device_info_plus: ^10.1.0
```

### iOS Configuration

#### 1. Update Info.plist
```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>deeplinkpoc.deeplink</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>deeplinkpoc</string>
        </array>
    </dict>
</array>

<!-- Associated Domains for Universal Links -->
<key>com.apple.developer.associated-domains</key>
<array>
    <string>applinks:suhaildevzft.github.io</string>
</array>
```

#### 2. Add Associated Domains
In Xcode:
1. Select your target
2. Go to "Signing & Capabilities"
3. Add "Associated Domains" capability
4. Add domain: `applinks:suhaildevzft.github.io`

## 🔗 Usage Examples

### Basic Deep Link
```html
<a href="https://suhaildevzft.github.io/poc_deeplinking/index.html">Open App</a>
```

### Deep Link with Parameters
```html
<a href="https://suhaildevzft.github.io/poc_deeplinking/index.html?path=dashboard&userId=123&token=abc">
    Open Dashboard
</a>
```

### Direct Custom Scheme (Limited Browser Support)
```html
<a href="deeplinkpoc://example.com/dashboard?userId=123">Open App Direct</a>
```

## 🧪 Testing

### Test Scenarios
1. **App Installed + iOS Safari**: Should open app immediately
2. **App Installed + Android Chrome**: Should open app immediately
3. **App Not Installed + iOS**: Should redirect to App Store
4. **App Not Installed + Android**: Should redirect to Play Store
5. **Desktop Browser**: Should redirect to web fallback

### Test URLs
- Basic: `https://suhaildevzft.github.io/poc_deeplinking/index.html`
- With params: `https://suhaildevzft.github.io/poc_deeplinking/index.html?path=profile&userId=456`
- Demo page: `https://suhaildevzft.github.io/poc_deeplinking/demo.html`
- Test console: `https://suhaildevzft.github.io/poc_deeplinking/test-console.html`
- Universal link: `https://suhaildevzft.github.io/poc_deeplinking/app/dashboard`

### Debug Information
The page shows debug information including:
- User Agent
- Platform detection
- Generated deep link URL
- Detection method results

## 🎨 Customization

### Styling
Modify the CSS in `index.html` to match your brand:

```css
.container {
    background: white;
    border-radius: 16px;
    /* Add your brand colors */
}

.btn-primary {
    background: linear-gradient(135deg, #your-color1, #your-color2);
}
```

### Messages
Update user-facing messages:

```javascript
statusEl.innerHTML = '✅ Your custom success message!';
```

### Timeout
Adjust detection timeout:

```javascript
const CONFIG = {
    appDetectionTimeout: 5000 // 5 seconds instead of 3
};
```

## 🔧 Advanced Features

### URL Parameter Handling
The system automatically passes URL parameters to the app:

```
Web URL: https://suhaildevzft.github.io/poc_deeplinking/index.html?userId=123&action=view
App URL: deeplinkpoc://example.com/dashboard?userId=123&action=view
```

### Multiple App Versions
Support different app versions:

```javascript
// In index.html
const appVersion = urlParams.get('v') || 'prod';
const deepLinkScheme = appVersion === 'dev' 
    ? 'deeplinkpoc-dev://example.com/' 
    : 'deeplinkpoc://example.com/';
```

### Analytics Integration
Add tracking:

```javascript
// Track deep link attempts
gtag('event', 'deep_link_attempt', {
    'custom_parameter': 'value'
});

// Track successful app opens
document.addEventListener('visibilitychange', () => {
    if (document.hidden) {
        gtag('event', 'app_opened_successfully');
    }
});
```

## 🐛 Troubleshooting

### Common Issues

#### 1. App Doesn't Open on iOS
- Verify URL scheme in Info.plist
- Check Associated Domains capability
- Ensure apple-app-site-association file is served

#### 2. App Doesn't Open on Android
- Verify intent filters in AndroidManifest.xml
- Check `android:autoVerify="true"` is set
- Test with `adb shell am start -W -a android.intent.action.VIEW -d "deeplinkpoc://test"`

#### 3. Detection Not Working
- Ensure page is served over HTTPS
- Test on actual devices, not simulators
- Check browser console for errors

### Debug Commands

#### Android
```bash
# Test custom scheme
adb shell am start -W -a android.intent.action.VIEW -d "deeplinkpoc://example.com/dashboard"

# Test universal link
adb shell am start -W -a android.intent.action.VIEW -d "https://suhaildevzft.github.io/poc_deeplinking/app/dashboard"

# Check intent filters
adb shell dumpsys package app.slavic.customer.uat
```

#### iOS
```bash
# Test custom scheme
xcrun simctl openurl booted "deeplinkpoc://example.com/dashboard"

# Check associated domains
xcrun simctl openurl booted "https://suhaildevzft.github.io/poc_deeplinking/app/dashboard"
```

## 🌟 Best Practices

1. **Always Provide Fallbacks**: Never leave users stranded
2. **Test on Real Devices**: Simulators may not behave like real devices
3. **Use HTTPS**: Required for universal links and many features
4. **Monitor Analytics**: Track success rates and user behavior
5. **Handle Edge Cases**: Slow networks, app updates, etc.
6. **User Experience**: Clear messaging about what's happening

## 📊 Browser Compatibility

| Browser | Custom Schemes | App Detection | Smart Banners |
|---------|---------------|---------------|---------------|
| iOS Safari | ✅ | ✅ | ✅ |
| iOS Chrome | ✅ | ✅ | ❌ |
| Android Chrome | ✅ | ✅ | ❌ |
| Android Firefox | ✅ | ⚠️ Limited | ❌ |
| Desktop | ❌ | ❌ | ❌ |

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly on multiple devices
5. Submit a pull request

## 📞 Support

If you encounter issues:
1. Check the troubleshooting section
2. Review browser console logs
3. Test on multiple devices/browsers
4. Open an issue with detailed information

---

Built with ❤️ for seamless mobile app integration
