import 'package:epic_skies/core/error_handling/error_model.dart';
import 'package:epic_skies/features/banner_ads/bloc/ad_bloc.dart';
import 'package:epic_skies/view/dialogs/platform_dialog.dart';
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

    final actions = {
      'Cool!': () => Navigator.of(context).pop(),
    };

    Dialogs.showPlatformDialog(
      context,
      content: content,
      dialogActions: actions,
    );
  }

  static void explainAdPolicy(BuildContext context) {
    const content =
        r'''Epic Skies will be ad free for 7 days. After that, you will see ads or you can remove ads by purchasing premium for a one time fee of $0.99''';

    final actions = {
      'Got it!': () => Navigator.of(context).pop(),
    };

    Dialogs.showPlatformDialog(
      context,
      content: content,
      dialogActions: actions,
    );
  }

  static void trialEnded(BuildContext context) {
    const content =
        r'''Thanks for using Epic Skies for 7 days! The ad free grace period has ended. You can remove ads permanently and support the developer for a one time fee of $0.99''';

    void popAndConfirmPurchase(BuildContext context) {
      Navigator.of(context).pop();
      confirmBeforeAdFreePurchase(context);
    }

    final actions = {
      'Continue with ads': () => Navigator.of(context).pop(),
      'Purchase Premium': () => popAndConfirmPurchase(context),
    };

    Dialogs.showPlatformDialog(
      context,
      content: content,
      dialogActions: actions,
    );
  }

  static void adPurchaseError(BuildContext context, String message) {
    final actions = {
      'Ok': () => _purchaseAdFree(context),
    };

    Dialogs.showPlatformDialog(
      context,
      content: message,
      dialogActions: actions,
    );
  }

  static void confirmBeforeAdFreePurchase(BuildContext context) {
    var content = r'Remove ads for a one-time fee of  $0.99?';

    var actions = {
      'No thanks': () => Navigator.of(context).pop(),
      'Go for it!': () => _purchaseAdFree(context),
    };

    if (context.read<AdBloc>().state.status.isAdFreePurchased) {
      content = 'Your purchase is restored and Epic Skies is ad free 😎';
      actions = {
        'Cool!': () => Navigator.of(context).pop(),
      };
    }

    Dialogs.showPlatformDialog(
      context,
      content: content,
      dialogActions: actions,
    );
  }

  static void noPurchasesFound(BuildContext context, ErrorModel errorModel) {
    final actions = {
      'Ok': () => Navigator.of(context).pop(),
    };

    Dialogs.showPlatformDialog(
      context,
      content: errorModel.message,
      title: errorModel.title,
      dialogActions: actions,
    );
  }
}
