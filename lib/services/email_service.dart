import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/view/dialogs/platform_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailService {
  Future<void> sendEmail(
    BuildContext context, [
    String? subject,
  ]) async {
    try {
      final email = Email(
        subject: 'Epic Skies Feedback',
        recipients: [supportEmail],
      );

      await FlutterEmailSender.send(email);
    } on Exception {
      await _backUpEmailService(context, subject);
    }
  }

  Future<void> _backUpEmailService(
    BuildContext context, [
    String? subject,
  ]) async {
    try {
      final emailUri = Uri(
        scheme: 'mailto',
        path: supportEmail,
        queryParameters: {
          'subject': {subject ?? 'Epic Skies Feedback'}
        },
      );

      await launchUrl(emailUri);
    } on Exception {
      const message = '''
No default email client found. \n
You can email the developer at $supportEmail''';

      Dialogs.showPlatformDialog(
        context,
        content: message,
        dialogActions: {'Ok': Navigator.of(context).pop},
        title: 'Open Mail App',
      );
    }
  }
}
