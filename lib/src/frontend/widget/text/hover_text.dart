import 'package:benji_user/src/frontend/widget/clickable.dart';
import 'package:flutter/material.dart';

class HoverColorText extends StatefulWidget {
  final bool active;
  final bool noHover;
  final String text;
  final TextStyle style;
  final Color defaultColor;
  final Color hoverColor;
  final Function()? onTap;
  final Widget? navigate;

  const HoverColorText({
    super.key,
    required this.text,
    required this.style,
    this.defaultColor = Colors.black,
    this.hoverColor = Colors.red,
    this.active = false,
    this.noHover = false,
    this.onTap,
    this.navigate,
  });

  @override
  State<HoverColorText> createState() => _HoverColorTextState();
}

class _HoverColorTextState extends State<HoverColorText> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        if (!widget.noHover) {
          setState(() {
            _isHovered = true;
          });
        }
      },
      onExit: (_) {
        if (!widget.noHover) {
          setState(() {
            _isHovered = false;
          });
        }
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: MyClickable(
          navigate: widget.navigate,
          child: Text(
            widget.text,
            style: widget.style.copyWith(
              color: _isHovered | widget.active
                  ? widget.hoverColor
                  : widget.defaultColor,
            ),
          ),
        ),
      ),
    );
  }
}
