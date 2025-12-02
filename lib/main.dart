// main.dart
// Défilement vertical infini (loop) style TikTok
// 4 images + un texte fixe sur chaque écran

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Infinite Scroll',
      theme: ThemeData.dark(),
      home: const InfiniteFeed(),
    );
  }
}

class InfiniteFeed extends StatefulWidget {
  const InfiniteFeed({Key? key}) : super(key: key);

  @override
  State<InfiniteFeed> createState() => _InfiniteFeedState();
}

class _InfiniteFeedState extends State<InfiniteFeed> {
  final PageController _pageController = PageController(initialPage: 1000);

  // 4 images seulement
  final List<String> _images = const [
    'https://picsum.photos/id/1011/1080/1920',
    'https://picsum.photos/id/1015/1080/1920',
    'https://picsum.photos/id/1020/1080/1920',
    'https://picsum.photos/id/1039/1080/1920'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final image = _images[index % _images.length];

          return Stack(
            fit: StackFit.expand,
            children: [
              // Image plein écran
              Positioned.fill(
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),

              // Gradient
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
              ),

              // Texte (fixe)
              Positioned(
                bottom: 40,
                left: 20,
                right: 20,
                child: Text(
                  "Votre texte ici — affiché sur chaque écran",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
