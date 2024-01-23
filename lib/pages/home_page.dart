import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_maker/cubits/gallery_cubit.dart';
import 'package:grid_maker/pages/add_grid_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final galleryCubit = BlocProvider.of<GalleryCubit>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('GRID MAKER'),
          titleTextStyle: const TextStyle(
              letterSpacing: 7,
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(50),
                child: Image.asset('assets/group.png'),
              ),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await galleryCubit.openGallery().then((imagePath) {
                        if (imagePath != '') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddGridPage(imagePath: imagePath)));
                        }
                      });
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
              )
            ],
          ),
        ));
  }
}