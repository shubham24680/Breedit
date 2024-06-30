// import 'package:breedit/Authentication/auth_component.dart';
// import 'package:breedit/main_component.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Chats extends StatefulWidget {
//   const Chats({super.key});

//   @override
//   State<Chats> createState() => _ChatsState();
// }

// class _ChatsState extends State<Chats> {
//   bool active = false;
//   List<Color> choice = [neoGreen, neoBlue, neoOrange];
//   List<String> name = ["Mate", "Adopt", "Donate"];
//   List<List<String>> ns = [
//     ['assets/pictures/1324832.png', "Shubham Patel", "Hii"],
//     ['assets/pictures/8733690.jpg', "Sanchit Sharma", "message"],
//     ['assets/pictures/20200304_020853.jpg', "Nirupam Sharma", "ojdf"],
//     ['assets/pictures/cat.jpg', "Harish", "jfdl"],
//     ['assets/pictures/dog.jpg', "Roshan Kumar", "jdlfe"]
//   ];
//   List<int> options = [2, 0, 1, 2, 1];

//   image(String path) {
//     return Container(
//       height: 60,
//       width: 60,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: black,
//         image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
//       ),
//     );
//   }

//   stories() {
//     return SizedBox(
//       height: 100,
//       child: ListView.builder(
//         itemCount: ns.length,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) => Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: image(ns[index][0]),
//         ),
//       ),
//     );
//   }

//   mate() {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height - 207,
//       child: ListView.builder(
//         itemCount: ns.length,
//         padding: const EdgeInsets.symmetric(vertical: 0),
//         itemBuilder: (context, index) => SizedBox(
//           height: 100,
//           child: Row(
//             children: [
//               image(ns[index][0]),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       ns[index][1],
//                       style: GoogleFonts.quicksand(
//                           color: black,
//                           fontWeight: active ? FontWeight.bold : null,
//                           fontSize: 20),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         subheading(ns[index][2]),
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           decoration: BoxDecoration(
//                             color: black,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Text(
//                             name[options[index]],
//                             style: GoogleFonts.quicksand(
//                                 color: choice[options[index]],
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 20),
//         stories(),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     "Messages",
//                     style: GoogleFonts.manrope(
//                         color: black,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20),
//                   ),
//                   InkWell(
//                     onTap: () {},
//                     child: Text(
//                       "filter",
//                       style: GoogleFonts.manrope(
//                           color: Colors.grey,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 20),
//                     ),
//                   )
//                 ],
//               ),
//               mate(),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../main_component.dart';
import '../home_component.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final List<Color> choice = [Colors.green, Colors.blue, Colors.orange];
  final List<String> name = ["Mate", "Adopt", "Donate"];
  List<List<String>> ns = [
    ['assets/pictures/1324832.png', "Shubham Patel", "Hii"],
    ['assets/pictures/8733690.jpg', "Sanchit Sharma", "message"],
    ['assets/pictures/20200304_020853.jpg', "Nirupam Sharma", "ojdf"],
    ['assets/pictures/cat.jpg', "Harish", "jfdl"],
    ['assets/pictures/dog.jpg', "Roshan Kumar", "jdlfe"]
  ];
  String imagePath = "";
  bool active = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        imagePath = data['images'];
      });
    }
  }

  Widget image(String path) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
      ),
    );
  }

  Widget stories() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: 10, // Example item count, replace with actual count
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: image(ns[index % 5][0]), // Replace with actual image path
        ),
      ),
    );
  }

  Widget chatTile(int index) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          image(ns[index][0]),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ns[index][1],
                  style: GoogleFonts.quicksand(
                    color: Colors.black,
                    fontWeight: active ? FontWeight.bold : FontWeight.normal,
                    fontSize: 20,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ns[index][2],
                      style: GoogleFonts.quicksand(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        name[index % 3],
                        style: GoogleFonts.quicksand(
                          color: choice[index % 3],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(
              //   chat['timestamp'], // Format timestamp appropriately
              //   style: GoogleFonts.quicksand(
              //     color: Colors.grey,
              //     fontSize: 12,
              //   ),
              // ),
              if (2 > 0)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget mate() {
    // return StreamBuilder<QuerySnapshot>(
    //   stream: FirebaseFirestore.instance.collection('chats').snapshots(),
    //   builder: (context, snapshot) {
    //     if (!snapshot.hasData) {
    //       return const Center(child: CircularProgressIndicator());
    //     }

    //     var chatDocs = snapshot.data!.docs;

    return SizedBox(
      height: MediaQuery.of(context).size.height - 307,
      child: ListView.builder(
        itemCount: 5,
        // itemCount: chatDocs.length,
        padding: const EdgeInsets.symmetric(vertical: 0),
        itemBuilder: (context, index) {
          // var chat = chatDocs[index];
          return chatTile(index);
        },
      ),
    );
    // },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        surfaceTintColor: black,
        title: Text(
          'Chats',
          style: GoogleFonts.manrope(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.filter_list, color: Colors.white),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: Column(
        children: [
          stories(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Messages",
                  style: GoogleFonts.manrope(
                    color: black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 5),
                mate(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
