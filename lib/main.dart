// ignore_for_file: unused_field

import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/foundation.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:webtest/utils/dependences.dart';
import 'package:webtest/widgets/bottom_nav.dart';
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

class SidebarPage extends StatefulWidget {
  const SidebarPage({Key? key}) : super(key: key);

  @override
  _SidebarPageState createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  List<CollapsibleItem>? _items;
  String? _headline;
  final AssetImage _avatarImg = const AssetImage(Assets.memoji10);

  @override
  void initState() {
    super.initState();
    _items = _generateItems;
    _headline = _items?.firstWhere((item) => item.isSelected).text;
  }

  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    const Wallet(),
    const Stats(),
    const Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'Dashboard',
        icon: Icons.assessment,
        onPressed: () => setState(() => _onItemTapped(1)),
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'Ice-Cream',
        icon: Icons.icecream,
        onPressed: () => setState(() => _onItemTapped(2)),
      ),
      CollapsibleItem(
        text: 'Search',
        icon: Icons.search,
        onPressed: () => setState(() => _onItemTapped(3)),
      ),
      CollapsibleItem(
        text: 'Notifications',
        icon: Icons.notifications,
        onPressed: () => setState(() => _onItemTapped(0)),
      ),
      CollapsibleItem(
        text: 'Settings',
        icon: Icons.settings,
        onPressed: () => setState(() => _onItemTapped(1)),
      ),
      CollapsibleItem(
        text: 'Home',
        icon: Icons.home,
        onPressed: () => setState(() => _onItemTapped(1)),
      ),
      CollapsibleItem(
        text: 'Alarm',
        icon: Icons.access_alarm,
        onPressed: () => setState(() => _onItemTapped(1)),
      ),
      CollapsibleItem(
        text: 'Eco',
        icon: Icons.eco,
        onPressed: () => setState(() => _onItemTapped(1)),
      ),
      CollapsibleItem(
        text: 'Event',
        icon: Icons.event,
        onPressed: () => setState(() => _onItemTapped(1)),
      ),
      CollapsibleItem(
        text: 'Email',
        icon: Icons.email,
        onPressed: () => setState(() => _onItemTapped(1)),
      ),
      CollapsibleItem(
        text: 'Face',
        icon: Icons.face,
        onPressed: () => setState(() => _onItemTapped(1)),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: CollapsibleSidebar(
        isCollapsed: true,
        items: _items!,
        avatarImg: _avatarImg,
        title: 'Farhan',
        onTitleTap: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Yay! Flutter Collapsible Sidebar!')));
        },
        body: _body(size, context),
        backgroundColor: Colors.black,
        selectedTextColor: const Color.fromARGB(255, 176, 191, 8),
        textStyle: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
        titleStyle: const TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
        toggleTitleStyle:
            const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        // sidebarBoxShadow: const [
        //   BoxShadow(
        //     color: Colors.indigo,
        //     blurRadius: 20,
        //     spreadRadius: 0.01,
        //     offset: Offset(3, 3),
        //   ),
        //   BoxShadow(
        //     color: Colors.green,
        //     blurRadius: 50,
        //     spreadRadius: 0.01,
        //     offset: Offset(3, 3),
        //   ),
        // ],
      ),
    );
  }

  Widget _body(Size size, BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.blueGrey[50],
      child: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
