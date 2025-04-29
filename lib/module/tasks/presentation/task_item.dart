import 'package:assignment2_mobileapp_prototype/core/app_color.dart';
import 'package:assignment2_mobileapp_prototype/core/app_utils.dart';
import 'package:flutter/material.dart';

class TaskListItem extends StatelessWidget {
  final String title;
  final String description;
  final List<String> userAvatars;
  final VoidCallback? onStatusChange;
  final String statusText;
  final String startDatetime;
  final String endDatetime;
  final String location;
  final String role;
  final bool isLoading;

  const TaskListItem({
    super.key,
    required this.title,
    required this.description,
    required this.userAvatars,
    required this.onStatusChange,
    required this.statusText,
    required this.startDatetime,
    required this.endDatetime,
    required this.location,
    required this.role,
    required this.isLoading,
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
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 18, color: AppColor.primary),
                    const SizedBox(width: 4),
                    Text(
                      AppUtils.formatDateRange(startDatetime, endDatetime),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 18, color: AppColor.primary),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                    Visibility(
                      visible: _buttonVisibility(),
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _getOnTap(),
                        child: isLoading
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Text(statusText),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  VoidCallback? _getOnTap() {
    if (role == 'Student' &&
        (statusText == 'Rewarded' ||
            statusText == 'Completed' ||
            statusText == 'Validated')) {
      return () {};
    } else {
      if (statusText.isEmpty) {
        return () {};
      }
    }
    return onStatusChange;
  }

  bool _buttonVisibility() {
    if (role != 'Student' && statusText.isEmpty) {
      return false;
    }

    return true;
  }
}
