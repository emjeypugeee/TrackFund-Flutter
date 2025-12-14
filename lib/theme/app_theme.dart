import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    // 1. Correct Brightness ensures Status Bar icons are visible
    brightness: Brightness.light, 
    
    // 2. Set the actual background of the screens
    scaffoldBackgroundColor: Colors.white, 
    
    colorScheme: const ColorScheme.light(
      primary: Colors.blue, // Keep primary for buttons/brand
      
      // 3. 'surface' is for Cards/Sheets, usually same or slightly different from background
      surface: Colors.white, 
      
      // 4. 'onSurface' is the default color for TEXT
      onSurface: Colors.black, 
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    
    // Dark background
    scaffoldBackgroundColor: const Color(0xFF1E1E1E), 
    
    colorScheme: const ColorScheme.dark(
      primary: Colors.blueAccent, // Lighter blue for dark mode
      
      surface: Color(0xFF1E1E1E),
      
      // Text color for Dark Mode
      onSurface: Colors.white, 
    ),
  );
}