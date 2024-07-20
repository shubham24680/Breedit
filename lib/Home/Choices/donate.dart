import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main_component.dart';
import '../home_component.dart';

class Donate extends StatelessWidget {
  const Donate({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded, color: white),
        ),
        backgroundColor: black,
        surfaceTintColor: black,
        title: heading("Create profile to donate", white, 20),
        actions: [
          IconButton(
            color: white,
            onPressed: () {},
            icon: const Icon(Icons.check_circle, color: white),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            questions("Add pictures of Pets/Furry friend"),
            SizedBox(
              height: size.height / 4,
              child: GridView.builder(
                itemCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                itemBuilder: (context, index) => GestureDetector(
                  // onTap: () => pickImage(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: background,
                      border: Border.all(color: black),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image:
                            // _selected[index] != null
                            // ? FileImage(_selected[index]!) as ImageProvider
                            const AssetImage('assets/pictures/add.png'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            questions("Add information"),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "About",
                hintStyle: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold, color: grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: black.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: black.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            questions("Add your contact information"),
            TextField(
              decoration: InputDecoration(
                hintText: "phone / Email",
                hintStyle: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold, color: grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: black.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: black.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Address",
                hintStyle: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold, color: grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: black.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: black.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
