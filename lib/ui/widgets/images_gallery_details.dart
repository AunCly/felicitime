import 'dart:io';

import 'package:flutter/material.dart';
import 'package:felicitime/config/colors.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImagesGalleryDetails extends StatefulWidget {
  const ImagesGalleryDetails({
    super.key,
    required this.images
  });

  final List images;

  @override
  State<ImagesGalleryDetails> createState() => _ImagesGalleryDetailsState();
}

class _ImagesGalleryDetailsState extends State<ImagesGalleryDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
            color: AppColors.appWhite,
            padding: const EdgeInsets.all(10),
            child: AppBar(
              backgroundColor: AppColors.appWhite,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: AppColors.appPurple,),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text('Galerie', style: Theme.of(context).textTheme.bodyMedium),
            )
        ),
      ),
      body: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: FileImage(File(widget.images[index].path)),
            initialScale: PhotoViewComputedScale.contained * 0.8,
            heroAttributes: PhotoViewHeroAttributes(tag: widget.images[index].path),
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
    );
  }
}
