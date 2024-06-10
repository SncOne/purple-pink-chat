import 'package:catt_catt/utils/utils.dart';
import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Notification'),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            Utils.show.settings(context, const NotificationSettingsPage());
          },
        ),
        ListTile(
          title: const Text('Photos & Videos'),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Chat history backup'),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Delete account'),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Privacy'),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Help Center'),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {},
        ),
        ListTile(
          title: const Text('About (name of the app)'),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {},
        ),
      ],
    );
  }
}

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  _NotificationSettingsPageState createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool notificationEnabled = true;
  bool vibrationEnabled = true;
  bool messagePreviewEnabled = true;
  String selectedSound = 'Bell';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: const Text('Notification'),
            trailing: Switch(
              value: notificationEnabled,
              onChanged: (bool value) {
                setState(() {
                  notificationEnabled = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Sound'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(selectedSound),
                const Icon(Icons.arrow_forward),
              ],
            ),
            onTap: () {
              // Handle sound selection
            },
          ),
          ListTile(
            title: const Text('Vibration'),
            trailing: Switch(
              value: vibrationEnabled,
              onChanged: (bool value) {
                setState(() {
                  vibrationEnabled = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Messages preview'),
            subtitle: const Text('Get previews of messages in notification'),
            trailing: Switch(
              value: messagePreviewEnabled,
              onChanged: (bool value) {
                setState(() {
                  messagePreviewEnabled = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
