import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fire_respondents/components/custom_button.dart';
import 'package:fire_respondents/components/custom_text.dart';
import '../../controllers/home_controller.dart';
import '../../models/category.dart';

class EmergencyMapPage extends ConsumerStatefulWidget {
  const EmergencyMapPage({super.key});

  @override
  ConsumerState<EmergencyMapPage> createState() => _EmergencyMapPageState();
}

class _EmergencyMapPageState extends ConsumerState<EmergencyMapPage> {
  final controller = HomeController();

  @override
  void initState() {
    super.initState();
    controller.initializeApp(ref);
  }

  @override
  Widget build(BuildContext context) {
    final location = ref.watch(locationProvider);
    final markers = ref.watch(emergencyMarkersProvider);

    return Scaffold(
      body: location == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: controller.onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: location,
                    zoom: 16,
                  ),
                  markers: markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  style: controller.mapStyle,
                  onTap: (d) {},
                ),
                //Profile Logo
                Positioned(
                  right: 20,
                  top: kToolbarHeight,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          blurRadius: 2,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Icon(Icons.person),
                  ),
                ),
                //Body Report
                Positioned(
                  bottom: ref.watch(controller.showFieldProvider) ? 240 : 20,
                  left: 20,
                  right: 20,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade100,
                              blurRadius: 2,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: AnimatedContainer(
                                height: ref.watch(controller.showFieldProvider)
                                    ? 20
                                    : 0,
                                duration: Duration(milliseconds: 400),
                                child: ref.watch(controller.showFieldProvider)
                                    ? IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        onPressed: () =>
                                            controller.minimizeField(ref),
                                      )
                                    : SizedBox(),
                              ),
                            ),
                            SizedBox(height: 10),
                            AppText("What Happen?", type: TextType.title),
                            AppText(
                              "What is on fire select any of this.",
                              type: TextType.paragraph,
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                Category.menuCategory.length,
                                (index) {
                                  final category = Category.menuCategory[index];

                                  return GestureDetector(
                                    onTap: () =>
                                        controller.collapseField(ref, index),
                                    child: Container(
                                      height: 100,
                                      width:
                                          (MediaQuery.of(context).size.width /
                                              3) -
                                          30,
                                      decoration: BoxDecoration(
                                        color:
                                            ref.watch(controller.tabIndex) ==
                                                index
                                            ? Colors.white
                                            : const Color(0xFFEFEFEF),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color:
                                              ref.watch(controller.tabIndex) ==
                                                  index
                                              ? Colors.red.withValues(alpha: .5)
                                              : const Color(0xFFEFEFEF),
                                        ),
                                      ),
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: SvgPicture.asset(
                                              "assets/images/badge.svg",
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          AppText(
                                            category.title!,
                                            align: TextAlign.center,
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            AnimatedContainer(
                              duration: Duration(milliseconds: 400),
                              height: ref.watch(controller.showFieldProvider)
                                  ? null
                                  : 0,
                              child: !ref.watch(controller.showFieldProvider)
                                  ? SizedBox()
                                  : SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsGeometry.symmetric(
                                                  vertical: 10,
                                                ),
                                            child: Divider(),
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          15,
                                                        ),
                                                    color: Colors.red,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color:
                                                            Colors.red.shade100,
                                                        blurRadius: 2,
                                                        spreadRadius: 1,
                                                      ),
                                                    ],
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10,
                                                  ),
                                                  child: Icon(
                                                    Icons.camera_alt_outlined,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              AppText(
                                                "Can you take some piture?",
                                                type: TextType.caption,
                                                fontsize: 16,
                                                color: const Color.fromARGB(
                                                  221,
                                                  32,
                                                  32,
                                                  32,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: ref.watch(controller.showFieldProvider) ? 170 : 0,
                  left: 20,
                  right: 20,
                  child: AnimatedContainer(
                    padding: EdgeInsets.all(10),
                    duration: Duration(milliseconds: 200),
                    height: ref.watch(controller.showFieldProvider) ? 60 : 0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          blurRadius: 2,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: !ref.watch(controller.showFieldProvider)
                        ? SizedBox()
                        : Row(
                            children: [
                              Icon(Icons.sentiment_dissatisfied),
                              SizedBox(width: 20),
                              AppText(
                                "Any injured?",
                                type: TextType.caption,
                                fontsize: 16,
                                color: const Color.fromARGB(221, 32, 32, 32),
                              ),
                              SizedBox(width: 30),

                              Expanded(
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: CustomActiveButton(
                                        bodyText: "Yes",
                                        callback: () {},
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Flexible(
                                      child: CustomDisabledButton(
                                        bodyText: "No",
                                        callback: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                Positioned(
                  bottom: ref.watch(controller.showFieldProvider) ? 35 : 0,
                  left: 20,
                  right: 20,
                  child: AnimatedContainer(
                    height: ref.watch(controller.showFieldProvider) ? 125 : 0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          blurRadius: 2,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(10),
                    duration: Duration(milliseconds: 200),

                    child: !ref.watch(controller.showFieldProvider)
                        ? SizedBox()
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey.shade200,
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Explain us more...",
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                CustomActiveButton(
                                  isLoading: ref.watch(controller.loadingBtn),
                                  bodyText: "File a report",
                                  callback: ref.watch(controller.loadingBtn)
                                      ? () {}
                                      : () => controller.fileReports(ref),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _emergencyButton(String label, Color color, IconData icon) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      onPressed: () => controller.addEmergency(label, color, ref, context),
    );
  }
}
