import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/main_component.dart';
import '../../home_component.dart';

import 'view.dart';

class EditAndView extends StatefulWidget {
  const EditAndView({super.key});

  @override
  State<EditAndView> createState() => _EditAndViewState();
}

class _EditAndViewState extends State<EditAndView> {
  final List<String?> item = List.generate(4, growable: false, (index) => null);

  @override
  void initState() {
    super.initState();
    refreshMate();
  }

  Future<void> refreshMate() async {
    await getData('mates');
    if (mounted) {
      setState(() {
        for (int i = 0; i < data['images'].length; i++) {
          item[i] = data['images'][i];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: black,
            dividerColor: black,
            labelColor: white,
            unselectedLabelColor: grey,
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.hovered)) {
                  return white;
                }
                return null;
              },
            ),
            tabs: [
              Tab(
                child: Text(
                  'Edit',
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'View',
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Edits(item: item),
            Views(item: item),
          ],
        ),
      ),
    );
  }
}

class Edits extends StatelessWidget {
  const Edits({super.key, required this.item});

  final List<String?> item;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // PET PHOTOS
            heading("Pet Photos", black, 18),
            const SizedBox(height: 10),
            PetProfilePhoto(
              height: size.height / 2,
              crossAxisCount: 2,
              item: item,
              collection: 'mates',
            ),
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
                ),
              ),
            ),
            const SizedBox(height: 20),

            // PET VITALS
            heading("Pet Vitals", black, 18),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
