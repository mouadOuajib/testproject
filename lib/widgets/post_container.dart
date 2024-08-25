import 'package:flutter/material.dart';

class PostContainer extends StatelessWidget {
  final String avatar;
  final String author;
  final bool isAuthorVerified;
  final String topicName;
  final String date;
  final String description;
  final String? postImage;
  final bool saveEnable;

  const PostContainer({
    super.key,
    required this.avatar,
    required this.author,
    required this.isAuthorVerified,
    required this.topicName,
    required this.date,
    required this.description,
    required this.postImage,
    required this.saveEnable,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: theme.secondary),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(avatar),
                        radius: 30,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                author,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              if (isAuthorVerified)
                                Image.asset(
                                  'assets/icons/verify.png',
                                  width: 15,
                                ),
                              const SizedBox(width: 5),
                              const Text(
                                ".",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                date,
                              ),
                            ],
                          ),
                          Text(topicName)
                        ],
                      ),
                      const Spacer(),
                      Image.asset("assets/icons/more.png")
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    description,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            if (postImage != null)
              Image.asset(
                postImage!,
                width: double.maxFinite,
              ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/heart.png",
                    width: 20,
                    color: theme.onSurface,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "assets/icons/comment.png",
                    width: 20,
                    color: theme.onSurface,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "assets/icons/send.png",
                    width: 20,
                    color: theme.onSurface,
                  ),
                  const Spacer(),
                  if (saveEnable)
                    Image.asset(
                      "assets/icons/save.png",
                      width: 20,
                      color: theme.onSurface,
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
