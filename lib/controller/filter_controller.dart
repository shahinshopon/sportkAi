import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sportkai/models/filter_model.dart';

class FilterController extends GetxController {
  var box = GetStorage();

  // Observable lists and variables
  var sexList = <Sex>[].obs;
  var selectedSex = ''.obs;

  var ageList = <Age>[].obs;
  var selectedAge = Rx<Age?>(null);

  var locationList = <Location>[].obs;
  var selectedLocation = Rx<Location?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchSexsFromStorage();
    fetchAgesFromStorage();
    fetchLocationFromStorage();
  }

  void fetchSexsFromStorage() {
    List<dynamic> jsonData = box.read('profileData')['message']['filters']['genders'] ?? [];
    sexList.value = parseSexs(jsonData);
    if (sexList.isNotEmpty) {
      selectedSex.value = sexList.first.name;
    }
  }

  List<Sex> parseSexs(List<dynamic> jsonData) {
    return jsonData.map((json) => Sex.fromJson(json)).toList();
  }

  void fetchAgesFromStorage() {
    List<dynamic> jsonData = box.read('profileData')['message']['filters']['ages'] ?? [];
    ageList.value = parseAges(jsonData);
    if (ageList.isNotEmpty) {
      selectedAge.value = ageList.first;
    }
  }

  List<Age> parseAges(List<dynamic> jsonData) {
    return jsonData.map((json) => Age.fromJson(json)).toList();
  }

  void fetchLocationFromStorage() {
    List<dynamic> jsonData = box.read('profileData')['message']['filters']['locations'] ?? [];
    locationList.value = parseLocations(jsonData);
    if (locationList.isNotEmpty) {
      selectedLocation.value = locationList.first;
    }
  }

  List<Location> parseLocations(List<dynamic> jsonData) {
    return jsonData.map((json) => Location.fromJson(json)).toList();
  }

  void clearFilterData() {
    box.remove('filterData');
    Get.snackbar('Success', 'Filter Data Removed');
  }

  void addFilterData() {
    try {
      Map<String, dynamic> filterData = {
        'sex': selectedSex.value,
        'age': 'U${selectedAge.value?.name}',
        'location': selectedLocation.value?.name,
      };
      box.write('filterData', filterData);
      Get.snackbar('Success', 'Filter Data Added');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
