import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppDialog extends StatefulWidget {
  const AppDialog({
    super.key,
    required this.title,
    required this.content,
    this.onBackMethod,
  });

  final String title;
  final Widget content;
  final Function? onBackMethod;

  @override
  State<AppDialog> createState() => _AppDialogState();
}

class _AppDialogState extends State<AppDialog> {

  final scaffoldKey = GlobalKey();
  final scrollViewKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose(); // Important: Dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.lightAngleLeft, color: Theme.of(context).colorScheme.primary,),
          onPressed: () {
            if(widget.onBackMethod != null) {
              widget.onBackMethod!();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
            IconButton(
              icon: Icon(FontAwesomeIcons.lightXmark, color: Theme.of(context).colorScheme.primary),
              onPressed: () {
                if(widget.onBackMethod != null) {
                  widget.onBackMethod!();
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: widget.content,
      ),
    );
  }
}
