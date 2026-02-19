import 'dart:io';

import 'package:felicitime/ui/widgets/back_home.dart';
import 'package:flutter/material.dart';
import 'package:felicitime/config/colors.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImagesGalleryDetails extends StatefulWidget {
  const ImagesGalleryDetails({
    super.key,
    required this.images,
    this.initialIndex = 0,
  });

  final List images;
  final int initialIndex;

  @override
  State<ImagesGalleryDetails> createState() => _ImagesGalleryDetailsState();
}

class _ImagesGalleryDetailsState extends State<ImagesGalleryDetails> {
  late final PageController _pageController = PageController(initialPage: widget.initialIndex);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            pageController: _pageController,
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: FileImage(File(widget.images[index].path)),
                initialScale: PhotoViewComputedScale.contained,
              );
            },
            itemCount: widget.images.length,
            loadingBuilder: (context, event) => const Center(
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 10,
            child: BackHome(),
          ),
          if (widget.images.length > 1) Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: widget.images.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Theme.of(context).colorScheme.primary,
                  dotColor: AppColors.appGrey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
