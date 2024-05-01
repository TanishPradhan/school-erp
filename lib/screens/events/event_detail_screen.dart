import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventDetailScreen extends StatelessWidget {
  final String date;
  final String title;
  final String subtitle;
  final String heroTag;

  const EventDetailScreen({
    super.key,
    required this.date,
    required this.title,
    required this.subtitle,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Hero(
                    tag: heroTag,
                    child: Container(
                      color: const Color(0xFFCACACA),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Icon(
                        Icons.chevron_left_rounded,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_outlined,
                          color: Color(0xFF6789CA),
                          size: 20,
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          date,
                          style: const TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6789CA),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      title,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      subtitle,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 13.0,
                        color: Color(0xFF777777),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
