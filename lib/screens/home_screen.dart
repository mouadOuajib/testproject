import 'package:flutter/material.dart';
import 'package:testproject/widgets/post_container.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback showBottomSheet;

  const HomeScreen({super.key, required this.showBottomSheet});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> postExample = [
      {
        "avatar": "assets/images/image.png",
        "author": "James",
        "isAuthorVerified": true,
        "date": "1 hour ago",
        "topicName": "Topic Name",
        "description":
            "Lorem ipsum dolor sit amet consectetur. Sagittis diam auctor convallis.",
        "postImage": null,
        "enableSave": false
      },
      {
        "avatar": "assets/images/image.png",
        "author": "James",
        "isAuthorVerified": true,
        "date": "1 hour ago",
        "topicName": "Topic Name",
        "description":
            "Lorem ipsum dolor sit amet consectetur. Sagittis diam auctor convallis justo pellentesque in eu amet sapien.",
        "postImage": "assets/images/image.png",
        "enableSave": true
      },
    ];
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      InkWell(
                        onTap: showBottomSheet,
                        child: Image.asset(
                          "assets/icons/notification.png",
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                TabBar(
                  unselectedLabelColor: theme.onSurface,
                  labelColor: theme.primary,
                  dividerHeight: 0,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: theme.primary,
                    ),
                    insets: EdgeInsets.symmetric(
                        horizontal: size.width * 0.35, vertical: -10),
                  ),
                  tabs: const [
                    Text("Public Feed"),
                    Text("Business Feed"),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Feeds",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showBottomSheet();
                        },
                        child: Image.asset(
                          "assets/icons/filter.png",
                          width: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height,
                  child: TabBarView(
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: postExample.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: PostContainer(
                              avatar: postExample[index]["avatar"],
                              author: postExample[index]["author"],
                              isAuthorVerified: postExample[index]
                                  ["isAuthorVerified"],
                              date: postExample[index]["date"],
                              topicName: postExample[index]["topicName"],
                              description: postExample[index]["description"],
                              postImage: postExample[index]["postImage"],
                              saveEnable: postExample[index]["enableSave"],
                            ),
                          );
                        },
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: postExample.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: PostContainer(
                              avatar: postExample[index]["avatar"],
                              author: postExample[index]["author"],
                              isAuthorVerified: postExample[index]
                                  ["isAuthorVerified"],
                              date: postExample[index]["date"],
                              topicName: postExample[index]["topicName"],
                              description: postExample[index]["description"],
                              postImage: postExample[index]["postImage"],
                              saveEnable: postExample[index]["enableSave"],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
