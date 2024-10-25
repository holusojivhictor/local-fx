import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ChangeTag extends StatelessWidget {
  const ChangeTag({required this.change, super.key});

  final double change;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Skeleton.leaf(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: change.isNegative
              ? const Color.fromRGBO(208, 79, 91, 1)
              : const Color.fromRGBO(94, 186, 137, 1),
        ),
        child: Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(text: change.isNegative ? '-' : '+'),
              TextSpan(text: change.toStringAsFixed(2)),
              const TextSpan(text: '%'),
            ],
          ),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
