import 'dart:async';
import 'package:flutter/material.dart';
import 'package:haengunse/service/manse/manse_interactor.dart';

class ProgressLoadingPage extends StatefulWidget {
  final Map<String, dynamic> payload;

  const ProgressLoadingPage({super.key, required this.payload});

  @override
  State<ProgressLoadingPage> createState() => _ProgressLoadingPageState();
}

class _ProgressLoadingPageState extends State<ProgressLoadingPage> {
  @override
  void initState() {
    super.initState();
    _startRequest();
  }

  void _startRequest() {
    final interactor = ManseInteractor(
      context: context,
      payload: widget.payload,
    );
    interactor.handleManseRequest();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 60),
                CircularProgressIndicator(
                  color: Color(0xFF82c784),
                  strokeWidth: 5.5,
                ),
                SizedBox(height: 40),
                Text(
                  '내 정보 입력 완료',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  '작성하신 정보를 바탕으로\n운세를 계산하고 있어요',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
