import 'package:flutter/material.dart';

class TaskCounterCard extends StatelessWidget {
  final int taskCount;

  const TaskCounterCard({super.key, required this.taskCount});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardColor = isDark
        ? const Color.fromARGB(255, 21, 21, 21)
        : const Color.fromARGB(255, 240, 227, 242);
    final borderColor = isDark
        ? Colors.purple.shade700
        : Colors.purple.shade200;
    final shadowColor = isDark
        ? Colors.purple.shade900.withValues(alpha: 0.4)
        : Colors.purple.withValues(alpha: 0.4);
    final textColor = isDark ? Colors.purple.shade200 : Colors.grey.shade800;
    final circleGradient = isDark
        ? LinearGradient(
            colors: [Colors.purple.shade900, Colors.purple.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : LinearGradient(
            colors: [Colors.purple.shade700, Colors.purple.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: borderColor, width: 1),
        ),
        elevation: 6,
        shadowColor: shadowColor,
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: circleGradient,
                  boxShadow: [
                    BoxShadow(
                      color: borderColor.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  "$taskCount",
                  style: const TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  "Anzahl der offenen Tasks",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
