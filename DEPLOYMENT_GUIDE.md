# 🚀 GitHub Pages Deployment Guide

## Quick Deployment Steps

### 1. Create GitHub Repository

1. Go to [GitHub](https://github.com) and create a new repository
2. Name it `poc_deeplinking` (or any name you prefer)
3. **Important**: Make it **public** (GitHub Pages is free for public repos)
4. Don't initialize with README (we already have one)

### 2. Push Your Code

```bash
# Add your GitHub repository as remote (replace YOUR_USERNAME and REPO_NAME)
git remote add origin https://github.com/YOUR_USERNAME/poc_deeplinking.git

# Push to GitHub
git push -u origin main
```

### 3. Enable GitHub Pages

1. Go to your repository on GitHub
2. Click **Settings** tab
3. Scroll down to **Pages** section
4. Under **Source**, select **GitHub Actions**
5. The deployment will start automatically!

### 4. Access Your Live Website

Your website will be available at:
```
https://YOUR_USERNAME.github.io/poc_deeplinking/
```

## 🔧 What's Already Configured

### ✅ Automatic Deployment
- GitHub Actions workflow (`.github/workflows/deploy.yml`)
- Automatically deploys on every push to `main` branch
- No manual intervention needed

### ✅ Production-Ready Website
- Desktop auto-redirect to Slavic401k dashboard
- Mobile smart app launching
- URL parameter forwarding
- Platform detection
- QR code instructions for mobile testing

### ✅ SEO & Optimization
- Clean URLs
- Responsive design
- Fast loading
- Mobile-optimized

## 📱 Testing Your Deployed Website

### Desktop Testing
1. Visit `https://YOUR_USERNAME.github.io/poc_deeplinking/`
2. Should auto-redirect to `https://ww2staging.slavic401k.com/participant-portal-uat/dashboard`

### Mobile Testing
1. Use the QR code displayed on the website
2. Or share the GitHub Pages URL to your mobile device
3. Should attempt to launch the Flutter app or redirect to app store

### Parameter Testing
Test with parameters:
```
https://YOUR_USERNAME.github.io/poc_deeplinking/?userId=123&source=test
```

## 🔍 Monitoring Deployment

### Check Deployment Status
1. Go to your repository
2. Click **Actions** tab
3. See the deployment progress

### View Deployment Logs
- Click on any workflow run to see detailed logs
- Green checkmark = successful deployment
- Red X = deployment failed (check logs for errors)

## 🛠️ Customization

### Update URLs
Edit `website/index.html` to change:
- App Store links
- Custom scheme
- Fallback URLs

### Update Branding
- Replace title and descriptions
- Update colors in CSS
- Add your logo

### Add Analytics
Add Google Analytics or other tracking:
```html
<!-- Add to <head> section -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'GA_MEASUREMENT_ID');
</script>
```

## 🔗 Integration with Flutter App

### Update App Configuration
In your Flutter app, update the universal links to point to your GitHub Pages URL:

```xml
<!-- Android: android/app/src/main/AndroidManifest.xml -->
<data android:scheme="https" 
      android:host="YOUR_USERNAME.github.io"
      android:pathPrefix="/poc_deeplinking" />
```

```xml
<!-- iOS: ios/Runner/Info.plist -->
<key>com.apple.developer.associated-domains</key>
<array>
    <string>applinks:YOUR_USERNAME.github.io</string>
</array>
```

## 🌍 Custom Domain (Optional)

### To use your own domain:

1. **Add CNAME file** in `website/` folder:
```
echo "yourdomain.com" > website/CNAME
```

2. **Update DNS** - Add CNAME record:
```
CNAME: www -> YOUR_USERNAME.github.io
```

3. **Push changes**:
```bash
git add website/CNAME
git commit -m "Add custom domain"
git push
```

4. **Configure in GitHub**:
   - Go to Settings → Pages
   - Enter your custom domain
   - Enable "Enforce HTTPS"

## 🚨 Troubleshooting

### Deployment Failed
- Check Actions tab for error logs
- Ensure repository is public
- Verify all files are committed

### Website Not Loading
- Wait 5-10 minutes after first deployment
- Check if GitHub Pages is enabled in settings
- Verify the correct branch is selected

### Mobile Deep Links Not Working
- Test on actual mobile devices (not browser dev tools)
- Ensure Flutter app is installed with correct scheme
- Check app store links are valid

## 📊 Production Checklist

- [ ] Repository is public
- [ ] GitHub Pages enabled
- [ ] Deployment successful (green checkmark)
- [ ] Website loads on desktop
- [ ] Auto-redirect works on desktop
- [ ] Mobile testing completed
- [ ] App store links verified
- [ ] Parameters forwarding tested
- [ ] Custom domain configured (if needed)
- [ ] Analytics added (if needed)

---

**🎉 Your deep linking POC is now live and ready for testing!**

**Next Steps:**
1. Test thoroughly on different devices
2. Share the GitHub Pages URL with stakeholders
3. Use for app store submissions
4. Integrate with your production app
