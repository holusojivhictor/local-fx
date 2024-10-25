import 'package:flutter/material.dart';
import 'package:local_fx/src/features/home/presentation/widgets/bullet_list.dart';
import 'package:local_fx/src/localization/generated/l10n.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({required this.explanations, super.key});

  final List<String> explanations;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return AlertDialog(
      title: Text(s.information),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width / 1.5,
          child: BulletList(items: explanations),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(s.ok),
        ),
      ],
    );
  }
}
