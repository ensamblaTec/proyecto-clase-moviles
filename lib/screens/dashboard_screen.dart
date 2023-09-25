import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:pmsn20232/services/local_storage.dart';
import 'package:pmsn20232/services/theme_provider.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenidos :)'),
        centerTitle: true,
      ),
      drawer: createDrawer(context),
    );
  }

  Widget createDrawer(BuildContext context) {
    final changeTheme = Provider.of<ThemeProvider>(context);
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://media.tenor.com/pF3s48bhdIsAAAAM/marin-kitagawa-anime-shy.gif'),
              ),
              accountName: Text('@ensamblaTec'),
              accountEmail: Text('Tiburonsin')),
          ListTile(
            // leading: Image.network(
            // 'https://www.icegif.com/wp-content/uploads/icegif-2013.gif'),
            leading: Image.asset('assets/rocket.png'),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Fruit App'),
            subtitle: const Text('Carrousel'),
            onTap: () => {},
          ),
          ListTile(
            leading:  const Icon(Icons.task_alt_outlined),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Task Manager'),
            onTap: () {
              Navigator.pushNamed(context, '/task');
            },
          ),
          DayNightSwitcher(
            isDarkModeEnabled: changeTheme.isLightTheme,
            onStateChanged: (isDarkModeEnabled) {
              changeTheme.isLightTheme = isDarkModeEnabled;
              LocalStorage.prefs.setBool('isThemeLight', isDarkModeEnabled);
            },
          ),
          ListTile(
                title: const Text("Sign Out"),
                trailing: const Icon(Icons.exit_to_app),
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                  LocalStorage.prefs.setBool('isActiveSession', false);
                },
              ),
        ],
      ),
    );
  }
}
