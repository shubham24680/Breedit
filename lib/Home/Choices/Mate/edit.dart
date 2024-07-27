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
  final List<String?> prompt =
      List.generate(3, growable: false, (index) => null);
  final List<String?> answer =
      List.generate(3, growable: false, (index) => null);
  final List<String> vitals = ["Name"];

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
        for (int i = 0; i < data['prompts'].length; i++) {
          prompt[i] = data['prompts'][i];
          answer[i] = data['answers'][i];
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
            Edits(item: item, prompt: prompt, answer: answer),
            Views(images: item, prompt: prompt, answer: answer),
          ],
        ),
      ),
    );
  }
}

class Edits extends StatelessWidget {
  const Edits(
      {super.key,
      required this.item,
      required this.prompt,
      required this.answer});

  final List<String?> item;
  final List<String?> prompt;
  final List<String?> answer;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            PromptCard(
              height: 270,
              prompt: prompt,
              answer: answer,
              title: "Select a prompt",
              subTitle: "And write your own answer",
            ),
            // const SizedBox(height: 20),

            // PET VITALS
            // heading("Pet Vitals", black, 18),
            // PromptCard(
            //   height: 270,
            //   prompt: prompt,
            //   answer: answer,
            //   title: "Select a prompt",
            //   subTitle: "And write your own answer",
            // ),
          ],
        ),
      ),
    );
  }
}
