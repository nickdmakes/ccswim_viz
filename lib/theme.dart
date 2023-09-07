import 'package:flutter/material.dart';

final neutral = <Color>[
  const Color(0xFFE8EFF2),
  const Color(0xFFC8D7DF),
  const Color(0xFFA7C0CD),
  const Color(0xFF78909C),
  const Color(0xFF4B636E),
  const Color(0xFF364850),
  const Color(0xFF222C31),
];

final primary = <Color>[
  const Color(0xFFE4F5FB),
  const Color(0xFF78C4E6),
  const Color(0xFF61ABDB),
  const Color(0xFF518AB9),
  const Color(0xFF3D5A80), // Primary
];

final secondary = <Color>[
  const Color(0xFFF7E8E7),
  const Color(0xFFF3A895),
  const Color(0xFFEE6D4D), // Secondary
  const Color(0xFFE24F2E),
  const Color(0xFFC54325),
];

final success = <Color>[
  const Color(0xFFE3F4EE),
  const Color(0xFF6DBF9D),
  const Color(0xFF84C888),
  const Color(0xFF48A14C), // Success
  const Color(0xFF225F26),
];

final warning = <Color>[
  const Color(0xFFFEF7E1),
  const Color(0xFFFBDD81),
  const Color(0xFFF8C628), // Warning
  const Color(0xFFF79C00),
  const Color(0xFFF66D00),
];

final error = <Color>[
  const Color(0xFFFEEBEE),
  const Color(0xFFED9C9B),
  const Color(0xFFF14938),
  const Color(0xFFD03631), // Error
  const Color(0xFFB4261F),
];

final theme = ThemeData(
  primaryColor: primary[4],
  scaffoldBackgroundColor: neutral[0],
  colorScheme: ColorScheme.light(
    primary: primary[4],
    onPrimary: neutral[0],
    primaryContainer: primary[1],
    onPrimaryContainer: primary[4],
    secondary: secondary[2],
    onSecondary: neutral[0],
    secondaryContainer: secondary[0],
    onSecondaryContainer: secondary[2],
    tertiary: success[3],
    onTertiary: neutral[0],
    tertiaryContainer: success[0],
    onTertiaryContainer: success[4],
    error: error[3],
    onError: neutral[1],
    shadow: neutral[6],
    background: neutral[0],
    onBackground: neutral[6],
  ),
);
