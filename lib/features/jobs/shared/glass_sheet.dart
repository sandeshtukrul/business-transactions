import 'dart:ui';
import 'package:business_transactions/config/glass_theme.dart';
import 'package:flutter/material.dart';

// --- 1. THE MAIN GLASS CONTAINER ---
class GlassSheetWrapper extends StatelessWidget {
  final ScrollController? scrollController;
  final List<Widget> children; // Changed back to List<Widget>

  const GlassSheetWrapper({
    super.key,
    this.scrollController,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final sheetColor = theme.colorScheme.surface.withValues(alpha: 0.90);
    final borderColor = isDark ? GlassColors.glassBorderDark : GlassColors.glassBorderLight;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: sheetColor,
            border: Border(top: BorderSide(color: borderColor, width: 1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 30,
                offset: const Offset(0, -10),
              )
            ],
          ),
          child: Column(
            children: [
              // Standard Drag Handle
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: GlassColors.textSubtle.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Content (Spread the children list here)
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}

// ... (Keep GlassSheetSearchBar, GlassCreateTile, and GlassItemTile as they were) ...
// Below is the code for them again just in case you need the full file context:

// --- 2. SEARCH BAR ---
class GlassSheetSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final bool textCapitalization;
  final EdgeInsetsGeometry padding;

  const GlassSheetSearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
    required this.onClear,
    this.textCapitalization = false,
    this.padding = const EdgeInsets.fromLTRB(20, 0, 20, 16),
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? GlassColors.glassBorderDark : GlassColors.glassBorderLight;
    final subTextColor = GlassColors.textSubtle;
    final inputFillColor = isDark ? GlassColors.glassPanelDark : Colors.grey.withValues(alpha: 0.05);

    return Padding(
      padding: padding,
      child: TextField(
        controller: controller,
        style: TextStyle(
          color: isDark ? GlassColors.textLight : GlassColors.textDark, 
          fontSize: 16
        ),
        textCapitalization: textCapitalization ? TextCapitalization.characters : TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: subTextColor),
          prefixIcon: Icon(Icons.search, color: subTextColor),
          filled: true,
          fillColor: inputFillColor,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: borderColor)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(icon: Icon(Icons.clear, size: 20, color: subTextColor), onPressed: onClear)
              : null,
        ),
        onChanged: onChanged,
      ),
    );
  }
}

// --- 3. CREATE NEW TILE ---
class GlassCreateTile extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const GlassCreateTile({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
        child: Icon(Icons.add, color: theme.colorScheme.primary),
      ),
      title: Text(
        label,
        style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      onTap: onTap,
    );
  }
}

// --- 4. ITEM TILE ---
class GlassItemTile extends StatelessWidget {
  final Widget leadingIcon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isSubtitleItalic;

  const GlassItemTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isSubtitleItalic = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mainTextColor = isDark ? GlassColors.textLight : GlassColors.textDark;
    
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: leadingIcon,
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, color: mainTextColor, fontSize: 16),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: GlassColors.textSubtle.withValues(alpha: isSubtitleItalic ? 0.5 : 1.0),
          fontStyle: isSubtitleItalic ? FontStyle.italic : FontStyle.normal,
        ),
      ),
      onTap: onTap,
    );
  }
}