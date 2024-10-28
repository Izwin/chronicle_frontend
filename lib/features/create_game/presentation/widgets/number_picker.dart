import 'package:chronicle/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class NumberPicker extends StatefulWidget {
  final int from;
  final int to;
  final Function(int) onNumberChanged;

  const NumberPicker(
      {super.key,
      required this.from,
      required this.to,
      required this.onNumberChanged});

  @override
  State<NumberPicker> createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPicker> {
  int? selectedNumber;

  @override
  void initState() {
    super.initState();
    selectedNumber = widget.from;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: widget.to - widget.from + 1,
        itemBuilder: (context, index) {
          return ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedNumber = widget.from + index;
                });
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: EdgeInsets.zero,
                backgroundColor: widget.from + index == selectedNumber
                    ? AppColors.primary
                    : AppColors.surface,
                foregroundColor: widget.from + index == selectedNumber
                    ? AppColors.surface
                    : AppColors.textColor,
              ),
              child: Text('${widget.from + index}'));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 2,
          );
        },
      ),
    );
  }
}
