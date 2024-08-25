import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:testproject/widgets/default_container.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  int selectedFeedIndex = 0;
  List<int> selectedTopicIndices = [];
  TextEditingController postDescriptionController = TextEditingController();

  @override
  void dispose() {
    postDescriptionController.dispose();
    super.dispose();
  }

  final List feeds = ["Public", "Business"];
  final List topics = [
    "climate change & sustainability",
    "Conscious Art",
    "Conscious Art"
  ];

  File? _image;

  Future<void> _selectImage(BuildContext context,
      {required ImageSource source}) async {
    final picker = ImagePicker();

    if (Platform.isAndroid) {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final androidInfo = await deviceInfoPlugin.androidInfo;

      if (source == ImageSource.gallery && androidInfo.version.sdkInt <= 32) {
        final status = await Permission.storage.request();

        if (!status.isGranted) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                    Text('Permission denied. Please grant gallery access.'),
              ),
            );
          }
          return;
        }
      } else if (source == ImageSource.camera) {
        final status = await Permission.camera.request();

        if (!status.isGranted) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Permission denied. Please grant camera access.'),
              ),
            );
          }
          return;
        }
      }
    } else if (Platform.isIOS) {
      if (source == ImageSource.gallery) {
        final status = await Permission.photos.request();

        if (!status.isGranted) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Permission denied. Please grant photo library access.'),
              ),
            );
          }
          return;
        }
      } else if (source == ImageSource.camera) {
        final status = await Permission.camera.request();

        if (!status.isGranted) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Permission denied. Please grant camera access.'),
              ),
            );
          }
          return;
        }
      }
    }

    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.read<ValueNotifier<int>>().value = 0;
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text(
            "Create Post",
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
          actions: [
            Container(
              height: 30,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: theme.primary,
              ),
              child: const Center(
                child: Text(
                  "Post",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(
              right: 15,
              left: 15,
              bottom: keyboardVisible
                  ? MediaQuery.of(context).viewInsets.bottom
                  : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
                child: ListView.builder(
                  itemCount: feeds.length,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedFeedIndex = index;
                          });
                        },
                        child: DefaultContainer(
                          fillColor: index == selectedFeedIndex
                              ? theme.primary
                              : theme.surface,
                          hasBorder: index == selectedFeedIndex ? false : true,
                          text: feeds[index],
                          height: 30,
                          width: 150,
                          textColor: index == selectedFeedIndex
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return TextField(
                      controller: postDescriptionController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type Something',
                      ),
                    );
                  },
                ),
              ),
              const Text(
                "Topic",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  itemCount: topics.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final isSelected = selectedTopicIndices.contains(index);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedTopicIndices.remove(index);
                            } else {
                              selectedTopicIndices.add(index);
                            }
                          });
                        },
                        child: DefaultContainer(
                          fillColor: isSelected ? theme.primary : theme.surface,
                          hasBorder: !isSelected,
                          text: topics[index],
                          height: 40,
                          textColor: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              _image != null
                  ? Stack(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: FileImage(_image!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _image = null;
                                  });
                                },
                                child: const Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        InkWell(
                          onTap: () {
                            _selectImage(context, source: ImageSource.camera);
                          },
                          child: Image.asset(
                            "assets/icons/camera.png",
                            width: 40,
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            _selectImage(context, source: ImageSource.gallery);
                          },
                          child: Image.asset(
                            "assets/icons/gallery.png",
                            width: 40,
                          ),
                        ),
                      ],
                    ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
