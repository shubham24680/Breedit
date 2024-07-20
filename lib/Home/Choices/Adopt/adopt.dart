import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../main_component.dart';
import '../../home_component.dart';

class Adopt extends StatefulWidget {
  const Adopt({super.key});

  @override
  State<Adopt> createState() => _AdoptState();
}

class _AdoptState extends State<Adopt> {
  pets(Size size) {
    return SizedBox(
      height: size.height - 155,
      child: GridView.builder(
        itemCount: 10,
        padding: const EdgeInsets.symmetric(vertical: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.7),
        itemBuilder: (context, index) => tile(),
      ),
    );
  }

  tile() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'pets'),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              child: Image.asset('assets/pictures/german.png'),
            ),
            heading("German Shepherd", white, 14),
            const SizedBox(height: 10),
            Text(
              "Agile, muscular dog of noble character and high intelligence.",
              textAlign: TextAlign.center,
              style: GoogleFonts.quicksand(
                color: grey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        surfaceTintColor: background,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, 'edit'),
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Stories(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heading("Pets", black, 20),
                  pets(size),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
