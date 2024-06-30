import 'package:breedit/Home/Choices/Mate/filter/pet_profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:breedit/main_component.dart';
import '../../../home_component.dart';

import 'view.dart';

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
          backgroundColor: black,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: white),
          ),
          title: heading(name, white, 20),
          bottom: TabBar(
            indicatorColor: black,
            dividerColor: black,
            labelColor: white,
            unselectedLabelColor: grey,
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

            // PET PHOTOS
            heading("Pet Photos", black, 18),
            const SizedBox(height: 5),
            const PetProfilePhoto(),
            const SizedBox(height: 20),

            // WRITTEN PROMPTS
            heading("Written Prompts", black, 18),
            SizedBox(
              height: 270,
              child: ListView.builder(
                  itemCount: 3,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Navigator.pushNamed(context, 'answer'),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: background,
                            border: Border.all(color: black.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              heading("I go crazy for", black, 16),
                              const SizedBox(height: 5),
                              heading("Meat", grey, 14),
                            ],
                          ),
                        ),
                      )),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
