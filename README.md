# 🔗 Flutter Deep Linking POC

[![Deploy to GitHub Pages](https://github.com/YOUR_USERNAME/poc_deeplinking/actions/workflows/deploy.yml/badge.svg)](https://github.com/YOUR_USERNAME/poc_deeplinking/actions/workflows/deploy.yml)

**Live Demo**: [https://YOUR_USERNAME.github.io/poc_deeplinking/](https://YOUR_USERNAME.github.io/poc_deeplinking/)

This project demonstrates a complete deep linking solution for Flutter applications with a web fallback system that automatically redirects users based on their platform.

## 🎯 Use Case

The POC implements the following smart routing flow:
1. User clicks on a link that redirects to the website
2. Website detects the platform (mobile/desktop) automatically
3. **Desktop platforms**: Automatically redirect to the web dashboard at `https://ww2staging.slavic401k.com/participant-portal-uat/dashboard`
4. **Mobile platforms**: Attempt to open the app if installed, otherwise redirect to app store

## 🌐 Live Website Features

- **🔍 Smart Platform Detection**: Automatically identifies iOS/Android/Desktop
- **⚡ Auto-redirect**: 
  - Desktop → Direct redirect to web dashboard (same tab)
  - Mobile → Attempts app launch or store redirect
- **📱 Manual Controls**: Fallback buttons for user control
- **🔗 Parameter Forwarding**: Passes URL parameters to the app
- **📊 Real-time Info**: Shows platform detection and URL parameters

## 🏗️ Project Structure

```
poc_deeplinking/
├── deeplink_poc/          # Flutter app
│   ├── lib/main.dart      # Main app with deep linking logic
│   ├── android/           # Android configuration
│   ├── ios/               # iOS configuration
│   └── pubspec.yaml       # Dependencies
├── website/               # Deep linking website
│   ├── index.html         # Smart redirector page
│   └── server.py          # Local development server
└── README.md              # This file
```

## 🚀 Quick Start

### 1. Flutter App Setup

```bash
cd deeplink_poc
flutter pub get
flutter run
```

### 2. Website Server

```bash
cd website
python3 server.py
```

The website will be available at `http://localhost:8000`

### 3. Testing Deep Links

#### On Mobile Device:
1. Open `http://localhost:8000` in your mobile browser
2. The page will automatically detect your platform
3. Click "Open App" to test the deep link

#### Custom Scheme URLs:
- `deeplinkpoc://example.com/dashboard?userId=123`
- `deeplinkpoc://example.com/dashboard?userId=123&source=website`

#### Universal Links (requires proper domain setup):
- `https://your-domain.com/app/dashboard?userId=123`

## 📱 Flutter App Features

- **Deep Link Handling**: Listens for incoming deep links
- **Platform Detection**: Identifies iOS/Android devices
- **URL Parameter Parsing**: Extracts data from deep link URLs
- **Web Fallback**: Can launch the web dashboard
- **Testing Tools**: Built-in simulation for testing

### App Screens

The app displays:
- Device information
- Latest received deep link
- Buttons to simulate deep links
- Button to open web fallback

## 🌐 Website Features

- **Smart Platform Detection**: Automatically identifies iOS/Android/Desktop
- **Auto-redirect**: Attempts to open the app automatically on mobile
- **Manual Controls**: Fallback buttons for user control
- **App Store Links**: Redirects to appropriate app store if app not installed
- **Desktop Fallback**: Direct link to web dashboard
- **URL Parameter Forwarding**: Passes parameters to the app

## ⚙️ Configuration

### Android Configuration

The app is configured in `android/app/src/main/AndroidManifest.xml` with:

```xml
<!-- Custom Scheme Deep Links -->
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="deeplinkpoc" />
</intent-filter>

<!-- Universal Links -->
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="https" android:host="your-domain.com" />
</intent-filter>
```

### iOS Configuration

The app is configured in `ios/Runner/Info.plist` with:

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

## 🧪 Testing Scenarios

### Scenario 1: App Installed
1. Install the Flutter app on your device
2. Open the website on the same device
3. Click "Open App" - should launch the Flutter app

### Scenario 2: App Not Installed
1. Open the website without the app installed
2. Click "Open App" - should redirect to app store after timeout

### Scenario 3: Desktop Browser
1. Open the website on desktop
2. Should automatically show web dashboard button
3. Click button - opens `https://ww2staging.slavic401k.com/participant-portal-uat/dashboard`

### Scenario 4: Direct Deep Link
1. Open `deeplinkpoc://example.com/dashboard?userId=123` directly
2. Should launch the app and show the parameters

## 📋 Dependencies

### Flutter Dependencies
- `uni_links: ^0.5.1` - Deep link handling
- `url_launcher: ^6.2.4` - Launch external URLs
- `device_info_plus: ^10.1.0` - Platform detection

### Website Dependencies
- Pure HTML/CSS/JavaScript (no frameworks required)
- Python 3 for local server (built-in `http.server`)

## 🔧 Customization

### Update App Scheme
1. Change `deeplinkpoc` to your custom scheme in:
   - `android/app/src/main/AndroidManifest.xml`
   - `ios/Runner/Info.plist`
   - `lib/main.dart`
   - `website/index.html`

### Update App Store Links
1. Edit `website/index.html`
2. Update `IOS_APP_STORE` and `ANDROID_PLAY_STORE` constants

### Update Web Fallback URL
1. Edit `website/index.html`
2. Update `WEB_FALLBACK` constant
3. Or modify in `lib/main.dart` for the Flutter app button

## 🐛 Troubleshooting

### Deep Links Not Working
1. Check app is properly installed
2. Verify scheme configuration in platform files
3. Test with `adb` on Android: `adb shell am start -W -a android.intent.action.VIEW -d "deeplinkpoc://test" com.example.deeplink_poc`

### Website Not Loading
1. Ensure Python server is running
2. Check firewall settings
3. Try different port if 8000 is busy

### App Store Redirects Not Working
1. Update app store URLs in `website/index.html`
2. Ensure timeout is sufficient for app launch attempt

## 📱 Production Deployment

### For Production Website:
1. Deploy `website/index.html` to your web server
2. Update domain references in the HTML
3. Set up Universal Links with proper domain verification

### For App Store:
1. Update bundle identifiers
2. Configure proper app store URLs
3. Set up Universal Links domain verification
4. Test thoroughly on physical devices

## 🎯 Next Steps

1. **Universal Links**: Set up proper domain verification for production
2. **Analytics**: Add tracking for deep link usage
3. **Deferred Deep Links**: Handle app install + open flow
4. **Custom Parameters**: Enhance parameter handling based on use case
5. **Error Handling**: Add comprehensive error handling and user feedback

## 📞 Support

For issues or questions about this POC:
1. Check the troubleshooting section
2. Review Flutter deep linking documentation
3. Test on physical devices for accurate results

---

**Note**: This is a proof of concept. For production use, ensure proper testing across all target devices and platforms.
