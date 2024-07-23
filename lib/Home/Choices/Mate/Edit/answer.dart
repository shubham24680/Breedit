import 'package:breedit/Home/home_component.dart';
import 'package:breedit/main_component.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Answer extends StatefulWidget {
  const Answer({super.key});

  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  String prompt = "";
  late TextEditingController answer;

  @override
  void initState() {
    super.initState();
    answer = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Write answer"),
        actions: [
          IconButton(
            color: white,
            onPressed: () {},
            icon: const Icon(Icons.check_circle, color: white),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Container(
              height: 70,
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: black.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(child: heading(prompt, black, 16)),
                  VerticalDivider(color: black.withOpacity(0.3)),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () async {
                      final String value = await Navigator.pushNamed(context, 'prompts') as String;
                      setState(() {
                        prompt = value;
                      });
                    },
                    highlightColor: Colors.transparent,
                    icon: Icon(Icons.edit, color: black, size: 30),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: answer,
              maxLines: 5,
              style: GoogleFonts.quicksand(
                color: black,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintText: "Write answer",
                hintStyle: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold, color: grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: black.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: black.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
