import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testproject/screens/add_post_screen.dart';
import 'package:testproject/screens/chat_screen.dart';
import 'package:testproject/screens/home_screen.dart';
import 'package:testproject/screens/profile_screen.dart';
import 'package:testproject/screens/search_screen.dart';

class BottomNavbarScreen extends StatefulWidget {
  const BottomNavbarScreen({super.key});

  @override
  State<BottomNavbarScreen> createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen> {
  List<Map<String, dynamic>> _tabs = [];
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _tabs = [
      {
        'label': 'Home',
        'icon': 'assets/icons/home-icon.png',
        'page': HomeScreen(showBottomSheet: _showBottomSheet),
      },
      {
        'label': 'Search',
        'icon': 'assets/icons/search-icon.png',
        'page': const SearchScreen(),
      },
      {
        'label': 'Create',
        'icon': 'assets/icons/add-icon.png',
        'page': const AddPostScreen(),
      },
      {
        'label': 'Chat',
        'icon': 'assets/icons/message-icon.png',
        'page': const ChatScreen(),
      },
      {
        'label': 'Profile',
        'icon': 'assets/icons/profile-icon.png',
        'page': const ProfileScreen(),
      }
    ];
  }

  void _showBottomSheet() {
    final theme = Theme.of(context).colorScheme;
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return FractionallySizedBox(
              heightFactor: 0.4,
              widthFactor: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      bool isSelected = index == _selectedIndex;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          child: Container(
                            width: double.maxFinite,
                            height: 60,
                            decoration: BoxDecoration(
                              color: isSelected ? theme.primary : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 20),
                                Image.asset(
                                  "assets/icons/bottomsheeticon.png",
                                  width: 20,
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  "Topic ${index + 1}",
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentIndex = Provider.of<ValueNotifier<int>>(context).value;

    return Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: _tabs
              .map((tab) => Navigator(
                    onGenerateRoute: (settings) => MaterialPageRoute(
                      builder: (_) => tab['page'],
                    ),
                  ))
              .toList(),
        ),
        bottomNavigationBar: currentIndex == 2
            ? null
            : BottomNavigationBar(
                elevation: 0,
                currentIndex: currentIndex,
                type: BottomNavigationBarType.fixed,
                onTap: (index) =>
                    Provider.of<ValueNotifier<int>>(context, listen: false)
                        .value = index,
                items: List.generate(_tabs.length, (i) {
                  final tab = _tabs[i];
                  return BottomNavigationBarItem(
                    label: tab['label'],
                    icon: Image.asset(
                      tab['icon'],
                      width: 24,
                      height: 24,
                      color: currentIndex == i
                          ? colorScheme.primary
                          : Colors.black,
                    ),
                  );
                }).toList(),
              ));
  }
}
