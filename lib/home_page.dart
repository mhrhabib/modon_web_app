import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime timeBackPressed = DateTime.now();

  double progressVal = 0;

  late InAppWebViewController inAppWebViewController;

  @override
  void initState() {
    super.initState();
    // controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(const Color(0x00000000))
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // Update loading bar.
    //       },
    //       onPageStarted: (String url) {},
    //       onPageFinished: (String url) {},
    //       onWebResourceError: (WebResourceError error) {},
    //       onNavigationRequest: (NavigationRequest request) {
    //         if (request.url.startsWith('https://beta.aqarmodon.com')) {
    //           return NavigationDecision.prevent;
    //         }
    //         return NavigationDecision.navigate;
    //       },
    //     ),
    //   )
    //   ..loadRequest(Uri.parse('https://beta.aqarmodon.com'));
  }

  canPopFunction() async {
    final difference = DateTime.now().difference(timeBackPressed);
    timeBackPressed = DateTime.now();
    final isExitWarning = difference >= const Duration(seconds: 2);

    if (await inAppWebViewController.canGoBack()) {
      inAppWebViewController.goBack();

      return false;
    } else {
      if (isExitWarning) {
        const message = 'Press back again to exit';
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          message,
        )));
        return false;
      } else {
        return true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (isPoped) async {
        if (isPoped) {
          return;
        }
        final navigator = Navigator.of(context);
        bool value = await canPopFunction();
        if (value) {
          navigator.pop();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri('https://beta.aqarmodon.com'),
                ),
                onWebViewCreated: (controller) {
                  inAppWebViewController = controller;
                },
                onProgressChanged: (controller, progress) {
                  setState(() {
                    progressVal = progress / 100;
                  });
                },
              ),
              progressVal < 1
                  ? LinearProgressIndicator(
                      value: progressVal,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
