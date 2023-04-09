import 'dart:io';

import 'package:epic_skies/features/banner_ads/bloc/ad_bloc.dart';
import 'package:epic_skies/global/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdDialogs {
  static void _purchaseAdFree(BuildContext context) {
    Navigator.of(context).pop();
    context.read<AdBloc>().add(AdFreePurchaseRequest());
  }

  static void purchaseSuccessConfirmation(BuildContext context) {
    const content = '''
Thanks for supporting the developer!

Enjoy Epic Skies ad free 😎''';

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            content: const Text(content, style: iOSContentTextStyle),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cool!'),
              ),
            ],
          )
        : AlertDialog(
            content: const Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cool!', style: dialogActionTextStyle),
              ),
            ],
          );

    showDialog<void>(context: context, builder: (context) => dialog);
  }

  static void explainAdPolicy(BuildContext context) {
    const content =
        r'''Epic Skies will be ad free for 7 days. After that, you will see ads or you can remove ads by purchasing premium for a one time fee of $0.99''';

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            content: const Text(content, style: iOSContentTextStyle),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Got it!',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ],
          )
        : AlertDialog(
            content: const Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Got it!', style: dialogActionTextStyle),
              ),
            ],
          );

    showDialog<void>(context: context, builder: (context) => dialog);
  }

  static void trialEnded(BuildContext context) {
    const content =
        r'''Thanks for using Epic Skies for 7 days! The ad free grace period has ended. You can remove ads permanently and support the developer for a one time fee of $0.99''';

    const continueText = Text(
      'Continue with ads',
      style: TextStyle(color: Colors.red),
    );
    const purchaseText = Text('Purchase Premium');

    void popAndConfirmPurchase(BuildContext context) {
      Navigator.of(context).pop();
      confirmBeforeAdFreePurchase(context);
    }

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            content: const Text(content, style: iOSContentTextStyle),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(),
                child: continueText,
              ),
              CupertinoDialogAction(
                onPressed: () => popAndConfirmPurchase(context),
                child: purchaseText,
              ),
            ],
          )
        : AlertDialog(
            content: const Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: continueText,
              ),
              TextButton(
                onPressed: () => popAndConfirmPurchase(context),
                child: purchaseText,
              ),
            ],
          );

    showDialog<void>(context: context, builder: (context) => dialog);
  }

  static void adPurchaseError(BuildContext context, String message) {
    const purchaseText = Text('Ok');

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            content: Text(message, style: iOSContentTextStyle),
            actions: [
              CupertinoDialogAction(
                onPressed: () => _purchaseAdFree(context),
                child: purchaseText,
              ),
            ],
          )
        : AlertDialog(
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => _purchaseAdFree(context),
                child: purchaseText,
              ),
            ],
          );

    showDialog<void>(context: context, builder: (context) => dialog);
  }

  static void confirmBeforeAdFreePurchase(BuildContext context) {
    const content =
        r"Are you sure you'd like to remove ads for a one-time fee of  $0.99?";

    const continueText = Text('No thanks', style: TextStyle(color: Colors.red));
    const purchaseText = Text('Go for it!');

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            content: const Text(content, style: iOSContentTextStyle),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(),
                child: continueText,
              ),
              CupertinoDialogAction(
                onPressed: () => _purchaseAdFree(context),
                child: purchaseText,
              ),
            ],
          )
        : AlertDialog(
            content: const Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: continueText,
              ),
              TextButton(
                onPressed: () => _purchaseAdFree(context),
                child: purchaseText,
              ),
            ],
          );

    showDialog<void>(context: context, builder: (context) => dialog);
  }
}
