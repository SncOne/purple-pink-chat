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
              const Text('Filter',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Wrap(
            spacing: 8.0,
            children: [
              Chip(label: Text('America')),
              Chip(label: Text('Turkey')),
              Chip(label: Text('Russia')),
              Chip(label: Text('+2')),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Relationship',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ToggleButtons(
            isSelected: [
              relationshipController.value == 'Lover',
              relationshipController.value == 'Friend',
              relationshipController.value == 'Both',
            ],
            onPressed: (int index) {
              relationshipController.value = ['Lover', 'Friend', 'Both'][index];
            },
            children: const [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Lover')),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Friend')),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Both')),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Sex',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ToggleButtons(
            isSelected: [
              genderController.value == 'Male',
              genderController.value == 'Female',
              genderController.value == 'Everyone',
            ],
            onPressed: (int index) {
              genderController.value = ['Male', 'Female', 'Everyone'][index];
            },
            children: const [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Male')),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Female')),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Everyone')),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Age',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
            child: const Text('Apply'),
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
