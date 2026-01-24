import 'dart:ui';

import 'package:business_transactions/config/app_text_styles.dart';
import 'package:flutter/material.dart';

class AddJobHeader extends StatelessWidget {
  const AddJobHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
        
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: Colors.transparent, // Semi-transparent background
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 8, // Safe Area Top + Padding
            bottom: 12,
            left: 8,
            right: 8
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Back Button
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_ios_new, size: 20, color: theme.colorScheme.onSurface),
                  tooltip: 'Back',
                ),
              ),
              // Title
              Text(
                "Create New Job",
                style: AppTextStyles.sectionHeader.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}