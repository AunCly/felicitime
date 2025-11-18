import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gal/gal.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:felicitime/config/colors.dart';
import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/picture/models/image.dart';
import 'package:felicitime/main.dart';
import 'package:felicitime/ui/widgets/button.dart';
import 'package:felicitime/ui/widgets/container.dart';
import 'package:felicitime/ui/widgets/picture_manager_picture.dart';
import 'package:permission_handler/permission_handler.dart';

class MediaManager extends ConsumerStatefulWidget {

  const MediaManager({
    super.key,
    required this.medias,
    required this.title,
    this.canEdit = true,
    this.canChoose = true,
    this.canChooseMedia = false,
    this.canAdd = true,
    this.canChooseMultiple = true,
    this.min = 1,
    this.max = 50,
    this.error = false,
  });

  final String title;
  final List<MediaModel> medias;
  final bool canEdit;
  final bool canChoose;
  final bool canChooseMultiple;
  final bool canChooseMedia;
  final bool canAdd;
  final int min;
  final int max;
  final bool error;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PictureManagerState();
}

enum GalExceptionType {
  accessDenied,
  notEnoughSpace,
  notSupportedFormat,
  unexpected;

  String get message {
    switch (this) {
      case accessDenied:
        return 'You do not have permission to access the gallery app.';
      case notEnoughSpace:
        return 'Not enough space for storage.';
      case notSupportedFormat:
        return 'Unsupported file formats.';
      case unexpected:
        return 'An unexpected error has occurred.';
    }
  }
}

class _PictureManagerState extends ConsumerState<MediaManager> with WidgetsBindingObserver {

  final ImagePicker picker = ImagePicker();
  bool cameraPermission = true;
  bool checkForPermission = false;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && checkForPermission == false) {
      checkForPermission = true;
      verifyPermission().then((_) {
        checkForPermission = false;
      });
    }
  }

  initPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
    ].request();

    var cameraStatus = await Permission.camera.status;

    setState(() {
      cameraPermission = cameraStatus.isPermanentlyDenied || cameraStatus.isDenied ? false : true;
    });
  }

  verifyPermission() async {

    var cameraStatus = await Permission.camera.status;

    setState(() {
      cameraPermission = cameraStatus.isPermanentlyDenied || cameraStatus.isDenied ? false : true;
    });
  }

  bool _verifyMaxLimitation(){
    if(widget.max != null && widget.medias.length >= widget.max!) {
      return false;
    }
    return true;
  }

  bool _verifyMinLimitation(){
    if(widget.medias.length <= widget.min) {
      return false;
    }
    return true;
  }

  _showVerificationSnackBar(BuildContext context, String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      content: Text(message, style: Theme.of(context).textTheme.bodyMedium),
    ));
  }

  _captureImage(BuildContext context) async {

    if(!_verifyMaxLimitation()){
      _showVerificationSnackBar(context, 'Vous avez atteint le nombre maximum de photos');
      return;
    }

    final XFile? image = await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    if(image == null) return;

    bool? syncImagesEnabled = ref.read(sharedPreferencesProvider).getBool('syncImages');
    if(syncImagesEnabled != null && syncImagesEnabled == true){
      try {
        await Gal.putImage(image.path, album: 'Félicitime');
      } on GalException catch (e) {
        print(e.type.message);
      }
    }

    setState(() {
      widget.medias.add(MediaModel(path: image.path));
    });

  }

  void _pickImage(BuildContext context, {multiple = true}) async {

    if(!_verifyMaxLimitation()){
      _showVerificationSnackBar(context, 'Vous avez atteint le nombre maximum de photos');
      return;
    }

    if(multiple){
      final List<XFile> images = await picker.pickMultiImage(imageQuality: 50);

      setState(() {
        for(int i = 0; i < images.length; i++){
          if(!_verifyMaxLimitation()){
            _showVerificationSnackBar(context, 'Vous avez atteint le nombre maximum de photos');
            return;
          }
          widget.medias.add(MediaModel(path: images[i].path));
        }
      });

      if (context.mounted) context.pop();
    }
    else{
      final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

      if(image == null) return;

      setState(() {
        widget.medias.add(MediaModel(path: image.path));
      });

      if (context.mounted) context.pop();
    }
  }

  _showMediaSrcDialog(){
    if(!widget.canChoose && !widget.canChooseMedia){
      _captureImage(context);
    }
    else{
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor:Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            insetPadding: const EdgeInsets.all(15),
            title: Row(
              children: [
                Text('Ajouter des photos', style: Theme.of(context).textTheme.titleMedium),
                const Spacer(),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.times, color: AppColors.appPrimary),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if(widget.canAdd) AppButton(
                  text: 'Prendre une photo',
                  icon: FontAwesomeIcons.camera,
                  onPressed: () => _captureImage(context),
                ),
                if(widget.canChoose) gapHNormal,
                if(widget.canChoose) AppButton(
                  text: 'Choisir une photo',
                  icon: FontAwesomeIcons.image,
                  onPressed: () => _pickImage(context, multiple: widget.canChooseMultiple),
                ),
              ],
            ),
          );
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(cameraPermission) GestureDetector(
          onTap: _showMediaSrcDialog,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: widget.error ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.shadow, width: 2),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      AppContainer(
                        primaryColor: Theme.of(context).colorScheme.secondary,
                        content: Icon(widget.canChooseMedia == true ? FontAwesomeIcons.lightFile : FontAwesomeIcons.lightCamera, color: Theme.of(context).colorScheme.shadow),
                      ),
                      gapWNormal,
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.title, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: widget.error ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.onSurface)),
                            Row(
                              children: [
                                if(widget.min > 0) Text('${widget.min} obligatoire, ', style: Theme.of(context).textTheme.bodySmall),
                                Text('${widget.max} maximum', style: Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                          ]
                        ),
                      )
                    ]
                  ),
                ),
                Divider(
                  color: Theme.of(context).colorScheme.shadow,
                  thickness: 2,
                ),
                gapHNormal,
                Container(
                  padding: const EdgeInsets.all(10),
                  child: GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      for(MediaModel media in widget.medias)
                        MediaManagerMedia(media: media, editable: widget.canEdit, onDelete: (){
                          if(!_verifyMinLimitation()){
                            _showVerificationSnackBar(context, 'Vous devez avoir au moins ${widget.min} photo(s)');
                            return;
                          }
                          setState(() {
                            widget.medias.remove(media);
                          });
                        }),
                      if(widget.canAdd && widget.medias.length < widget.max) GestureDetector(
                        onTap: _showMediaSrcDialog,
                        child: const AppContainer(
                          content: Icon(FontAwesomeIcons.solidPlus, color: AppColors.appPrimary),
                        ),
                      ),
                    ]
                  ),
                )
              ],
            ),
          ),
        ),
        if(!cameraPermission) Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.appPrimary,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              Text('La caméra pour l\'application Félicitime est désactivée.\n\Sans permission vous ne pourrez pas ajouter de photos.', style: Theme.of(context).textTheme.bodyMedium),
              TextButton(onPressed: () => openAppSettings(), child: Text('Ouvrir les paramètres de l\'application', style: Theme.of(context).textTheme.bodyMedium)),
            ],
          ),
        ),
      ]
    );
  }
}