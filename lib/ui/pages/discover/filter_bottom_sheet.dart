import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterBottomSheet extends HookConsumerWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genderController = useState<String?>(null);
    final relationshipController = useState<String?>(null);
    final ageRangeController =
        useState<SfRangeValues>(const SfRangeValues(20, 40));

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Color(0xFFD8BFD8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(t.filter,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 16),
          Text(t.lookingFor,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ToggleButtons(
            isSelected: [
              relationshipController.value == 'longTermPartner',
              relationshipController.value == 'shortTermPartner',
              relationshipController.value == 'longTermOpenRelationship',
              relationshipController.value == 'shortTermOpenRelationship',
              relationshipController.value == 'newFriends',
              relationshipController.value == 'stillFiguringOut',
              relationshipController.value == 'Everyone',
            ],
            onPressed: (int index) {
              relationshipController.value = [
                'longTermPartner',
                'shortTermPartner',
                'longTermOpenRelationship',
                'shortTermOpenRelationship',
                'newFriends',
                'stillFiguringOut',
                'Everyone'
              ][index];
            },
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(t.lookingForList(
                      lookingFor: lookingForContext.longTermPartner))),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(t.lookingForList(
                      lookingFor: lookingForContext.shortTermPartner))),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(t.lookingForList(
                      lookingFor: lookingForContext.longTermOpenRelationship))),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(t.lookingForList(
                      lookingFor:
                          lookingForContext.shortTermOpenRelationship))),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(t.lookingForList(
                      lookingFor: lookingForContext.newFriends))),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(t.lookingForList(
                      lookingFor: lookingForContext.stillFiguringOut))),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(t.everyone)),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Sex',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ToggleButtons(
            isSelected: [
              genderController.value == 'male',
              genderController.value == 'female',
              genderController.value == 'Everyone',
            ],
            onPressed: (int index) {
              genderController.value = ['male', 'female', 'Everyone'][index];
            },
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(t.genderList(gender: GenderContext.male))),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(t.genderList(gender: GenderContext.female))),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(t.everyone)),
            ],
          ),
          const SizedBox(height: 16),
          Text(t.age,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SfRangeSlider(
            min: 18.0,
            max: 100.0,
            values: ageRangeController.value,
            onChanged: (SfRangeValues values) {
              ageRangeController.value = values;
            },
            interval: 10,
            showTicks: true,
            showLabels: true,
            enableTooltip: true,
            minorTicksPerInterval: 1,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ref.read(filtersProvider.notifier).state = Filters(
                gender: genderController.value,
                relationship: relationshipController.value,
                minAge: ageRangeController.value.start.toInt(),
                maxAge: ageRangeController.value.end.toInt(),
              );
              Navigator.of(context).pop();
            },
            child: Text(t.apply),
          ),
        ],
      ),
    );
  }
}

class Filters {
  String? gender;
  String? relationship;
  int? minAge;
  int? maxAge;

  Filters({this.gender, this.relationship, this.minAge, this.maxAge});
}

final filtersProvider = StateProvider<Filters>((ref) {
  return Filters();
});
