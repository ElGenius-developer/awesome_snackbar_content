import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class AweseomSnackBarExample extends StatelessWidget {
  const AweseomSnackBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: const Text('Show Awesome SnackBar'),
              onPressed: () {
                const snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'On Snap!',
                    message:
                        'This is an example error message that will be shown in the body of snackbar!',

                    /// change contentType to SnackBarContentType.success, SnackBarContentType.warning or SnackBarContentType.help for variants
                    contentType: SnackBarContentType.failure,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('Show Awesome Material Banner'),
              onPressed: () {
                const materialBanner = MaterialBanner(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  forceActionsBelow: true,
                  content: AwesomeSnackbarContent(
                    title: 'Oh Hey!!',
                    message:
                        'This is an example error message that will be shown in the body of materialBanner!',

                    /// change contentType to SnackBarContentType.success, SnackBarContentType.warning or SnackBarContentType.help for variants
                    contentType: SnackBarContentType.success,
                    // to configure for material banner
                    inMaterialBanner: true,
                  ),
                  actions: [SizedBox.shrink()],
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentMaterialBanner()
                  ..showMaterialBanner(materialBanner);
              },
            ),
          ],
        ),
      ),
    );
  }
}
