import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/services/auth_service.dart';
import 'package:catt_catt/ui/shared/widgets/touchable_opacity.dart';
import 'package:catt_catt/utils/app_router.dart';
import 'package:catt_catt/utils/constants.dart';
import 'package:catt_catt/utils/extensions.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:catt_catt/utils/styles.dart';
import 'package:catt_catt/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsWidget extends ConsumerWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            t.notification,
            style: S.textStyles.font16White,
          ),
          trailing: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          onTap: () {
            Utils.show.settings(context, const NotificationSettingsPage());
          },
        ),
        // ListTile(
        //   title: const Text('Photos & Videos'),
        //   trailing: const Icon(
        //     Icons.arrow_forward,
        //     color: Colors.white,
        //   ),
        //   onTap: () {
        //     Utils.show.toast(context, t.willBeImplemented);
        //   },
        // ),
        ListTile(
          title: Text(
            t.chatHistory,
            style: S.textStyles.font16White,
          ),
          trailing: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          onTap: () {
            Utils.show.toast(context, t.willBeImplemented);
          },
        ),
        ListTile(
          title: Text(
            t.deleteAccount,
            style: S.textStyles.font16White,
          ),
          trailing: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          onTap: () async {
            await context.showLoading(
              ref.read(authService).deleteAccount,
            );
            if (context.mounted) {
              Utils.show.toast(context, t.yourAccountDeleted);
              context.router.replace(const WelcomeRoute());
            }
          },
        ),
        ListTile(
          title: Text(
            t.privacyPolicy,
            style: S.textStyles.font16White,
          ),
          trailing: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,
                  title: Text(t.privacyPolicy),
                  content: const Text(C.privacyPolicy),
                  actions: <Widget>[
                    TouchableOpacity(
                      child: const Text('Close'),
                      onTap: () => context.maybePop(),
                    ),
                  ],
                );
              },
            );
          },
        ),
        ListTile(
          title: Text(
            t.termsOfUse,
            style: S.textStyles.font16White,
          ),
          trailing: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,
                  title: Text(t.termsOfUse),
                  content: const Text(C.termsOfUse),
                  actions: <Widget>[
                    TouchableOpacity(
                      child: const Text('Close'),
                      onTap: () => context.maybePop(),
                    ),
                  ],
                );
              },
            );
          },
        ),
        ListTile(
          title: Text(
            t.helpCenter,
            style: S.textStyles.font16White,
          ),
          trailing: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          onTap: () {
            Utils.show.toast(context, t.willBeImplemented);
          },
        ),
        ListTile(
          title: Text(
            t.aboutLoveLens,
            style: S.textStyles.font16White,
          ),
          trailing: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          onTap: () {
            Utils.show.toast(context, t.willBeImplemented);
          },
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
        title: Text(t.notification),
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
            title: Text(t.notification),
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
            title: Text(t.sound),
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
            title: Text(t.vibration),
            trailing: Switch(
              value: vibrationEnabled,
              onChanged: (bool value) {
                setState(() {
                  vibrationEnabled = value;
                });
              },
            ),
          ),
          // ListTile(
          //   title: const Text('Messages preview'),
          //   subtitle: const Text('Get previews of messages in notification'),
          //   trailing: Switch(
          //     value: messagePreviewEnabled,
          //     onChanged: (bool value) {
          //       setState(() {
          //         messagePreviewEnabled = value;
          //       });
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
