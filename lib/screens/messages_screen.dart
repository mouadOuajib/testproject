import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text(
            "Bruno Phan",
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
          ),
          centerTitle: true,
          actions: [
            Image.asset(
              "assets/icons/Setting.png",
              width: 20,
            ),
            const SizedBox(
              width: 15,
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                children: [
                  _buildMessageLeft(
                      context,
                      "Lorem ipsum dolor sit amet consectetur. Nisl id mattis hac quisque sed. Nec massa dui malesuada et urna. Vel ultricies ipsum nec nibh quam habitant eget massa dui. In eu ac curabitur mattis. Neque diam.",
                      "16:04",
                      theme,
                      null),
                  const SizedBox(height: 15),
                  Center(
                    child: Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                        color: const Color(0xff364a60),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          "Today",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildMessageLeft(
                      context, null, "16:04", theme, "assets/images/image.png"),
                  const SizedBox(height: 10),
                  _buildMessageRight(
                      context,
                      "Lorem ipsum dolor sit amet consectetur. Sed cursus nec lectus aliquam ut diam aenean.",
                      "12:02",
                      theme,
                      null),
                ],
              ),
            ),
            _buildMessageInputArea(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageLeft(BuildContext context, String? message, String time,
      final theme, String? image) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage("assets/images/image.png"),
          radius: 20,
        ),
        const SizedBox(width: 10),
        (image != null && message == null)
            ? Container(
                height: 240,
                width: 220,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: theme.secondary,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          time,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : Expanded(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: theme.secondary,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (message != null) Text(message),
                      if (image != null)
                        Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: AssetImage(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Spacer(),
                          Text(
                            time,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 10),
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

  Widget _buildMessageRight(BuildContext context, String? message, String time,
      final theme, String? image) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (message != null || image != null)
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: theme.secondary,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (message != null) Text(message, textAlign: TextAlign.end),
                  if (image != null)
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        time,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(width: 10),
        const CircleAvatar(
          backgroundImage: AssetImage("assets/images/image.png"),
          radius: 20,
        ),
      ],
    );
  }

  Widget _buildMessageInputArea(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: Colors.white,
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: Image.asset(
              "assets/icons/image.png",
              width: 20,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Type a message",
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Image.asset(
              "assets/icons/bxs_send.png",
              width: 20,
            ),
          ),
        ],
      ),
    );
  }
}
