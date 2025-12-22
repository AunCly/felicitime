import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppDateInput extends StatefulWidget {
  const AppDateInput({
    super.key,
    required this.label,
    required this.dateEditingController,
    required this.realDateEditingController,
    this.error = false,
    this.onUpdate,
  });

  final Function? onUpdate;
  final String label;
  final TextEditingController dateEditingController;
  final TextEditingController realDateEditingController;
  final bool error;

  @override
  State<AppDateInput> createState() => _AppDateInputState();
}

class _AppDateInputState extends State<AppDateInput> {

  _showDateCalendar(BuildContext context, date){
    showDatePicker(
      locale: const Locale('fr', 'FR'),
      context: context,
      initialDate: DateTime.parse(date),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        widget.dateEditingController.text = value.toString().substring(0, 10).split('-').reversed.join('/');
        widget.realDateEditingController.text = value.toString();
        if(widget.onUpdate != null){
          widget.onUpdate!(value.toString());
        }
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDateCalendar(context, widget.realDateEditingController.text == '' ? DateTime.now().toString() : widget.realDateEditingController.text),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: widget.error ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.surface, width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(FontAwesomeIcons.lightCalendar, color: Theme.of(context).colorScheme.primary, size: 20),
            ),
            Container(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.realDateEditingController.text != '' ? Text('Date : ', style: Theme.of(context).textTheme.bodyLarge) : const SizedBox(),
                widget.realDateEditingController.text == '' ? Text(widget.label ?? 'Choisir une date', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: widget.error ? Theme.of(context).colorScheme.error : null)) : Text(widget.dateEditingController.text, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
