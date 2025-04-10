import 'package:flutter/material.dart';

class TaskListItem extends StatelessWidget {
  final String title;
  final String description;
  final List<String> userAvatars; 
  final VoidCallback onStatusChange;
  final String statusText;

  const TaskListItem({
    super.key,
    required this.title,
    required this.description,
    required this.userAvatars,
    required this.onStatusChange,
    required this.statusText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(description,
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 40),
                SizedBox(
                  height: 32,
                  width: (userAvatars.length * 20.0) + 16,
                  child: Stack(
                    children: userAvatars.asMap().entries.map((entry) {
                      final index = entry.key;
                      final avatar = entry.value;
                      return Positioned(
                        left: index * 20.0,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(avatar),
                          backgroundColor: Colors.grey[200],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onStatusChange,
            child: Text(statusText),
          ),
        ],
      ),
    );
  }
}
