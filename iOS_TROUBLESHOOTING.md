# 🍎 iOS Deep Linking Troubleshooting Guide

## Problem: App Not Opening on iOS

If your Flutter app is not opening when accessing https://suhaildevzft.github.io/poc_deeplinking/ on iOS, here are the steps to diagnose and fix the issue:

## 🔍 Quick Diagnosis

### 1. Test Basic Deep Link Manually
Open Safari on your iOS device and type these URLs directly in the address bar:

```
deeplinkpoc://
deeplinkpoc://example.com
deeplinkpoc://example.com/dashboard
```

**Expected Results:**
- ✅ **App Opens**: Deep linking is working correctly
- ❌ **"Cannot Open Page" error**: App not installed or URL scheme not configured
- ❌ **Nothing happens**: Browser may be blocking the scheme

### 2. Check if Flutter App is Installed
- Make sure you've built and installed the Flutter app on your iOS device
- The app must be installed from Xcode or TestFlight, not just from `flutter run`

### 3. Test from Different Browsers
- **Safari**: Primary test browser (most reliable for deep links)
- **Chrome**: May have different behavior
- **In-app browsers**: Often block deep links

## 🔧 Flutter App Configuration Check

### Verify iOS URL Scheme Configuration

Check `ios/Runner/Info.plist` contains:

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

### Verify Flutter Deep Link Handling

Check `lib/main.dart` has proper app_links configuration:

```dart
import 'package:app_links/app_links.dart';

class _MyHomePageState extends State<MyHomePage> {
  late AppLinks _appLinks;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();
    _initDeepLinkListener();
    _handleInitialLink();
  }

  void _initDeepLinkListener() {
    _appLinks.uriLinkStream.listen((Uri uri) {
      // Handle deep link
    });
  }

  Future<void> _handleInitialLink() async {
    final Uri? initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      // Handle initial link
    }
  }
}
```

## 🛠️ Step-by-Step Fixes

### Fix 1: Rebuild and Reinstall App

```bash
cd deeplink_poc
flutter clean
flutter pub get
flutter build ios
```

Then install via Xcode or:
```bash
flutter install
```

### Fix 2: Check iOS Bundle Identifier

Ensure your `ios/Runner.xcodeproj` bundle identifier matches what's expected.

### Fix 3: Test with Xcode Debugging

1. Open `ios/Runner.xcworkspace` in Xcode
2. Set breakpoints in `AppDelegate.swift`
3. Run the app and test deep links
4. Check Xcode console for deep link events

### Fix 4: Verify App Store Links

Update the App Store link in the website to a real app:

```javascript
const IOS_APP_STORE = 'https://apps.apple.com/app/YOUR_REAL_APP_ID';
```

## 🧪 Advanced Testing

### Method 1: Test via Notes App
1. Open Notes app on iOS
2. Type: `deeplinkpoc://example.com/dashboard`
3. Tap the link

### Method 2: Test via Messages
1. Send yourself a message with the deep link
2. Tap the link in the message

### Method 3: Test via ADB (if debugging)
```bash
adb shell am start -W -a android.intent.action.VIEW -d "deeplinkpoc://example.com/dashboard" com.example.deeplinkpoc
```

## 🔍 Debug Website Behavior

### Open Browser Console on iOS
1. Connect iOS device to Mac
2. Open Safari on Mac
3. Go to Develop > [Your Device] > [Your Tab]
4. Check console for errors when testing deep links

### Test the New iOS-Specific Code

The updated website now includes:
- iOS-specific deep link handling using iframe method
- Better error detection
- Enhanced fallback logic
- Manual testing buttons

Visit: https://suhaildevzft.github.io/poc_deeplinking/

Look for the "🍎 Test iOS Deep Link" buttons in the iOS testing section.

## 📱 iOS-Specific Considerations

### iOS Security Restrictions
- iOS may block deep links from certain contexts
- Some browsers don't support deep links
- iOS 13+ has stricter deep link policies

### Universal Links Alternative
Consider implementing Universal Links for better iOS support:

1. Add Associated Domains to your app
2. Set up `.well-known/apple-app-site-association` file
3. Update website to use https:// links instead of custom scheme

### iOS Simulator vs Real Device
- Deep links often don't work in iOS Simulator
- Always test on a real iOS device
- Different iOS versions may behave differently

## 🎯 Quick Test Checklist

- [ ] Flutter app is built and installed on iOS device
- [ ] Testing from Safari browser (not Chrome)
- [ ] URL scheme `deeplinkpoc` is configured in Info.plist
- [ ] App_links package is properly implemented
- [ ] Testing on real device (not simulator)
- [ ] Manual deep link test: `deeplinkpoc://example.com/dashboard`
- [ ] Check browser console for JavaScript errors
- [ ] Test the new iOS testing buttons on the website

## 🚨 Common Issues and Solutions

### Issue: "Cannot Open Page" Error
**Solution**: App not installed or URL scheme mismatch

### Issue: Nothing Happens When Clicking Link
**Solution**: Browser blocking or iOS security restrictions

### Issue: App Opens But No Data Received
**Solution**: Check deep link parameter parsing in Flutter app

### Issue: Works in Development But Not Production
**Solution**: Check bundle identifier and signing configuration

---

## 🔄 Next Steps

1. **Test manually first**: Try `deeplinkpoc://example.com/dashboard` directly in Safari
2. **Check app installation**: Ensure the Flutter app is properly installed
3. **Use the new testing tools**: Visit the updated website with iOS-specific test buttons
4. **Consider Universal Links**: For production apps, implement Universal Links for better iOS support

If the issue persists, the problem is likely in the Flutter app configuration rather than the website.
