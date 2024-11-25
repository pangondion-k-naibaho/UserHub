import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../themes/AppColors.dart';

class UserItem extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String email;
  final bool isLast;
  final VoidCallback onClick;

  const UserItem({
    Key? key,
    required this.avatarUrl,
    required this.name,
    required this.email,
    required this.isLast,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar image in circle
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.grey,
                  backgroundImage: CachedNetworkImageProvider(avatarUrl),
                ),
                const SizedBox(width: 16),
                // User details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.bubbleBobbleP2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (!isLast)
              const Divider(
                color: AppColors.grey,
                thickness: 1,
                height: 16,
              ),
          ],
        ),
      ),
    );
  }
}