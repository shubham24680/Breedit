import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../main_component.dart';
import '../../home_component.dart';

class Matches extends StatefulWidget {
  const Matches({super.key});

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  bool mateExists = false;
  List<String?> images = List.generate(4, growable: false, (index) => null);
  // String petName = "";

  @override
  void initState() {
    super.initState();
    _refreshMate();
  }

  Future<void> _refreshMate() async {
    await getData('mates');
    if (mounted) {
      FirebaseFirestore.instance
          .collection('mates')
          .doc(user!.uid)
          .get()
          .then((data) {
        setState(() {
          mateExists = data.exists;
        });
      });
      setState(() {
        for (int i = 0; i < data['images'].length; i++) {
          images[i] = data['images'][i];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    noProfile() {
      return Column(
        children: [
          Image.asset('assets/pictures/cute_dog.png'),
          ElevatedButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('mates')
                  .doc(user!.uid)
                  .get()
                  .then((data) {
                if (!data.exists) {
                  create('mates', {'name': null, 'images': [], 'prompts': []});
                }
              });
              Navigator.pushNamed(context, 'edit');
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: white,
              backgroundColor: green,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: h2("Edit pet profile", white, 16),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        surfaceTintColor: background,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_outlined, color: black),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, 'edit'),
            icon: Icon(Icons.filter_list, color: black),
          ),
        ],
      ),
      body: mateExists
          ? SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Stories(),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 100),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // heading(petName, Colors.grey.shade900, 32),
                                h2("Active today", green, 12),
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.more_horiz),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        images[0] != null
                            ? ImageCard(url: images[0]!)
                            : const SizedBox(),
                        const SizedBox(height: 20),
                        // const TextCard(top: "I go crazy for", bottom: "Meat"),
                        // const SizedBox(height: 20),
                        images[1] != null
                            ? ImageCard(url: images[1]!)
                            : const SizedBox(),
                        const SizedBox(height: 20),
                        images[2] != null
                            ? ImageCard(url: images[2]!)
                            : const SizedBox(),
                        const SizedBox(height: 20),
                        // const TextCard(
                        //     top: "Unusual skills", bottom: "Football"),
                        // const SizedBox(height: 20),
                        images[3] != null
                            ? ImageCard(url: images[3]!)
                            : const SizedBox(),
                        const SizedBox(height: 20),
                        // const TextCard(
                        //     top: "My greatest strength", bottom: "Anime"),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : noProfile(),
      floatingActionButton: mateExists
          ? FloatingActionButton(
              onPressed: () {},
              backgroundColor: green,
              child: const Icon(Icons.close, color: white),
            )
          : null,
    );
  }
}
