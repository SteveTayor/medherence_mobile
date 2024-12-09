import 'package:flutter/material.dart';

class AvatarSelectionOverlay extends StatelessWidget {
  final Function(String) onAvatarSelected;

  const AvatarSelectionOverlay({required this.onAvatarSelected, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: 30, // Number of avatar images
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          final String avatar = 'assets/images/avatars/avatar_${index + 1}.png';
          return GestureDetector(
            onTap: () {
              onAvatarSelected(avatar);
              Navigator.pop(context);
            },
            child: Image.asset(
              avatar,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
