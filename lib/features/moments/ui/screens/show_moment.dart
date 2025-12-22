import 'dart:io';

import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/capsules/model/moment.dart';
import 'package:felicitime/features/capsules/ui/widgets/capsule_list_tile.dart';
import 'package:felicitime/ui/widgets/images_gallery_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowMoment extends StatelessWidget {
  const ShowMoment({super.key, required this.moment});

  final Moment moment;

  @override
  Widget build(BuildContext context) {

    print(moment);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add your moment display widgets here
            Text('La Capsule associée à ce moment :', style: Theme.of(context).textTheme.titleMedium,),
            gapHNormal,
            CapsuleListTile(capsule: moment.capsule, canValidate: false,),
            gapHNormal,
            Text('Votre moment enregistré le ${DateFormat('dd/mm/yyyy').format(moment.createdAt)}', style: Theme.of(context).textTheme.titleMedium,),
            gapHNormal,
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ImagesGalleryDetails(images: moment.medias))),
              child: Hero(
                tag: 'image_details_${moment.createdAt}',
                child: Stack(
                  children: [
                    SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(moment.medias.first.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text('1/${moment.medias.length}', style: Theme.of(context).textTheme.bodySmall),
                      ),
                    )
                  ],
                )
              ),
            ),
            if(moment.comment != null) Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                gapHNormal,
                Text('Votre commentaire :', style: Theme.of(context).textTheme.titleMedium,),
                gapHNormal,
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(moment.comment!, style: Theme.of(context).textTheme.bodyMedium)
                ),
              ]
            )
          ],
        ),
      ),
    );
  }
}
