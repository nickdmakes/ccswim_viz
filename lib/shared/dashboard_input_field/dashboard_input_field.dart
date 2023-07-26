import 'package:flutter/material.dart';

import 'package:ccswim_viz/theme.dart';

class DashboardInputField extends StatefulWidget {
  const DashboardInputField({
    this.onSubmitted,
    this.onChanged,
    this.placeholder,
    this.errorText,
    this.keyboardType,
    super.key,
  });

  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final String? placeholder;
  final String? errorText;
  final TextInputType? keyboardType;

  @override
  State<DashboardInputField> createState() => _DashboardInputFieldState();
}

class _DashboardInputFieldState extends State<DashboardInputField> {

  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const borderRadius = 4.0;

    return TextField(
      controller: _textController,
      onSubmitted: widget.onSubmitted,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      style: TextStyle(color: neutral[4], fontSize: 14.0),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16.0),
        suffixIcon: _textController.text.isEmpty
          ? null
          : IconButton(
          onPressed: () {
            setState(() {_textController.text = '';});
            if(widget.onChanged != null) {
              widget.onChanged!('');
            }
          },
          icon: const Icon(Icons.clear, size: 14),
          splashRadius: 10,
        ),
        isCollapsed: true,
        hintText: widget.placeholder,
        hintStyle: TextStyle(color: neutral[2]),
        helperText: ' ',
        helperStyle: const TextStyle(fontSize: 0),
        errorText: widget.errorText,
        errorStyle: const TextStyle(fontSize: 0),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: BorderSide(width: 1.5, color: primary[3])
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: BorderSide(width: 1.0, color: neutral[2]),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: BorderSide(width: 1.0, color: error[3]),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: BorderSide(width: 1.5, color: error[4]),
        ),
      ),
    );
  }
}
