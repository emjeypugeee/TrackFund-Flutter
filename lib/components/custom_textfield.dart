import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextfield extends StatefulWidget {
  final String hintText;
  final IconData? icon;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool isPassword;
  final String? Function(String?)? validator;

  const CustomTextfield({
    super.key,
    required this.hintText,
    this.icon,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.isPassword = false,
    this.validator,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    // 1. Get Theme Data
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // 2. Define colors based on mode
    // Light Mode: Light Grey Fill | Dark Mode: Dark Grey Fill
    final fillColor = isDark ? Colors.grey.shade900 : Colors.grey.shade200;

    // Icons should be visible against the fill color (Dark Icon on Light, Light Icon on Dark)
    final iconColor = colors.onSurface.withValues(alpha: 0.6);

    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      obscureText: widget.isPassword ? _obscureText : false,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,

      // 3. Ensure the text user types matches the theme (White in dark mode)
      style: TextStyle(color: colors.onSurface, fontWeight: FontWeight.w500),

      decoration: InputDecoration(
        hintText: widget.hintText,

        // 4. Hint Text should be subtle (opacity 0.5)
        hintStyle: TextStyle(
          color: colors.onSurface.withValues(alpha: 0.5),
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),

        filled: true,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),

        suffixIcon:
            widget.isPassword
                ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: iconColor,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
                : (widget.icon != null ? Icon(widget.icon, color: iconColor, size: 20) : null),

        // 5. Borders
        // Standard Border (No line, just the fill color)
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        // Focused Border (Add a subtle outline or change color)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          // Optional: Add a subtle border color when focused
          borderSide: isDark ? BorderSide(color: colors.primary, width: 1.5) : BorderSide.none,
        ),

        // 6. Error Borders (Use Theme Error Color)
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: colors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: colors.error, width: 1.5),
        ),
      ),
    );
  }
}
