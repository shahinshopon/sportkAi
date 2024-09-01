import 'package:flutter/material.dart';
import 'package:sportkai/controller/filter_controller.dart';
import 'package:sportkai/models/filter_model.dart';
import 'package:sportkai/const/app_colors.dart';
import 'package:sportkai/widgets/app_button.dart';
import 'package:get/get.dart';
import 'package:sportkai/widgets/app_text.dart';

class FilterScreen extends StatelessWidget {
   FilterScreen({super.key});
  final FilterController controller = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
     var screenWidth = MediaQuery.of(context).size.width;
     var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Filter'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.close),
        ),
      ),
      body: Padding(
        padding:screenWidth>600?EdgeInsets.symmetric(vertical: 10,horizontal: screenWidth/10): const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Select Sex',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
            SizedBox(
              height:screenHeight>1000?screenHeight/5.5:screenHeight>865?screenHeight/4.8:screenHeight>650?screenHeight/4: MediaQuery.of(context).size.height/3.5,
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.sexList.length,
                  itemBuilder: (context, index) {
                    final sex = controller.sexList[index];
                    return Obx(() => CheckboxListTile(
                          title: appSubTitleText(sex.name),
                          value: controller.selectedSex.value == sex.name,
                          onChanged: (bool? value) {
                            if (value == true) {
                              controller.selectedSex.value = sex.name;
                            }
                          },
                        ));
                  },
                );
              }),
            ),
            const Text('Select Age',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
            const SizedBox(height: 10),
            Obx(() => Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Age>(
                      isExpanded: true,
                      value: controller.selectedAge.value,
                      items: controller.ageList.map((Age age) {
                        return DropdownMenuItem<Age>(
                          value: age,
                          child: appSubTitleText('U${age.name}'),
                        );
                      }).toList(),
                      onChanged: (Age? newValue) {
                        controller.selectedAge.value = newValue;
                      },
                    ),
                  ),
                )),
            const SizedBox(height: 10),
            const Text('Select Location',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            Obx(() => Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Location>(
                      isExpanded: true,
                      value: controller.selectedLocation.value,
                      items: controller.locationList.map((Location location) {
                        return DropdownMenuItem<Location>(
                          value: location,
                          child: appSubTitleText(location.name),
                        );
                      }).toList(),
                      onChanged: (Location? newValue) {
                        controller.selectedLocation.value = newValue;
                      },
                    ),
                  ),
                )),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                reuseableButton(MediaQuery.of(context).size.width / 2.5,
                    buttonOptionalColor, () {
                  controller.clearFilterData();
                }, 'Clear', buttonPrimaryColor, buttonPrimaryColor),
                reuseableButton(
                    MediaQuery.of(context).size.width / 2.5, buttonPrimaryColor,
                    () {
                  controller.addFilterData();
                }, 'Add Filter', Colors.white, buttonPrimaryColor),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
