import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/providers/providers.dart';
import 'package:catt_catt/core/services/auth_service.dart';
import 'package:catt_catt/ui/shared/widgets/custom_image.dart';
import 'package:catt_catt/ui/shared/widgets/touchable_opacity.dart';
import 'package:catt_catt/utils/app_router.dart';
import 'package:catt_catt/utils/assets.dart';
import 'package:catt_catt/utils/constants.dart';
import 'package:catt_catt/utils/extensions.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:catt_catt/utils/styles.dart';
import 'package:catt_catt/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class RegisterPage extends HookConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(emailController);
    final password = ref.watch(passwordController);
    final auth = ref.watch(authService);

    final formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: AppBar(
        elevation: 17,
        title: TouchableOpacity(
          onTap: () => context.router.replace(const LoginRoute()),
          child: const Text(
            C.title,
            style: TextStyle(
              fontSize: 24,
              color: Colors.deepPurple,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: S.edgeInsets.all24,
        child: FormBuilder(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  t.register,
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              S.sizedBox.h32,
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff52388A),
                  borderRadius: S.borderRadius.radius50,
                ),
                child: FormBuilderTextField(
                  controller: email,
                  name: 'email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: t.email,
                    contentPadding: S.edgeInsets.all20,
                    border: InputBorder.none,
                    hintStyle:
                        const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                ),
              ),
              S.sizedBox.h12,
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff52388A),
                  borderRadius: S.borderRadius.radius50,
                ),
                child: FormBuilderTextField(
                  controller: password,
                  name: 'password',
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: t.password,
                    contentPadding: S.edgeInsets.all20,
                    hintStyle:
                        const TextStyle(fontSize: 12, color: Colors.white),
                    border: InputBorder.none,
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(9),
                  ]),
                ),
              ),
              FormBuilderCheckbox(
                name: 'terms_of_use',
                title: TouchableOpacity(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      scrollable: true,
                      title: Text(t.termsOfUse),
                      content: const Text(C.termsOfUse),
                      actions: <Widget>[
                        TouchableOpacity(
                          child: Text(t.close),
                          onTap: () => context.maybePop(),
                        ),
                      ],
                    ),
                  ),
                  child: Text(t.termsOfUse),
                ),
                validator: FormBuilderValidators.required(),
              ),
              FormBuilderCheckbox(
                name: 'privacy_policy',
                title: TouchableOpacity(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      scrollable: true,
                      title: Text(t.privacyPolicy),
                      content: const Text(C.privacyPolicy),
                      actions: <Widget>[
                        TouchableOpacity(
                          child: Text(t.close),
                          onTap: () => context.maybePop(),
                        ),
                      ],
                    ),
                  ),
                  child: Text(t.privacyPolicy),
                ),
                validator: FormBuilderValidators.required(),
              ),
              S.sizedBox.h32,
              TouchableOpacity(
                child: Container(
                  padding: S.edgeInsets.all20,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.deepPurple, Colors.pinkAccent],
                    ),
                    borderRadius: S.borderRadius.radius50,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        t.register,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      S.sizedBox.w24,
                      CustomImage.asset(
                        R.icons.send,
                        svgColor: Colors.white,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  final validated = formKey.currentState!.validate();
                  if (validated) {
                    context.showLoading(() async {
                      try {
                        await auth.register(
                          email: email.text,
                          password: password.text,
                          context: context,
                        );
                        if (context.mounted) {
                          context.router.replace(const CreateProfileRoute());
                        }
                      } catch (e) {
                        if (context.mounted) {
                          Utils.show.toast(context, "${t.registerFailed}:$e");
                        }
                      }
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
