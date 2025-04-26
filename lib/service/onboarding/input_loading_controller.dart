import 'package:flutter/material.dart';
import 'package:haengunse/service/onboarding/manse_interactor.dart';

class InputLoadingController {
  final BuildContext context;
  final Map<String, dynamic> payload;

  InputLoadingController({
    required this.context,
    required this.payload,
  });

  void start() {
    final interactor = ManseInteractor(
      context: context,
      payload: payload,
    );
    interactor.handleManseRequest();
  }
}
