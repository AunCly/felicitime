import 'dart:io';

import 'package:felicitime/config/colors.dart';
import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/capsules/model/moment.dart';
import 'package:felicitime/features/capsules/ui/widgets/capsule_list_tile.dart';
import 'package:felicitime/ui/widgets/back_home.dart';
import 'package:felicitime/ui/widgets/images_gallery_details.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../ui/widgets/badge.dart';

class ShowMoment extends StatefulWidget {
  const ShowMoment({super.key, required this.moment});

  final Moment moment;

  @override
  State<ShowMoment> createState() => _ShowMomentState();
}

class _ShowMomentState extends State<ShowMoment> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BackHome(),
            Text('Moments.', style: Theme.of(context).textTheme.headlineLarge),
            gapHNormal,
            Text(widget.moment.capsule.title, style: Theme.of(context).textTheme.titleMedium,),
            gapHNormal,
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: AppColors.appGrey.withValues(alpha: 0.3)),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.4,
                      width: double.infinity,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: widget.moment.medias.length,
                        itemBuilder: (context, index) {
                          final image = Image.file(
                            File(widget.moment.medias[index].path),
                            fit: BoxFit.cover,
                          );
                          return GestureDetector(
                            onTap: () => Navigator.push(context, PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => ImagesGalleryDetails(images: widget.moment.medias, initialIndex: index),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
                            )),
                            child: index == 0
                              ? Hero(
                                  tag: widget.moment.medias.first.path,
                                  flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        File(widget.moment.medias.first.path),
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                  child: image,
                                )
                              : image,
                          );
                        },
                      ),
                    ),
                  ),
                  gapHNormal,
                  Center(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: widget.moment.medias.length,
                      effect: ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: Theme.of(context).colorScheme.primary,
                        dotColor: AppColors.appGrey,
                      ),
                    ),
                  )
                ],
              ),
            ),
            gapHNormal,
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children : [
                  AppBadge(
                    color: AppColors.appPink,
                    text: DateFormat('dd/MM/yyyy').format(widget.moment.createdAt),
                    icon: FontAwesomeIcons.lightCalendar,
                  ),
                  gapHNormal,
                  Text(widget.moment.capsule.description, style: Theme.of(context).textTheme.bodyMedium),
                ]
              )
            ),
            gapHNormal,
            if(widget.moment.comment != '') Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Vous avez ajouté :', style: Theme.of(context).textTheme.titleMedium,),
                gapHNormal,
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(widget.moment.comment!, style: Theme.of(context).textTheme.bodyMedium)
                ),
              ]
            )
          ]
        )
      )
    );
  }
}
