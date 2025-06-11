import 'package:echo_compliments_memories_198_a/m/color_as.dart';
import 'package:echo_compliments_memories_198_a/m/kampliment_prov.dart';
import 'package:echo_compliments_memories_198_a/m/onb_as.dart';
import 'package:echo_compliments_memories_198_a/three_screen/hive/memory_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'm/mirror_entry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  Hive.registerAdapter(MemoryModelAdapter());
  await Hive.openBox<MemoryModel>('memories');
  Hive.registerAdapter(MirrorEntryAdapter());
  await Hive.openBox<MirrorEntry>('mirror_entries');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        child: ChangeNotifierProvider(
          create: (context) => KamplimentProv(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Echo',
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                backgroundColor: ColorAs.background,
              ),
              scaffoldBackgroundColor: ColorAs.background,
              // fontFamily: '-_- ??',
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
            ),
            home: const AsOnBoDi(),
          ),
        ));
  }
}
