import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/providers/providers.dart';
import 'package:catt_catt/core/services/auth_service.dart';
import 'package:catt_catt/ui/shared/widgets/custom_image.dart';
import 'package:catt_catt/utils/app_router.dart';
import 'package:catt_catt/utils/constants.dart';
import 'package:catt_catt/utils/extensions.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:catt_catt/utils/styles.dart';
import 'package:catt_catt/utils/utils.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:introduction_screen/introduction_screen.dart';

@RoutePage()
class EditProfilePage extends HookConsumerWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(nameController);
    final lastname = ref.watch(lastNameController);
    final auth = ref.watch(authService);

    final currentUser = ref.watch(userProvider).value;

    final selectedCountry = useState(t.location);
    final birthDate = useState<DateTime?>(null);
    final about = ref.watch(aboutController);
    final imageFiles = useState<List<XFile>>([]);
    final deletedImages = useState<List<String>>([]);
    final hobbies = useState<List<HobbyContext>>([]);
    final gender = useState<GenderContext?>(null);
    final interestedGender = useState<GenderContext?>(null);
    final sexualOrientation = useState<sexualOrientationContext?>(null);
    final lookingFor = useState<List<lookingForContext>>([]);

    final formKey = GlobalKey<FormBuilderState>();
    final introKey = useMemoized(GlobalKey<IntroductionScreenState>.new);
    useEffect(() {
      if (currentUser != null) {
        name.text = currentUser.firstName;
        lastname.text = currentUser.lastName;
        about.text = currentUser.about ?? '';
        selectedCountry.value = currentUser.location;
        birthDate.value = currentUser.birthDate;
        imageFiles.value =
            currentUser.profileImages.map((url) => XFile(url)).toList();
        hobbies.value = currentUser.hobiesAndInterests;
        gender.value = currentUser.gender;
        interestedGender.value = currentUser.interestedGender;
        sexualOrientation.value = currentUser.sexualOrientation;
        lookingFor.value = currentUser.lookingFor;
      }
      return null;
    }, [currentUser]);
    void pickImage(int index) {
      context.showLoading(() async {
        final picker = ImagePicker();
        final selectedImage = await picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 25,
        );
        if (selectedImage != null) {
          try {
            final File imageFile = File(selectedImage.path);
            final inputImage = InputImage.fromFile(imageFile);
            final faceDetector = FaceDetector(
              options: FaceDetectorOptions(
                performanceMode: FaceDetectorMode.accurate,
                minFaceSize: 0.7,
              ),
            );
            final List<Face> faces =
                await faceDetector.processImage(inputImage);

            if (faces.isNotEmpty) {
              if (index < imageFiles.value.length) {
                imageFiles.value[index] = selectedImage;
              } else {
                imageFiles.value.add(selectedImage);
              }
              imageFiles.value = List.from(imageFiles.value);
            } else {
              if (context.mounted) {
                Utils.show.toast(context, t.noFaceDetected);
              }
            }
            faceDetector.close();
          } catch (e) {
            if (context.mounted) {
              Utils.show.toast(context, '${t.noFaceDetected}: $e');
            }
          }
        }
      });
    }

    void removeImage(int index) {
      deletedImages.value.add(imageFiles.value[index].path);

      imageFiles.value.removeAt(index);
      imageFiles.value = List.from(imageFiles.value);
    }

    bool ageValidator(DateTime? date) {
      if (date == null) return false;
      final today = DateTime.now();
      final age = today.year - date.year;
      final isBeforeBirthdayThisYear = (today.month < date.month) ||
          (today.month == date.month && today.day < date.day);
      final adjustedAge = isBeforeBirthdayThisYear ? age - 1 : age;

      if (adjustedAge < 18) {
        return true;
      }
      return false;
    }

    void saveProfile() {
      if (name.text.isNotEmpty &&
          lastname.text.isNotEmpty &&
          birthDate.value.isNotNull &&
          imageFiles.value.isNotEmpty) {
        if (ageValidator(birthDate.value)) {
          Utils.show.toast(context, t.above18);
        } else {
          context.showLoading(
            () async {
              try {
                List<String> imageUrls = [];
                for (var image in imageFiles.value) {
                  var uri = Uri.tryParse(image.path);
                  if (uri == null || !uri.isAbsolute) {
                    final uploadedImage = await auth.uploadImage(
                        pickedFile: image, context: context);
                    imageUrls.add(uploadedImage);
                  } else {
                    imageUrls.add(image.path);
                  }
                }
                for (var imagePath in deletedImages.value) {
                  try {
                    imageUrls.remove(imagePath);
                    //TODO:Design a system to remove images for some reason
                  } catch (e) {
                    Future.error(e);
                  }
                }

                await auth.editProfile(
                  firstName: name.text,
                  lastName: lastname.text,
                  profileImages: imageUrls,
                  birthDate: birthDate.value.toString(),
                  location: selectedCountry.value,
                  hobiesAndInterests: hobbies.value,
                  gender: gender.value,
                  interestedGender: interestedGender.value,
                  lookingFor: lookingFor.value,
                  sexualOrientation: sexualOrientation.value,
                  about: about.text,
                );
              } catch (e) {
                if (context.mounted) {
                  Utils.show.toast(context, 'Error: $e');
                }
              } finally {
                if (context.mounted) {
                  ref.invalidate(userProvider);
                  context.router.replaceAll([const ProfileRoute()]);
                }
              }
            },
          );
        }
      } else {
        Utils.show.toast(context, t.validationProfile);
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 17,
        title: const Text(
          C.title,
          style: TextStyle(
            fontSize: 24,
            color: Colors.deepPurple,
          ),
        ),
      ),
      body: Padding(
        padding: S.edgeInsets.all24,
        child: FormBuilder(
          key: formKey,
          child: IntroductionScreen(
            key: introKey,
            hideBottomOnKeyboard: true,
            pages: [
              PageViewModel(
                titleWidget: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    t.infoAboutYou.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                bodyWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: List.generate(6, (index) {
                        return Stack(
                          children: [
                            GestureDetector(
                              onTap: () => pickImage(index),
                              child: Container(
                                width: 100,
                                height: 100,
                                color: Colors.deepPurple,
                                child: index < imageFiles.value.length
                                    ? (Uri.tryParse(imageFiles
                                                    .value[index].path)
                                                ?.isAbsolute ??
                                            false
                                        ? CustomImage.network(
                                            imageFiles.value[index].path,
                                            fit: BoxFit.cover,
                                            memCacheHeight: 200,
                                          )
                                        : Image.file(
                                            File(imageFiles.value[index].path),
                                            fit: BoxFit.cover,
                                          ))
                                    : const Icon(
                                        Icons.add_a_photo,
                                        size: 40,
                                        color: Colors.white70,
                                      ),
                              ),
                            ),
                            if (index < imageFiles.value.length)
                              Positioned(
                                right: 0,
                                top: 0,
                                child: GestureDetector(
                                  onTap: () => removeImage(index),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 8),
                            Text('Image ${index + 1}'),
                          ],
                        );
                      }),
                    ),
                    S.sizedBox.h24,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: const Color(0xff52388A),
                              borderRadius: S.borderRadius.radius50,
                            ),
                            child: FormBuilderTextField(
                              name: 'firstName',
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                              controller: name,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                              decoration: InputDecoration(
                                hintText: t.name,
                                contentPadding: S.edgeInsets.all20,
                                border: InputBorder.none,
                                hintStyle: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              validator: FormBuilderValidators.required(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: const Color(0xff52388A),
                              borderRadius: S.borderRadius.radius50,
                            ),
                            child: FormBuilderTextField(
                              name: 'lastName',
                              controller: lastname,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.done,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                              decoration: InputDecoration(
                                hintText: t.lastName,
                                contentPadding: S.edgeInsets.all20,
                                border: InputBorder.none,
                                hintStyle: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              validator: FormBuilderValidators.required(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    S.sizedBox.h24,
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(S.edgeInsets.all20),
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color(0xff52388A)),
                          foregroundColor:
                              WidgetStateProperty.all<Color>(Colors.white),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(selectedCountry.value),
                        ),
                        onPressed: () => showCountryPicker(
                          context: context,
                          showPhoneCode: false,
                          onSelect: (Country country) {
                            selectedCountry.value = country.name;
                          },
                        ),
                      ),
                    ),
                    S.sizedBox.h24,
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff52388A),
                        borderRadius: S.borderRadius.radius50,
                      ),
                      child: FormBuilderDateTimePicker(
                        name: 'birthDate',
                        initialValue: birthDate.value,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white),
                        decoration: InputDecoration(
                          hintText: t.birthDate,
                          contentPadding: S.edgeInsets.all20,
                          border: InputBorder.none,
                          hintStyle: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                        inputType: InputType.date,
                        format: DateFormat('yyyy-MM-dd'),
                        onChanged: (val) => birthDate.value = val,
                      ),
                    ),
                  ],
                ),
              ),
              PageViewModel(
                titleWidget: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    t.hobbies.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                bodyWidget: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: const Color(0xff52388A),
                        borderRadius: S.borderRadius.radius12,
                      ),
                      child: FormBuilderTextField(
                        name: 'about',
                        controller: about,
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: t.about,
                          contentPadding: S.edgeInsets.all20,
                          border: InputBorder.none,
                          hintStyle: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                        maxLines: 5,
                      ),
                    ),
                    ChipsChoice<HobbyContext>.multiple(
                      value: hobbies.value,
                      onChanged: (val) => hobbies.value = val,
                      wrapped: true,
                      runSpacing: 6,
                      choiceCheckmark: true,
                      choiceStyle: C2ChipStyle.filled(
                        borderWidth: 1,
                        borderStyle: BorderStyle.solid,
                        foregroundColor: Colors.deepPurple,
                        color: Colors.grey[300],
                        selectedStyle: const C2ChipStyle(
                          borderColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepPurple,
                        ),
                      ),
                      choiceItems: C2Choice.listFrom(
                        source: HobbyContext.values,
                        value: (i, v) => v,
                        label: (i, v) => t.hobbyList(hobby: v),
                      ),
                    ),
                  ],
                ),
              ),
              PageViewModel(
                titleWidget: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    t.gender,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                bodyWidget: Column(
                  children: [
                    ChipsChoice<GenderContext>.single(
                      value: gender.value,
                      onChanged: (val) => gender.value = val,
                      wrapped: true,
                      choiceCheckmark: true,
                      choiceStyle: C2ChipStyle.filled(
                        borderWidth: 1,
                        borderStyle: BorderStyle.solid,
                        foregroundColor: Colors.deepPurple,
                        color: Colors.grey[300],
                        selectedStyle: const C2ChipStyle(
                          borderColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepPurple,
                        ),
                      ),
                      choiceItems: C2Choice.listFrom(
                        source: GenderContext.values,
                        value: (i, v) => v,
                        label: (i, v) => v.toString(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        t.interestedGender,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    ChipsChoice<GenderContext>.single(
                      value: interestedGender.value,
                      onChanged: (val) => interestedGender.value = val,
                      wrapped: true,
                      choiceCheckmark: true,
                      choiceStyle: C2ChipStyle.filled(
                        borderWidth: 1,
                        borderStyle: BorderStyle.solid,
                        foregroundColor: Colors.deepPurple,
                        color: Colors.grey[300],
                        selectedStyle: const C2ChipStyle(
                          borderColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepPurple,
                        ),
                      ),
                      choiceItems: C2Choice.listFrom(
                        source: GenderContext.values,
                        value: (i, v) => v,
                        label: (i, v) => v.toString(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        t.sexualOrientation,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    ChipsChoice<sexualOrientationContext>.single(
                      value: sexualOrientation.value,
                      onChanged: (val) => sexualOrientation.value = val,
                      wrapped: true,
                      choiceCheckmark: true,
                      choiceStyle: C2ChipStyle.filled(
                        borderWidth: 1,
                        borderStyle: BorderStyle.solid,
                        foregroundColor: Colors.deepPurple,
                        color: Colors.grey[300],
                        selectedStyle: const C2ChipStyle(
                          borderColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepPurple,
                        ),
                      ),
                      choiceItems: C2Choice.listFrom(
                        source: sexualOrientationContext.values,
                        value: (i, v) => v,
                        label: (i, v) =>
                            t.sexualOrientationList(sexualOrientation: v),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        t.lookingFor,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    ChipsChoice<lookingForContext>.multiple(
                      value: lookingFor.value,
                      onChanged: (val) => lookingFor.value = val,
                      wrapped: true,
                      choiceCheckmark: true,
                      choiceStyle: C2ChipStyle.filled(
                        borderWidth: 1,
                        borderStyle: BorderStyle.solid,
                        foregroundColor: Colors.deepPurple,
                        color: Colors.grey[300],
                        selectedStyle: const C2ChipStyle(
                          borderColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepPurple,
                        ),
                      ),
                      choiceItems: C2Choice.listFrom(
                        source: lookingForContext.values,
                        value: (i, v) => v,
                        label: (i, v) => t.lookingForList(lookingFor: v),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            onDone: saveProfile,
            showNextButton: true,
            showDoneButton: true,
            next: Text(
              t.next.toUpperCase(),
              style: const TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.w600,
              ),
            ),
            done: Text(
              t.done.toUpperCase(),
              style: const TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
