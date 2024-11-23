import 'package:flutter/material.dart';
import '../themes/AppBackgrounds.dart';
import '../themes/AppColors.dart';

class InputSearchView extends StatefulWidget {
  final Function()? onSearch;
  final Function()? onClear;
  final String? hintText;

  const InputSearchView({
    Key? key,
    this.onSearch,
    this.onClear,
    this.hintText,
  }) : super(key: key);

  @override
  State<InputSearchView> createState() => _InputSearchViewState();
}

class _InputSearchViewState extends State<InputSearchView> {
  final TextEditingController _controller = TextEditingController();
  bool _isTextNotEmpty = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isTextNotEmpty = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppBackgrounds.circularRectangleWhiteGrey,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          // Search Text Field
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: widget.hintText ?? "Search...",
                border: InputBorder.none,
                hintStyle: const TextStyle(color: AppColors.grey),
              ),
              style: const TextStyle(color: AppColors.black),
            ),
          ),

          // Clear Icon
          if (_isTextNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear, color: AppColors.grey),
              onPressed: () {
                _controller.clear();
                if (widget.onClear != null) {
                  widget.onClear!();
                }
              },
            ),

          // Search Icon
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.grey),
            onPressed: widget.onSearch,
          ),
        ],
      ),
    );
  }
}
