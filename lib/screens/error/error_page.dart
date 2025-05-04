import 'package:flutter/material.dart';
import 'package:haengunse/utils/error_type.dart';
import 'package:haengunse/screens/home/home_screen.dart';

class ErrorPage extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onRetry;
  final ErrorType errorType;
  final Widget? backScreen;

  const ErrorPage({
    super.key,
    required this.title,
    required this.message,
    this.onRetry,
    this.errorType = ErrorType.unknown,
    this.backScreen,
  });

  Widget _getVisual() {
    if (errorType == ErrorType.connectionError) {
      return Icon(Icons.wifi_off, size: 80, color: Colors.blueGrey);
    } else {
      return Image.asset(
        'assets/images/error_sad.png',
        width: 180,
        height: 180,
        fit: BoxFit.contain,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => backScreen ?? const HomeScreen()),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xFFF3F3F3),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: true,
          title: const Text(''),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _getVisual(),
                const SizedBox(height: 20),
                Text(
                  message,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                if (onRetry != null)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: onRetry,
                    child: const Text("다시 시도"),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
