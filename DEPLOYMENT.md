# GitHub Pages Deployment Guide

## 🚀 Quick Deployment Steps

1. **Push to GitHub:**
   ```bash
   git add .
   git commit -m "Add deep linking setup for GitHub Pages"
   git push origin main
   ```

2. **Enable GitHub Pages:**
   - Go to your repository settings
   - Scroll to "Pages" section
   - Select "GitHub Actions" as source
   - The workflow will automatically deploy

3. **Access Your Deep Links:**
   - Main page: `https://suhaildevzft.github.io/poc_deeplinking/`
   - Demo page: `https://suhaildevzft.github.io/poc_deeplinking/demo.html`
   - Test console: `https://suhaildevzft.github.io/poc_deeplinking/test-console.html`
   - Universal link: `https://suhaildevzft.github.io/poc_deeplinking/app/dashboard`

## 📱 Test URLs for Mobile

### Basic Deep Link Tests
```
https://suhaildevzft.github.io/poc_deeplinking/
https://suhaildevzft.github.io/poc_deeplinking/index.html?path=dashboard&userId=123
```

### Universal Link Tests
```
https://suhaildevzft.github.io/poc_deeplinking/app/dashboard
https://suhaildevzft.github.io/poc_deeplinking/app/dashboard?userId=123&token=abc
```

### Custom Scheme Tests (Direct)
```
deeplinkpoc://example.com/dashboard
deeplinkpoc://example.com/dashboard?userId=123
```

## 🔧 Files Deployed

The GitHub Actions workflow deploys these files:

- `index.html` → Main deep link handler
- `demo.html` → Demo and documentation page
- `test-console.html` → Testing console
- `app/dashboard/index.html` → Universal link handler
- `.well-known/apple-app-site-association` → iOS app association
- `.well-known/assetlinks.json` → Android app links
- `.nojekyll` → Ensures proper file handling

## 🧪 Testing After Deployment

1. **Open the test console:** `https://suhaildevzft.github.io/poc_deeplinking/test-console.html`
2. **Check system status** to ensure HTTPS is working
3. **Test basic deep links** on mobile devices
4. **Verify app association files** are accessible:
   - `https://suhaildevzft.github.io/poc_deeplinking/.well-known/apple-app-site-association`
   - `https://suhaildevzft.github.io/poc_deeplinking/.well-known/assetlinks.json`

## 🔄 Deployment Status

Check deployment status at:
`https://github.com/suhaildevzft/poc_deeplinking/actions`

## 📝 Notes

- **HTTPS Required:** GitHub Pages automatically provides HTTPS
- **Domain Verification:** App association files are automatically served
- **Caching:** GitHub Pages may cache files for up to 10 minutes
- **Custom Domains:** Can be configured in repository settings if needed

## 🛠️ Troubleshooting

### Deployment Fails
- Check Actions tab for error logs
- Ensure all required files exist
- Verify file paths in the workflow

### App Association Files Not Working
- Check if files are accessible directly
- Verify JSON syntax in association files
- Ensure `.nojekyll` file is present

### Deep Links Not Working
- Test on actual mobile devices
- Check browser console for errors
- Verify app is installed and configured correctly
