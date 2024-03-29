import 'dart:ui';

import 'package:flutter/material.dart';

class Creator {
  final String creatorName;
  final String creatorImageUrl;
  final String followerCount;
  final bool isBeingFollowed;
  final bool isBeingNotified;

  const Creator({
    required this.creatorName,
    required this.creatorImageUrl,
    required this.followerCount,
    required this.isBeingFollowed,
    required this.isBeingNotified,
  });
}

class CreatorProfile extends StatelessWidget {
  const CreatorProfile({
    super.key,
    required this.creator,
    required this.onPressedFollow,
    required this.onPressedGetNotified,
  });

  final Creator creator;
  final void Function() onPressedFollow;
  final void Function() onPressedGetNotified;

  @override
  Widget build(BuildContext context) {
    var backgroundColor =
        (const HSLColor.fromAHSL(1.0, 206.5, .607, .89)).toColor();

    return Container(
      color: backgroundColor,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: 550,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  creator.creatorImageUrl,
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                ),
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 70, sigmaY: 60),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(height: 120),
                    CircleAvatar(
                      radius: 75,
                      backgroundImage: NetworkImage(
                        creator.creatorImageUrl,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      creator.creatorName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      creator.followerCount,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FollowButton(
                          onPressed: onPressedFollow,
                          isActive: creator.isBeingFollowed,
                        ),
                        NotificationButton(
                          isVisible: creator.isBeingFollowed,
                          isActive: creator.isBeingNotified,
                          onPressed: onPressedGetNotified,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Text(
                'Latest from ${creator.creatorName}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class NotificationButton extends StatelessWidget {
  NotificationButton({
    super.key,
    required this.isVisible,
    required this.isActive,
    required this.onPressed,
  }) {
    buttonBackgroundColor = isActive ? Colors.white : Colors.transparent;
    textColor = isActive ? Colors.black87 : Colors.white;
    icon =
        isActive ? Icons.notifications_active : Icons.notification_add_outlined;
  }

  final bool isVisible;
  final bool isActive;
  final Function onPressed;
  late final Color buttonBackgroundColor;
  late final Color textColor;
  late final IconData icon;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) {
      return Container();
    }

    return OutlinedButton(
      onPressed: () {
        onPressed();
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: buttonBackgroundColor,
        shape: const CircleBorder(),
        side: const BorderSide(
          color: Colors.white,
          width: 0.5,
          style: BorderStyle.solid,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: textColor,
          size: 30,
        ),
      ),
    );
  }
}

class FollowButton extends StatelessWidget {
  FollowButton({
    super.key,
    required this.isActive,
    required this.onPressed,
  }) {
    buttonBackgroundColor = isActive ? Colors.white : Colors.transparent;
    buttonText = isActive ? 'Following' : 'Follow';
    textColor = isActive ? Colors.black87 : Colors.white;
  }

  final bool isActive;
  final void Function() onPressed;
  late final Color buttonBackgroundColor;
  late final String buttonText;
  late final Color textColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: buttonBackgroundColor,
        side: const BorderSide(
          color: Colors.white,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          buttonText.toUpperCase(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
