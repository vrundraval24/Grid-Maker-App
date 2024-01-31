import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grid_maker/cubits/gallery_cubit.dart';
import 'package:grid_maker/routes/app_route_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final galleryCubit = BlocProvider.of<GalleryCubit>(context);
    Size mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('GRID MAKER'),
        titleTextStyle: const TextStyle(
          letterSpacing: 7,
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: mq.width * 0.14,
                  vertical: mq.height * 0.24,
                ),
                child: Image.asset('assets/grid_logo.png'),
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await galleryCubit.openGallery(mq).then(
                      (imageModel) {
                        // context.goNamed(
                        //   AppRouteConstants.addGridPageRouteName,
                        //   extra: imageModel,
                        // );

                        // context.pushNamed(
                        //   AppRouteConstants.addGridPageRouteName,
                        //   extra: imageModel,
                        // );

                        GoRouter.of(context).pushNamed(
                          AppRouteConstants.addGridPageRouteName,
                          extra: imageModel,
                        );

                        // SIMPLE WAY TO NAVIGATE
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => AddGridPage(
                        //       image: imageModel,
                        //     ),
                        //   ),
                        // );
                      },
                    );
                  } catch (error) {
                    log("Error occurred while getting image from gallery: $error");
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                        side: const BorderSide(color: Colors.black))),
                child: const Text(
                  'GALLERY',
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
