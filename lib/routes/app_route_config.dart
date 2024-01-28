import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grid_maker/models/image_model.dart';
import 'package:grid_maker/pages/add_grid_page.dart';
import 'package:grid_maker/pages/home_page.dart';
import 'package:grid_maker/routes/app_route_constants.dart';

class AppRouteConfig {
  GoRouter goRouter = GoRouter(
    initialLocation: '/homePage',
    routes: [
      GoRoute(
        name: AppRouteConstants.homePageRouteName,
        path: '/homePage',
        pageBuilder: (context, state) {
          return MaterialPage(child: HomePage());
        },
      ),
      GoRoute(
        name: AppRouteConstants.addGridPageRouteName,
        path: '/addGridPage',
        pageBuilder: (context, state) {
          ImageModel imageModel = state.extra as ImageModel;
          return MaterialPage(child: AddGridPage(image: imageModel));
        },
      )
    ],
  );
}
