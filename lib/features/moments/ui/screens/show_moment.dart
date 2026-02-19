import 'dart:io';

import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/capsules/model/moment.dart';
import 'package:felicitime/features/capsules/ui/widgets/capsule_list_tile.dart';
import 'package:felicitime/ui/widgets/arrow_go.dart';
import 'package:felicitime/ui/widgets/back_home.dart';
import 'package:felicitime/ui/widgets/images_gallery_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowMoment extends StatelessWidget {
  const ShowMoment({super.key, required this.moment});

  final Moment moment;

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: 'image_details_${moment.createdAt}',
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.4,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.file(
                      File(moment.medias.first.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 10,
                  child: BackHome(),
                ),
                if(moment.medias.length > 1) Positioned(
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
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Text('La capsule associée à ce moment :', style: Theme.of(context).textTheme.titleMedium,),
                gapHNormal,
                CapsuleListTile(capsule: moment.capsule, canValidate: false,),
                gapHNormal,
                Text('Votre moment enregistré le ${DateFormat('dd/MM/yyyy').format(moment.createdAt)}', style: Theme.of(context).textTheme.titleMedium,),
                gapHNormal,
                if(moment.comment != '') Column(
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
              ]
            )
          )
        ],
      )
    );
  }
}
