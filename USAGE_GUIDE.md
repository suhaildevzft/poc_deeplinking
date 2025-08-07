# 🔗 Flutter Deep Linking POC - Usage Guide

## 📱 What This POC Demonstrates

This proof of concept shows a complete deep linking solution that:

1. **Smart Platform Detection**: Automatically detects iOS, Android, or desktop platforms
2. **App Launch**: Opens the Flutter app if installed on mobile devices
3. **Store Fallback**: Redirects to App Store/Play Store if app is not installed
4. **Desktop Fallback**: Redirects to web dashboard for non-mobile platforms
5. **Parameter Passing**: Forwards URL parameters from website to app

## 🚀 Quick Start

### 1. Start the Website Server
```bash
cd website
python3 server.py
```
The server will start at `http://localhost:8000`

### 2. Run the Flutter App
```bash
cd deeplink_poc
flutter run
```

## 🧪 Testing Scenarios

### Scenario 1: Desktop Browser
1. Open `http://localhost:8000` in any desktop browser
2. The page detects it's not a mobile platform
3. Shows a direct link to the web dashboard: `https://ww2staging.slavic401k.com/participant-portal-uat/dashboard`

### Scenario 2: Mobile with App Installed
1. Install the Flutter app on your mobile device
2. Open `http://localhost:8000` in your mobile browser
3. Click "Open App" - should launch the Flutter app
4. The app will display the deep link details and parameters

### Scenario 3: Mobile without App
1. Open `http://localhost:8000` on a mobile device without the app installed
2. Click "Open App" - attempts to launch app for 2 seconds
3. Automatically redirects to the appropriate app store

### Scenario 4: Direct Deep Links
Test these URLs directly (replace with your device's IP for mobile testing):
- `deeplinkpoc://example.com/dashboard?userId=123&source=website`
- `http://localhost:8000?userId=456&token=abc123`

## 📋 URL Schemes

### Custom Scheme (Primary)
- **Format**: `deeplinkpoc://example.com/dashboard?param=value`
- **Usage**: Direct app launch, works offline
- **Platform**: iOS & Android

### HTTP Links (Secondary)
- **Format**: `http://localhost:8000?param=value`
- **Usage**: Smart routing through website
- **Platform**: All platforms

## 🔧 Configuration Details

### Android Configuration
Located in `android/app/src/main/AndroidManifest.xml`:
```xml
<!-- Custom Scheme -->
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="deeplinkpoc" />
</intent-filter>
```

### iOS Configuration
Located in `ios/Runner/Info.plist`:
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
```

## 🌐 Website Features

The website (`index.html`) includes:

1. **Platform Detection**: JavaScript detects iOS, Android, or desktop
2. **Auto-redirect**: Attempts app launch automatically on mobile
3. **Manual Controls**: Backup buttons for user control
4. **Parameter Forwarding**: Passes URL parameters to the app
5. **Responsive Design**: Works on all screen sizes

### Key JavaScript Functions:
- `detectPlatform()`: Identifies user's platform
- `attemptAppOpen()`: Tries to launch the app
- `parseUrlParameters()`: Extracts and forwards URL parameters

## 📱 Flutter App Features

The Flutter app (`lib/main.dart`) includes:

1. **Deep Link Listening**: Handles incoming links while app is running
2. **Initial Link Handling**: Processes links that launched the app
3. **Parameter Display**: Shows parsed URL parameters
4. **Web Fallback**: Button to open web dashboard
5. **Testing Tools**: Simulate deep links for development

### Key Dart Classes:
- `AppLinks`: Modern deep link handling (replaces deprecated `uni_links`)
- `UrlLauncher`: Opens external URLs
- `DeviceInfo`: Platform detection and info

## 🔗 Testing URLs

### For Mobile Testing (replace `YOUR_IP` with your computer's IP):
- `http://YOUR_IP:8000`
- `http://YOUR_IP:8000?userId=123&source=test`

### For App Testing:
- `deeplinkpoc://example.com/dashboard`
- `deeplinkpoc://example.com/dashboard?userId=123&token=abc`

## 🎯 Use Case Flow

```
User clicks link
       ↓
Website detects platform
       ↓
┌─────────────┬─────────────┬─────────────┐
│   Desktop   │    Mobile   │    Mobile   │
│             │ (App Inst.) │  (No App)   │
├─────────────┼─────────────┼─────────────┤
│ Show web    │ Launch app  │ Try launch  │
│ dashboard   │ immediately │ → App store │
│ button      │             │             │
└─────────────┴─────────────┴─────────────┘
       ↓             ↓             ↓
   Web portal    Flutter app    App store
```

## 🔧 Customization

### Change App Scheme
1. Update `android/app/src/main/AndroidManifest.xml`
2. Update `ios/Runner/Info.plist`
3. Update `lib/main.dart`
4. Update `website/index.html`

### Change Web Fallback URL
Update the `WEB_FALLBACK` constant in `website/index.html`:
```javascript
const WEB_FALLBACK = 'https://your-new-domain.com/dashboard';
```

### Add App Store Links
Update these constants in `website/index.html`:
```javascript
const IOS_APP_STORE = 'https://apps.apple.com/app/your-app-id';
const ANDROID_PLAY_STORE = 'https://play.google.com/store/apps/details?id=your.package.name';
```

## 🐛 Troubleshooting

### App Doesn't Open
1. Ensure the app is installed and has the correct scheme configured
2. Check Android/iOS intent filter configuration
3. Test with `adb shell` commands on Android

### Website Doesn't Detect Platform
1. Check browser user agent
2. Verify JavaScript is enabled
3. Test on actual mobile devices, not browser dev tools

### Parameters Not Passed
1. Check URL encoding
2. Verify parameter parsing in both website and app
3. Test with simple parameters first

## 📊 Analytics Integration

For production, consider adding:
- Link click tracking
- Platform detection analytics
- App launch success rates
- Fallback usage statistics

## 🚀 Production Deployment

### Universal Links (iOS)
1. Set up Apple App Site Association file
2. Configure domain verification
3. Update intent filters with your domain

### App Links (Android)
1. Set up Digital Asset Links
2. Configure domain verification
3. Add `android:autoVerify="true"`

### Website Hosting
1. Deploy website to your domain
2. Update all hardcoded URLs
3. Set up HTTPS
4. Configure proper redirects

---

**Note**: This is a proof of concept. For production use, ensure proper testing across all target devices and implement additional security measures.
