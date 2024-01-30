import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_maker/cubits/add_grid_cubit.dart';
import 'package:grid_maker/cubits/gallery_cubit.dart';
import 'package:grid_maker/cubits/save_image_cubit.dart';
import 'package:grid_maker/routes/app_route_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GalleryCubit(),
        ),
        BlocProvider(
          create: (context) => AddGridCubit(),
        ),
        BlocProvider(
          create: (context) => SaveImageCubit(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Grid Maker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.black,
            primary: Colors.black,
          ),
          useMaterial3: true,
        ),
        routerConfig: AppRouteConfig().goRouter,
      ),
    );
  }
}
