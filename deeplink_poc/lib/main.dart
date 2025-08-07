import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'package:app_links/app_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:device_info_plus/device_info_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deep Link POC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Deep Link POC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _latestLink = 'No link received yet';
  StreamSubscription? _linkSubscription;
  String _deviceInfo = '';
  late AppLinks _appLinks;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();
    _initDeepLinkListener();
    _getDeviceInfo();
    _handleInitialLink();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  // Initialize deep link listener
  void _initDeepLinkListener() {
    _linkSubscription = _appLinks.uriLinkStream.listen(
      (Uri uri) {
        setState(() {
          _latestLink = uri.toString();
        });
        _handleDeepLink(uri.toString());
      },
      onError: (err) {
        setState(() {
          _latestLink = 'Error: $err';
        });
      },
    );
  }

  // Handle initial link when app is launched from a deep link
  Future<void> _handleInitialLink() async {
    try {
      final Uri? initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        setState(() {
          _latestLink = initialUri.toString();
        });
        _handleDeepLink(initialUri.toString());
      }
    } on PlatformException {
      setState(() {
        _latestLink = 'Failed to get initial link';
      });
    } catch (e) {
      setState(() {
        _latestLink = 'Error getting initial link: $e';
      });
    }
  }

  // Handle deep link logic
  void _handleDeepLink(String link) {
    // Parse the link and extract parameters if needed
    Uri uri = Uri.parse(link);
    
    // Show a dialog or navigate to a specific screen based on the link
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deep Link Received'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Link: $link'),
              const SizedBox(height: 10),
              Text('Host: ${uri.host}'),
              Text('Path: ${uri.path}'),
              if (uri.queryParameters.isNotEmpty)
                Text('Parameters: ${uri.queryParameters}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Get device information
  Future<void> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String info = '';
    
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        info = 'Android ${androidInfo.version.release} (API ${androidInfo.version.sdkInt})';
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        info = 'iOS ${iosInfo.systemVersion}';
      }
    } catch (e) {
      info = 'Failed to get device info';
    }
    
    setState(() {
      _deviceInfo = info;
    });
  }

  // Launch the web fallback URL
  Future<void> _launchWebFallback() async {
    const String fallbackUrl = 'https://ww2staging.slavic401k.com/participant-portal-uat/dashboard';
    final Uri url = Uri.parse(fallbackUrl);
    
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch URL')),
        );
      }
    }
  }

  // Simulate deep link (for testing)
  void _simulateDeepLink() {
    const String testLink = 'deeplinkpoc://example.com/dashboard?userId=123&token=abc';
    _handleDeepLink(testLink);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Device Information',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(_deviceInfo),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Latest Deep Link',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(_latestLink),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _simulateDeepLink,
              child: const Text('Simulate Deep Link'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _launchWebFallback,
              child: const Text('Open Web Fallback'),
            ),
            const SizedBox(height: 24),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Test URLs',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('Custom Scheme: deeplinkpoc://example.com/dashboard'),
                    Text('Universal Link: https://your-domain.com/app/dashboard'),
                    SizedBox(height: 8),
                    Text(
                      'Use these URLs to test deep linking functionality.',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
