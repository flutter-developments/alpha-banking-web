import 'package:responsive_builder/responsive_builder.dart';
import 'package:webtest/utils/exports.dart';
import 'package:universal_html/html.dart' as html;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      final loader = html.document.getElementsByClassName('loading');
      if (loader.isNotEmpty) {
        loader.first.remove();
      }
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => ViewModel())],
        child: MaterialApp(
          title: 'Flutter Web test',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'DMSans',
            primaryColor: Styles.primaryColor,
            backgroundColor: Styles.primaryColor,
          ),
          home: ResponsiveBuilder(
            builder: (context, sizingInformation) {
              // Check the sizing  information here and return your UI
              if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.desktop) {
                return const SidebarPage();
              }

              if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.mobile) {
                return const BottomNav();
              }

              return const SidebarPage();
            },
          ),
        ));
  }
}
