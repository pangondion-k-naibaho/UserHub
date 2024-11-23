import 'package:flutter/material.dart';
import 'package:userhub/ui/themes/AppBackgrounds.dart';
import 'package:userhub/ui/themes/AppColors.dart';

enum InputType { REGULAR, EMAIL, PASSWORD, MULTILINE }

class InputTextView extends StatefulWidget {
  final String title;
  final InputType inputType;
  final String? hintText;
  final Function()? onRevealClick;
  final TextEditingController? controller;
  final String? errorText;

  const InputTextView({
    Key? key,
    required this.title,
    this.inputType = InputType.REGULAR,
    this.hintText = null,
    this.onRevealClick,
    this.controller,
    this.errorText,
  }) : super(key: key);

  @override
  _InputTextViewState createState() => _InputTextViewState();
}

class _InputTextViewState extends State<InputTextView> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.inputType == InputType.PASSWORD;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'InterMedium',
              color: Color(0xFF1C1C1E), // black_river_falls
            ),
          ),
          const SizedBox(height: 10),
          // Input Container
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: AppBackgrounds.rectangleSatinWhite,
            child: Row(
              children: [
                // Input Field
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    obscureText: isPassword && !isPasswordVisible,
                    maxLines: widget.inputType == InputType.MULTILINE ? 6 : 1,
                    minLines: widget.inputType == InputType.MULTILINE ? 3 : 1,
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.astrochopusGrey, // astrochopus_grey
                    ),
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle: const TextStyle(
                        color: AppColors.flintstone, // flintstone
                      ),
                      border: InputBorder.none,
                      prefixIcon: widget.inputType == InputType.EMAIL ? const Icon(Icons.email, size: 20, color: AppColors.grey)
                          : widget.inputType == InputType.PASSWORD ? const Icon(Icons.lock, size: 20, color: AppColors.grey,)
                          : null,
                    ),
                  ),
                ),
                // Reveal Button (for Password)
                if (isPassword)
                  IconButton(
                    icon: Icon(
                      isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      size: 20,
                      color: AppColors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                      if (widget.onRevealClick != null) {
                        widget.onRevealClick!();
                      }
                    },
                  ),
              ],
            ),
          ),
          // Error Message
          if (widget.errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                widget.errorText!,
                style: const TextStyle(
                  color: AppColors.red,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
