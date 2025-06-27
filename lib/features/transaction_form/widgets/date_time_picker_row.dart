import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/core/utils/formatters.dart';
import 'package:flutter/material.dart';

class DateTimePickerRow extends StatelessWidget {
  final DateTime selectedDateTime;
  final ValueChanged<DateTime> onDateTimeChanged;
  final String buttonText;

  const DateTimePickerRow({
    super.key,
    required this.selectedDateTime,
    required this.onDateTimeChanged,
    this.buttonText = setButton,
  });

  Future<void> _handleSetDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (!context.mounted || pickedDate == null) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
    );

    if (!context.mounted || pickedTime == null) return;

    onDateTimeChanged(DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Format date and time parts separately
    String formattedDate = Formatters.formatDate(selectedDateTime);
    String formattedTime = Formatters.formatTime(selectedDateTime);

    // Style for the less emphasized date/time text
    final TextStyle subduedTextStyle = textTheme.bodyMedium!.copyWith(
      // Using bodyMedium for slightly smaller/less prominent
      color: colorScheme.onSurfaceVariant
          .withValues(alpha: 0.7), // More muted color
    );

    return Column(
      // Kept the Column in case you want to add a label above it later
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              vertical: 8.0), // Added some vertical padding for the container

          child: Row(
            children: [
              // Date part
              Icon(
                Icons.calendar_month_outlined,
                size: 18, // Slightly smaller icon
                color: colorScheme.onSurfaceVariant
                    .withValues(alpha: 0.7), // Muted icon color
              ),
              const SizedBox(width: 8),
              Text(
                formattedDate,
                style: subduedTextStyle,
              ),

              const SizedBox(width: 12), // Spacer between date and time

              // Time part
              Icon(
                Icons.access_time_outlined, // Clock icon
                size: 18, // Slightly smaller icon
                color: colorScheme.onSurfaceVariant
                    .withValues(alpha: 0.7), // Muted icon color
              ),
              const SizedBox(width: 8),
              Expanded(
                // Allow time to expand before the button
                child: Text(
                  formattedTime,
                  style: subduedTextStyle,
                ),
              ),

              // "Set" Button
              TextButton(
                onPressed: () => _handleSetDateTime(context),
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  minimumSize: Size(0, 36), // Ensure decent tap height
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  // visualDensity: VisualDensity.compact, // Already compact due to padding
                ),
                child: Text(
                  buttonText,
                  style: textTheme.labelLarge?.copyWith(
                      // Use labelLarge for button text
                      color: colorScheme.primary, // Keep button text prominent
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
