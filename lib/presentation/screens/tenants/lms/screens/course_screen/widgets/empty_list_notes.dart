import 'package:belluga_boilerplate/application/fonts/belluga_learning_icons.dart';
import 'package:flutter/material.dart';

class EmptyListNotes extends StatelessWidget {
  const EmptyListNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            height: 200,
            child: Column(
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text("Clique em", textAlign: TextAlign.center),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        color: Theme.of(context).colorScheme.onSecondary,
                        size: 16,
                        BellugaLearning.sticky_note,
                      ),
                    ),
                    Text(
                      "para criar sua primeira anotação.",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
