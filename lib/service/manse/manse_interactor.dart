import 'package:flutter/material.dart';
import 'package:haengunse/screens/home_screen.dart';
import 'package:haengunse/service/manse/manse_repository.dart';
import 'package:haengunse/utils/request_helper.dart';
import 'package:haengunse/screens/input_screen.dart';

class ManseInteractor {
  final BuildContext context;
  final Map<String, dynamic> payload;

  ManseInteractor({
    required this.context,
    required this.payload,
  });

  Future<void> handleManseRequest() async {
    final minDelay = Future.delayed(const Duration(seconds: 3));

    await handleRequest<bool>(
      context: context,
      fetch: () async {
        final result = await ManseRepository.sendManse(payload);
        await minDelay;
        return result;
      },
      onSuccess: (success) {
        if (!context.mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      },
      retry: () {
        final interactor = ManseInteractor(
          context: context,
          payload: payload,
        );
        interactor.handleManseRequest();
      },
      backScreen: const InputScreen(),
    );
  }
}
