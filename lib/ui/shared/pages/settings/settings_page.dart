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
import 'package:cloud_firestore/cloud_firestore.dart';
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
            t.recievingSettings,
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
            t.verification,
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
            bool? confirmDelete = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(t.deleteAccount),
                  content: Text(t.areYouSureYouWantToDeleteYourAccount),
                  actions: <Widget>[
                    TextButton(
                      child: Text(t.no),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    TextButton(
                      child: Text(t.yes),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                );
              },
            );

            if (confirmDelete == true) {
              await context.showLoading(ref.read(authService).deleteAccount);
              if (context.mounted) {
                context.router.replace(const WelcomeRoute());
                Utils.show.toast(context, t.yourAccountDeleted);
              }
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
                      child: Text(t.close),
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
                      child: Text(t.close),
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

      ref.watch(authService).editRecievingMessageSettings(
            canRecieveImages: receiveImages,
            canRecieveAudios: receiveAudios,
            canRecieveVideos: receiveVideos,
          );
      ref.invalidate(getUserStreamWithId);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(t.recieveSettings),
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
            title: Text(t.recieveImage),
            trailing: Switch(
              value: recieveImage.value,
              onChanged: (bool value) {
                updateSettings(value, recieveAudio.value, recieveVideo.value);
              },
            ),
          ),
          ListTile(
            title: Text(t.recieveAudio),
            trailing: Switch(
              value: recieveAudio.value,
              onChanged: (bool value) {
                updateSettings(recieveImage.value, value, recieveVideo.value);
              },
            ),
          ),
          ListTile(
            title: Text(t.recieveVideo),
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

class EmailVerificationScreen extends HookWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance.currentUser!;
    final isEmailVerified = useState(auth.emailVerified);

    Timer? timer;

    void startTimer() {
      timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
        await auth.reload();
        if (auth.emailVerified) {
          isEmailVerified.value = true;
          if (context.mounted) {
            Utils.show.toast(context, t.accountVerified);
            FirebaseFirestore.instance
                .collection("users")
                .doc(auth.uid)
                .update({"isValidated": true});
          }
          timer.cancel();
        }
      });
    }

    if (!isEmailVerified.value) {
      startTimer();
      auth.sendEmailVerification();
    }

    useEffect(() {
      return () => timer?.cancel();
    }, []);

    return isEmailVerified.value
        ? SafeArea(
            child: Center(
              child: Text(t.accountVerified),
            ),
          )
        : SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 35),
                    const SizedBox(height: 30),
                    Center(
                      child: Text(
                        t.checkYourMail,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Center(
                        child: Text(
                          t.sendedMail(email: auth.email!),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    isEmailVerified.value
                        ? Center(child: Text(t.accountVerified))
                        : const Center(child: CircularProgressIndicator()),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Center(
                        child: isEmailVerified.value
                            ? const SizedBox.shrink()
                            : Text(
                                t.verifyingEmail,
                                textAlign: TextAlign.center,
                              ),
                      ),
                    ),
                    const SizedBox(height: 57),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: ElevatedButton(
                        child: Text(t.resend),
                        onPressed: () async {
                          try {
                            await auth.sendEmailVerification();
                          } catch (e) {
                            Future.error('${t.error}: $e');
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
