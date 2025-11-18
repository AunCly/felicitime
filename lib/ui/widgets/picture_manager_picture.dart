import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:felicitime/config/colors.dart';
import 'package:felicitime/features/picture/models/image.dart';
import 'package:felicitime/ui/widgets/images_gallery_details.dart';

class MediaManagerMedia extends StatefulWidget {
  const MediaManagerMedia({
    super.key,
    required this.media,
    required this.onDelete,
    this.editable = true,
  });

  final MediaModel media;
  final Function onDelete;
  final bool editable;

  @override
  State<MediaManagerMedia> createState() => _MediaManagerMediaState();
}

class _MediaManagerMediaState extends State<MediaManagerMedia> {

  showGalleryDialog(List<MediaModel> images) {
    showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.white,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        builder: (BuildContext context) => Dialog.fullscreen(
          child: ImagesGalleryDetails(images: images),
        )
    );
  }

  _getImageProvider(MediaModel media) {
    ImageProvider imageWidget;

    imageWidget = FileImage(File(widget.media.path));

    return imageWidget;
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              showGalleryDialog([widget.media]);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: _getImageProvider(widget.media),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          if(widget.editable) Positioned(
            top: 20,
            right: 20,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: AppColors.appPrimary,
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                icon: const Icon(
                  FontAwesomeIcons.solidTrash,
                  color: AppColors.appWhite,
                  size: 15,
                ),
                onPressed: () => widget.onDelete(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
