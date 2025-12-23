import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/core/utils/formatters.dart';
import 'package:flutter/material.dart';

/// A combined widget to select Date and Time sequentially.
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

  /// Chains DatePicker and TimePicker dialogs.
  /// Updates state only if both are selected successfully.
  Future<void> _handleSetDateTime(BuildContext context) async {

    // 1. Pick Date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (!context.mounted || pickedDate == null) return;

    // 2. Pick Time
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
    );

    if (!context.mounted || pickedTime == null) return;

    // 3. Combine and return 
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

    String formattedDate = Formatters.formatDate(selectedDateTime);
    String formattedTime = Formatters.formatTime(selectedDateTime);

    final TextStyle subduedTextStyle = textTheme.bodyMedium!.copyWith(
      color: colorScheme.onSurfaceVariant
          .withValues(alpha: 0.7),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              vertical: 8.0),

          child: Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                size: 18,
                color: colorScheme.onSurfaceVariant
                    .withValues(alpha: 0.7),
              ),
              const SizedBox(width: 8),
              Text(
                formattedDate,
                style: subduedTextStyle,
              ),

              const SizedBox(width: 12),

              Icon(
                Icons.access_time_outlined,
                size: 18,
                color: colorScheme.onSurfaceVariant
                    .withValues(alpha: 0.7),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  formattedTime,
                  style: subduedTextStyle,
                ),
              ),

              TextButton(
                onPressed: () => _handleSetDateTime(context),
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  minimumSize: Size(0, 36),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  buttonText,
                  style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
