# Universal Links Setup for Direct App Opening

## What are Universal Links?

Universal Links are Apple's preferred method for deep linking. They:
- Open apps directly without prompts
- Work even if the app isn't installed (fallback to website)
- Are more secure and reliable than custom URL schemes

## Setup Steps

### 1. Create Apple App Site Association File

Create a file named `apple-app-site-association` (no extension) and host it at:
```
https://suhaildevzft.github.io/.well-known/apple-app-site-association
```

Content:
```json
{
  "applinks": {
    "apps": [],
    "details": [
      {
        "appID": "TEAMID.com.example.deeplinkpoc",
        "paths": [ "/app/*", "/deeplink/*" ]
      }
    ]
  }
}
```

### 2. Update iOS Configuration

Add to `ios/Runner/Runner.entitlements`:
```xml
<dict>
  <key>com.apple.developer.associated-domains</key>
  <array>
    <string>applinks:suhaildevzft.github.io</string>
  </array>
</dict>
```

### 3. Update Website URLs

Change website to use:
```
https://suhaildevzft.github.io/poc_deeplinking/app/dashboard
```
Instead of:
```
deeplinkpoc://example.com/dashboard
```

## Quick Test Setup

For immediate testing without Universal Links setup, you can:

1. **Tap "Open" in the prompt** - This will remember your preference
2. **Use Safari's "Open in App" feature**
3. **Modify the website to be less aggressive with prompts**
