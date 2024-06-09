import 'package:breedit/Home/Choices/Mate/pet_profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:breedit/main_component.dart';
import '../../home_component.dart';

import '/Home/Choices/Mate/view.dart';

class EditAndView extends StatefulWidget {
  const EditAndView({super.key});

  @override
  State<EditAndView> createState() => _EditAndViewState();
}

class _EditAndViewState extends State<EditAndView> {
  String name = "";

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        name = data['first name'] + " " + data['last name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: background,
          title: Text(
            name,
            style: GoogleFonts.manrope(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900),
          ),
          bottom: TabBar(
            indicatorColor: black,
            dividerColor: Colors.black12,
            labelColor: Colors.grey.shade900,
            unselectedLabelColor: Colors.grey,
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.hovered)) {
                  return green; //<-- SEE HERE
                }
                return null;
              },
            ),
            tabs: [
              Tab(
                child: Text(
                  'Edit',
                  style: GoogleFonts.quicksand(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'View',
                  style: GoogleFonts.quicksand(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Edits(),
            Views(),
          ],
        ),
      ),
    );
  }
}

class Edits extends StatelessWidget {
  const Edits({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            subheading("Pet Photos"),
            // const SizedBox(height: 10),
            const PetProfilePhoto(),
            // subheading("Written Prompts"),
          ],
        ),
      ),
    );
  }
}
