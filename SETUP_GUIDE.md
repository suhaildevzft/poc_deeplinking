# Deep Linking Setup Guide - Flipkart-style Implementation

This guide explains how to set up seamless deep linking (like Flipkart) where users are automatically redirected to your app if installed, or to the app store if not.

## 🎯 Current Implementation Status

✅ **Web Page**: Hosted at `https://suhaildevzft.github.io/poc_deeplinking/`  
✅ **Flutter App**: Bundle ID `app.slavic.customer.uat`  
✅ **Custom Scheme**: `deeplinkpoc://`  
✅ **Universal Links**: Configured for iOS and Android  
✅ **Smart App Banners**: Added for iOS  

## 📱 How It Works

1. **User visits**: `https://suhaildevzft.github.io/poc_deeplinking/`
2. **Platform detection**: JavaScript detects iOS/Android/Desktop
3. **Immediate redirect**: 
   - **iOS**: Tries custom scheme → Universal Link → App Store
   - **Android**: Tries Intent → Custom scheme → Play Store  
   - **Desktop**: Redirects to web dashboard

## 🔧 Setup Requirements

### iOS App Store Setup

You need to configure **Associated Domains** in your App Store Connect account:

1. **Log into App Store Connect**
2. **Go to your app** → App Information
3. **Add Associated Domains**:
   ```
   applinks:suhaildevzft.github.io
   ```

4. **In Xcode**, ensure your app has the **Associated Domains capability**:
   ```
   Associated Domains: applinks:suhaildevzft.github.io
   ```

### Android Play Store Setup

For Android App Links to work properly:

1. **Get your app's SHA256 fingerprint**:
   ```bash
   # For debug builds
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

   # For release builds  
   keytool -list -v -keystore /path/to/your/release.keystore -alias your-alias
   ```

2. **Update `assetlinks.json`** with your production SHA256:
   ```json
   [{
     "relation": ["delegate_permission/common.handle_all_urls"],
     "target": {
       "namespace": "android_app", 
       "package_name": "app.slavic.customer.uat",
       "sha256_cert_fingerprints": ["YOUR_PRODUCTION_SHA256_HERE"]
     }
   }]
   ```

3. **Upload to Play Store** with the same signing key

## 📂 File Structure

```
poc_deeplinking/
├── index.html                          # Main landing page
├── app/dashboard/index.html             # Direct app redirect page
├── .well-known/
│   ├── apple-app-site-association      # iOS Universal Links
│   └── assetlinks.json                 # Android App Links
└── deeplink_poc/                       # Flutter app
    ├── android/app/src/main/AndroidManifest.xml
    ├── ios/Runner/Info.plist
    └── lib/main.dart
```

## 🌐 URLs and Deep Links

### Web URLs
- **Landing page**: `https://suhaildevzft.github.io/poc_deeplinking/`
- **Direct app redirect**: `https://suhaildevzft.github.io/poc_deeplinking/app/dashboard`

### Deep Link URLs  
- **Custom scheme**: `deeplinkpoc://example.com/dashboard?param=value`
- **Universal Link**: `https://suhaildevzft.github.io/poc_deeplinking/app/dashboard?param=value`

### Store URLs
- **iOS App Store**: `https://apps.apple.com/app/6739358459`
- **Android Play Store**: `https://play.google.com/store/apps/details?id=app.slavic.customer.uat`

## 🧪 Testing

### Test on Different Platforms:

1. **iOS (with app installed)**:
   - Open: `https://suhaildevzft.github.io/poc_deeplinking/`
   - Should immediately open your app

2. **iOS (without app)**:
   - Should show Smart App Banner
   - After delay, redirect to App Store

3. **Android (with app installed)**:
   - Should open app via Intent or custom scheme

4. **Android (without app)**:
   - Should redirect to Play Store

5. **Desktop**:
   - Should redirect to web dashboard

### Manual Testing Links:

Add these to your website for testing:
```html
<a href="deeplinkpoc://example.com/dashboard?userId=123">Test Custom Scheme</a>
<a href="https://suhaildevzft.github.io/poc_deeplinking/app/dashboard?userId=123">Test Universal Link</a>
```

## 🔍 Debugging

### Check if Universal Links work:

1. **iOS**: 
   ```bash
   # Verify apple-app-site-association
   curl https://suhaildevzft.github.io/.well-known/apple-app-site-association
   ```

2. **Android**:
   ```bash
   # Verify assetlinks.json
   curl https://suhaildevzft.github.io/.well-known/assetlinks.json
   ```

3. **Test with adb** (Android):
   ```bash
   adb shell am start \
     -W -a android.intent.action.VIEW \
     -d "https://suhaildevzft.github.io/poc_deeplinking/app/dashboard" \
     app.slavic.customer.uat
   ```

### Common Issues:

1. **iOS Universal Links not working**:
   - Check Associated Domains in App Store Connect
   - Verify Team ID in apple-app-site-association
   - Make sure HTTPS is working

2. **Android App Links not working**:  
   - Verify SHA256 fingerprint matches production build
   - Check intent filters in AndroidManifest.xml
   - Ensure assetlinks.json is accessible

3. **Custom schemes not working**:
   - Check URL scheme registration in Info.plist (iOS)
   - Check intent filters in AndroidManifest.xml (Android)

## 🚀 Deployment Checklist

- [ ] Upload app to stores with proper configuration
- [ ] Configure Associated Domains in App Store Connect  
- [ ] Update assetlinks.json with production SHA256
- [ ] Test all deep link scenarios
- [ ] Verify .well-known files are accessible
- [ ] Test on real devices (not simulators)

## 📞 Support

If you need help with:
- App Store Connect configuration
- Getting production SHA256 fingerprints  
- Testing on real devices
- Debugging Universal Links

Please check the console logs in your web browser and app for detailed error messages.
