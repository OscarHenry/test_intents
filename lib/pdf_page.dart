import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

const String assetPdfDummy = 'assets/Report.pdf';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  late Uri? uri;
  late final PdfViewerController controller;

  @override
  void initState() {
    uri = null;
    controller = PdfViewerController();
    super.initState();
  }

  @override
  void dispose() {
    // controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Page'),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: /*uri == null
            ? const EmptyWidget()
            : */
            SingleChildScrollView(
          child: PdfViewer.asset(
            assetPdfDummy,
            // controller: controller,
            // params: PdfViewerParams(
            //   linkHandlerParams: PdfLinkHandlerParams(
            //     onLinkTap: (link) async {
            //       // handle URL or Dest
            //       if (link.url != null) {
            //         // TODO: implement your own isSecureUrl by yourself...
            //         //   if (await isSecureUrl(link.url!)) {
            //         // launchUrl(link.url!);
            //         // }
            //       } else if (link.dest != null) {
            //         controller.goToDest(link.dest);
            //       }
            //     },
            //   ),
            // ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.small(
      //   onPressed: () async {
      //     // open pdf
      //     final uriOrNull = await showDialog(
      //       context: context,
      //       builder: (dCtx) => const PdfDialog(),
      //     );
      //
      //     if (uriOrNull != null) {
      //       setState(() {
      //         uri = uriOrNull;
      //       });
      //     }
      //   },
      //   child: const Icon(Icons.picture_as_pdf_outlined),
      // ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Uri is empty'),
    );
  }
}

class PdfDialog extends StatefulWidget {
  const PdfDialog({super.key});

  @override
  State<PdfDialog> createState() => _PdfDialogState();
}

class _PdfDialogState extends State<PdfDialog> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: assetPdfDummy);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Enter PDF URL'),
      titlePadding: const EdgeInsets.only(left: 24, right: 24, top: 24),
      contentPadding: const EdgeInsets.all(24),
      children: [
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'PDF URL',
            hintText: 'https://example.com/file.pdf',
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  final uri = Uri.tryParse(controller.text);
                  if (uri == null) {
                    // show snackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid URL')),
                    );
                    return;
                  }

                  Navigator.pop(context, uri);
                },
                child: const Text('Accept'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
