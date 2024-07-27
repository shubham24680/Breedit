import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:breedit/Home/home_component.dart';
import 'package:breedit/main_component.dart';

class Answer extends StatefulWidget {
  const Answer({super.key, required this.prompt, required this.text});
  
  final String? prompt;
  final String? text;

  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  bool length = false;
  String prompt = "";
  late TextEditingController answer;

  @override
  void initState() {
    super.initState();
    prompt = widget.prompt ?? "Select a prompt";
    answer = TextEditingController(text: widget.text ?? "");
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
            onPressed: () {
              if (widget.prompt != null) {
                update('mates', {
                  'prompts': FieldValue.arrayRemove([widget.prompt]),
                  'answers': FieldValue.arrayRemove([widget.text]),
                });
              }
              if (prompt != "Select a prompt" && length) {
                update('mates', {
                  'prompts': FieldValue.arrayUnion([prompt]),
                  'answers': FieldValue.arrayUnion([answer.text]),
                });
                Navigator.pop(context);
              }
            },
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
                      final String? value =
                          await Navigator.pushNamed(context, 'prompts')
                              as String?;
                      setState(() {
                        prompt = value ?? prompt;
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
              onChanged: (value) {
                setState(() {
                  length = value.isNotEmpty;
                });
              },
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
