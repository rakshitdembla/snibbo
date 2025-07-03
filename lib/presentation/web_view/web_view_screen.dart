import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage()
class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onHttpError: (error) {
                UiUtils.showToast(
                  title: "Failed to load page",
                  isDark: isDark,
                  description: error.toString(),
                  context: context,
                  isSuccess: false,
                  isWarning: false,
                );
              },
              onWebResourceError: (WebResourceError error) {
                UiUtils.showToast(
                  title: "Failed to load page",
                  isDark: isDark,
                  description: error.toString(),
                  context: context,
                  isSuccess: false,
                  isWarning: false,
                );
              },
              onPageStarted: (String url) {
                setState(() {
                  isLoading = true;
                });
              },
              onPageFinished: (String url) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Snibbo WebView')),
      body:
          SafeArea(
            child: isLoading
                ? Center(child: CircularProgressLoading())
                : WebViewWidget(controller: _controller),
          ),
    );
  }
}
