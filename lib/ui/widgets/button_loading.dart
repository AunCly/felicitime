import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:felicitime/config/colors.dart';

class AppLoadingButton extends StatefulWidget {
  final Function? onPressed;
  final String? label;
  final Color? color;
  final IconData? icon;
  final AsyncValue state;
  final bool disabled;

  const AppLoadingButton({
    super.key,
    this.onPressed,
    required this.state,
    this.label,
    this.color,
    this.icon,
    this.disabled = false,
  });

  @override
  State<AppLoadingButton> createState() => _AppLoadingButtonState();
}

class _AppLoadingButtonState extends State<AppLoadingButton> {

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
      onPressed: widget.disabled ? null : () {
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      child: widget.state.isLoading ? const SizedBox(width: 15, height: 15, child: CircularProgressIndicator(color: AppColors.appWhite, strokeWidth: 2,)) : Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.disabled ? FontAwesomeIcons.lightAlarmClock : widget.icon, size: 15, color : Theme.of(context).colorScheme.onPrimary),
          if(widget.label != null) const SizedBox(width: 10),
          if(widget.label != null) Text(widget.label!, style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.onPrimary)),
        ]
      )
    );
  }
}
