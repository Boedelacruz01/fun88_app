import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TopCarousel extends StatelessWidget {
  const TopCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = ['assets/images/banner-bg.png'];
    final List<List<String>> texts = [
      [
        "RESCUE",
        "BONUS",
        "WE ARE HERE",
        " FOR YOU",
      ], // example texts for the first banner
    ];

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CarouselSlider(
          options: CarouselOptions(
            height: 140,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1.0,
          ),
          items: images.asMap().entries.map((entry) {
            int index = entry.key;
            String path = entry.value;
            return Builder(
              builder: (BuildContext context) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(path, fit: BoxFit.cover),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        height: 140, // match Carousel height
                        child: FittedBox(
                          // <-- overflow fix
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: texts[index].map((t) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: Text(
                                  t,
                                  style: TextStyle(
                                    color: t == "BONUS"
                                        ? Colors.yellow
                                        : Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
