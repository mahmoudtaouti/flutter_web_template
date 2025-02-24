import 'package:flutter/material.dart';


class UserAvatar extends StatefulWidget {
  const UserAvatar({
    super.key,
    required this.name,
    required this.imageSrc,
    this.onPressed,
  });

  final String name, imageSrc;
  final VoidCallback? onPressed;

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    return InkWell(
      onTap: widget.onPressed,
      onHover: (value) {
        setState(() {
          isHovered = value;
        });
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(widget.imageSrc),
          ),
          const SizedBox(height: 8,),
          Text(
            widget.name,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: isHovered ? theme.primaryColor : null),
          )
        ],
      ),
    );
  }
}


class RoundedAvatar extends StatelessWidget {
  const RoundedAvatar({
    super.key,
    this.height = 54,
    this.width = 54,
    this.radius = 12,
    required this.imageSrc,
  });

  final double height, width, radius;
  final String imageSrc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        image: DecorationImage(
          image: NetworkImage(imageSrc),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
