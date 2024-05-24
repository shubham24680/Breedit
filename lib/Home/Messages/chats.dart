import 'package:breedit/Authentication/auth_component.dart';
import 'package:breedit/main_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  bool active = false;
  List<Color> choice = [neoGreen, neoBlue, neoOrange];
  List<String> name = ["Mate", "Adopt", "Donate"];

  image() {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: black,
      ),
    );
  }

  stories() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: image(),
        ),
      ),
    );
  }

  mate() {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 211,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => SizedBox(
          height: 100,
          child: Row(
            children: [
              image(),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Shubham Patel",
                      style: GoogleFonts.quicksand(
                          color: black,
                          fontWeight: active ? FontWeight.bold : null,
                          fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        subheading("message"),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            name[index%name.length],
                            style: GoogleFonts.quicksand(
                                color: choice[index%choice.length], fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        stories(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Messages",
                    style: GoogleFonts.manrope(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "filter",
                      style: GoogleFonts.manrope(
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                  )
                ],
              ),
              mate(),
            ],
          ),
        )
      ],
    );
  }
}
