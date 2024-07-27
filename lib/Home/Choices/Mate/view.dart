import 'package:flutter/material.dart';

import '../../home_component.dart';

class Views extends StatelessWidget {
  const Views({super.key, required this.images, required this.prompt, required this.answer});

  final List<String?> images;
  final List<String?> prompt;
  final List<String?> answer;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            images[0] != null ? image(size, images[0]!) : const SizedBox(),
             SizedBox(height: images[0] != null ? 20 : 0),
            prompt[0] != null ? card(size, prompt[0]!, answer[0]!) : const SizedBox(),
             SizedBox(height: prompt[0]  != null ? 20 : 0),
            images[1] != null ? image(size, images[1]!) : const SizedBox(),
            SizedBox(height: images[1] != null ? 20 : 0),
            images[2] != null ? image(size, images[2]!) : const SizedBox(),
            SizedBox(height: images[2] != null ? 20 : 0),
            prompt[1] != null ? card(size, prompt[1]!, answer[1]!) : const SizedBox(),
             SizedBox(height: prompt[1]  != null ? 20 : 0),
            images[3] != null ? image(size, images[3]!) : const SizedBox(),
            SizedBox(height: images[3] != null ? 20 : 0),
            prompt[2] != null ? card(size, prompt[2]!, answer[2]!) : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
