import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/models/user.dart';
import 'package:catt_catt/core/providers/providers.dart';
import 'package:catt_catt/core/services/auth_service.dart';
import 'package:catt_catt/ui/shared/widgets/touchable_opacity.dart';
import 'package:catt_catt/utils/app_router.dart';
import 'package:catt_catt/utils/constants.dart';
import 'package:catt_catt/utils/extensions.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:catt_catt/utils/styles.dart';
import 'package:catt_catt/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsWidget extends HookConsumerWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            "Recieving Image/Audio/Video",
            style: S.textStyles.font16White,
          ),
          trailing: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          onTap: () {
            Utils.show.settings(
              context,
              const RecievingSettingsPage(),
            );
          },
        ),
        ListTile(
          title: Text(
            "Verification",
            style: S.textStyles.font16White,
          ),
          trailing: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          onTap: () {
            Utils.show.settings(
              context,
              const EmailVerificationScreen(),
            );
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

class RecievingSettingsPage extends HookConsumerWidget {
  const RecievingSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userProvider);
    final UserModel? user = userAsyncValue.value;
    final recieveImage = useState(user!.canRecieveImages);
    final recieveAudio = useState(user.canRecieveAudios);
    final recieveVideo = useState(user.canRecieveVideos);

    Future<void> updateSettings(
      bool receiveImages,
      bool receiveAudios,
      bool receiveVideos,
    ) async {
      recieveImage.value = receiveImages;
      recieveAudio.value = receiveAudios;
      recieveVideo.value = receiveVideos;

      ref.read(authService).editRecievingMessageSettings(
            canRecieveImages: receiveImages,
            canRecieveAudios: receiveAudios,
            canRecieveVideos: receiveVideos,
          );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Recieving Settings"),
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
            title: const Text("Receive Images"),
            trailing: Switch(
              value: recieveImage.value,
              onChanged: (bool value) {
                updateSettings(value, recieveAudio.value, recieveVideo.value);
              },
            ),
          ),
          ListTile(
            title: const Text("Receive Audios"),
            trailing: Switch(
              value: recieveAudio.value,
              onChanged: (bool value) {
                updateSettings(recieveImage.value, value, recieveVideo.value);
              },
            ),
          ),
          ListTile(
            title: const Text("Receive Videos"),
            trailing: Switch(
              value: recieveVideo.value,
              onChanged: (bool value) {
                updateSettings(recieveImage.value, recieveAudio.value, value);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isEmailVerified = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      Utils.show.toast(context, "Your account is verified succesfully");

      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance.currentUser!;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 35),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Check your \n Email',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                    'We have sent you a Email on ${auth.email}',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                    'Verifying email....',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 57),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ElevatedButton(
                  child: const Text('Resend'),
                  onPressed: () {
                    try {
                      FirebaseAuth.instance.currentUser
                          ?.sendEmailVerification();
                    } catch (e) {
                      debugPrint('$e');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
