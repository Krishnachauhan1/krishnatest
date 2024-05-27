import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';
import '../MyHelper/my_widgets/my_widgets.dart';
import '../controllers/profic_pic_controller.dart';
import '../model/user_model.dart';
import 'export_view.dart';

class UserProfile extends StatefulWidget {
  final UserModel user;
  const UserProfile({super.key, required this.user});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
   
Future<void> _pickImage(BuildContext context) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    // Get the current user ID
    String userId = widget.user.id.toString();

    // Store the image using the existing instance of ProfilePicController
    ProfilePicController().storeImageForUserId(userId, File(pickedFile.path));

    // Update the UI by calling setState
    setState(() {});
  }
}


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => ProfilePicController(),
      child: SafeArea(
          child: DefaultTabController(
              length: 2,
              child: Scaffold(
                backgroundColor: Colors.black,
                appBar: MyWidgets.myAppbar(title: widget.user.username ?? ''),
                body: SizedBox(
                  height: screenHeight,
                  child: Column(children: [
                    /// upper half where display user's details and image picking option
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      height: screenHeight * 0.2,
                      width: double.infinity,
                      padding:
                          const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async => await _pickImage(context),
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundImage: ProfilePicController
                                                        .photos[
                                                    widget.user.id.toString()] !=
                                                null
                                            ? FileImage(ProfilePicController
                                                .photos[widget.user.id.toString()])
                                            : null,
                                        child: ProfilePicController.photos[
                                                    widget.user.id.toString()] ==
                                                null
                                            ? const Icon(Icons.person_2_rounded,
                                                size: 15)
                                            : null,
                                      ),
                                      const Positioned(
                                        // bottom: 0,
                                        // right: 0,
                                        child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.blue,
                                          child: Icon(Icons.add,
                                              size: 8, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.user.name!,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12)),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.phone, color: Colors.white),
                                    Text(widget.user.phone!,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.email, color: Colors.white),
                                    Text(
                                      widget.user.email!,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                    onTap: () async {
                                      try {
                                        final url =
                                            'http://${widget.user.website!}';
                                        await canLaunch(url);
                                        await launch(url);
                                      } catch (err) {
                                        if (kDebugMode) {
                                          print(err);
                                        }
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.link, color: Colors.blue),
                                        Text(widget.user.website!,
                                            style: const TextStyle(
                                                color: Colors.blue, fontSize: 12)),
                                      ],
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    
                    
                  /// lower half of screen displaying tabs for post and albums
                    Expanded(
                        child: Column(
                      children: [
                        const TabBar(
                          tabs: [
                            Tab(text: 'Albums'),
                            Tab(text: 'Posts'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              // album tab
                              AlbumTabBarView(
                                userId: widget.user.id.toString(),
                              ),
                              //post tab
                              PostTabBarView(
                                userId: widget.user.id.toString(),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
                  ]),
                ),
              ))),
    );
  }
}
