import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:get/get.dart';
import 'package:uiam_business/app/uiamblockchain/uiam_blockchain_connection.dart';

import '../controllers/business_profile_form_controller.dart';

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:image_picker/image_picker.dart';
import 'package:octo_image/octo_image.dart';
import 'package:uiam_business/app/data/enums/variant_button_size.dart';
import 'package:uiam_business/app/global/widgets/drop_shadow.dart';
import 'package:uiam_business/app/global/widgets/variant_progress_button.dart';
import 'package:uiam_business/app/routes/app_pages.dart';
import 'package:uiam_business/core/theme/variant_theme.dart';
import 'package:uiam_business/core/values/consts.dart';

import '../../../global/animations/fade_in_animation.dart';

class BusinessProfileFormView extends GetView<BusinessProfileFormController> {
  const BusinessProfileFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 20,
          elevation: 0,
          bottom: TabBar(
              controller: controller.tabController,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              indicatorSize: TabBarIndicatorSize.tab,
              splashFactory: NoSplash.splashFactory,
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  return states.contains(MaterialState.focused)
                      ? null
                      : Colors.transparent;
                },
              ),
              indicatorColor: Get.theme.colorScheme.onPrimary.withOpacity(0.8),
              unselectedLabelColor:
                  Get.theme.colorScheme.onBackground.withOpacity(0.7),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: VariantTheme.primary.color,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Get.theme.shadowColor.withOpacity(0.5),
                    blurRadius: 99,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                      color: VariantTheme.primary.shadowColor,
                      blurRadius: 10,
                      offset: const Offset(0, 2))
                ],
              ),
              tabs: [
                Tab(
                  text: 'Info',
                ),
                Tab(
                  text: 'Address',
                ),
              ]),
        ),
        body: TabBarView(controller: controller.tabController, children: [
          Form(
            key: controller.infoFormKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(height: dSpace),
                  GestureDetector(
                    onTap: () async {
                      await controller.selectImage(ImageSource.gallery);
                    },
                    child: DropShadow(
                      shadowOpacity: 0.5,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Get.theme.colorScheme.background,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Stack(children: [
                          Obx(() => Center(
                              child: controller.imagePath.value.isEmpty
                                  ? Icon(Icons.person_add,
                                      size: 50,
                                      color: Get.theme.colorScheme.onBackground
                                          .withOpacity(0.7))
                                  : Obx(() => OctoImage(
                                      image: CachedNetworkImageProvider(
                                          controller.imagePath.value),
                                      progressIndicatorBuilder:
                                          OctoProgressIndicator
                                              .circularProgressIndicator())))),
                          Obx(() => controller
                                  .storageController.isUploading.value
                              ? FadeInAnimation(
                                  child: Center(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaY: 7, sigmaX: 7),
                                      child:
                                          Obx(() => CircularProgressIndicator(
                                                value: controller
                                                    .storageController
                                                    .uploadPercent
                                                    .value,
                                              )),
                                    ),
                                  ),
                                )
                              : Container())
                        ]),
                      ),
                    ),
                  ),
                  const SizedBox(height: dSpace),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: dSpace,
                    runSpacing: dSpace,
                    children: [
                      DropShadow(
                        child: FocusScope(
                          onFocusChange: (hasFocus) {
                            if (!hasFocus &&
                                controller.imagePath.value.isEmpty) {
                              controller.business.copyWith();
                            }
                          },
                          child: TextFormField(
                            initialValue: controller.business.name,
                            onSaved: (value) => controller.business =
                                controller.business.copyWith(name: value),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: "Name"),
                          ),
                        ),
                      ),
                      DropShadow(
                        child: DropdownSearch<String>(
                          items: businessTypes,
                          selectedItem: controller.business.type,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration:
                                  InputDecoration(labelText: "Business Type")),
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                                borderSide: BorderSide.none,
                              ),
                              labelText: "Search",
                            )),
                            menuProps: MenuProps(
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                                backgroundColor:
                                    Get.theme.colorScheme.background),
                          ),
                          validator: (String? item) {
                            if (item == null)
                              return "Business type is required";
                            return null;
                          },
                          onSaved: (String? item) {
                            if (item != null) {
                              controller.business =
                                  controller.business.copyWith(type: item);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: dSpace),
                  Wrap(
                      alignment: WrapAlignment.center,
                      spacing: dSpace,
                      runSpacing: dSpace,
                      children: [
                        DropShadow(
                          child: TextFormField(
                            initialValue: controller.business.email,
                            onSaved: (value) => controller.business =
                                controller.business.copyWith(email: value),
                            validator: (value) {
                              if (GetUtils.isNullOrBlank(value)!) {
                                return 'Please enter your email';
                              } else if (!GetUtils.isEmail(value!)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(labelText: "Email"),
                          ),
                        ),
                        DropShadow(
                          child: TextFormField(
                            initialValue: controller.business.website,
                            onSaved: (value) => controller.business =
                                controller.business.copyWith(website: value),
                            validator: (value) {
                              if (GetUtils.isNullOrBlank(value)!) {
                                return null;
                              } else if (!GetUtils.isURL(value!)) {
                                return 'Please enter a valid url';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.url,
                            decoration: InputDecoration(labelText: "Website"),
                          ),
                        ),
                      ]),
                  SizedBox(height: dSpace),
                  DropShadow(
                    child: TextFormField(
                      initialValue: controller.business.description,
                      onSaved: (value) => controller.business =
                          controller.business.copyWith(description: value),
                      validator: (value) {
                        if (GetUtils.isNullOrBlank(value)!) {
                          return 'Please enter a description';
                        } else if (value!.length < 10) {
                          return 'Please enter a longer description';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 3,
                      decoration: InputDecoration(labelText: "Description"),
                    ),
                  ),
                  const SizedBox(height: dSpace),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      VariantProgressButton(
                        size: VariantButtonSize.xlarge,
                        width: hSize,
                        content:
                            controller.business.id != null ? "Save" : "Next",
                        onCompleted: () {
                          if (controller.business.id != null) {
                            Map<String, dynamic>? arguments = Get.arguments;
                            Get.offAllNamed(arguments?['next'] ?? Routes.HOME);
                          }
                        },
                        onTap: () async {
                          if (controller.infoFormKey.currentState != null &&
                              controller.infoFormKey.currentState!.validate()) {
                            controller.infoFormKey.currentState!.save();
                            if (controller.imagePath.isEmpty) {
                              controller.imagePath.value =
                                  "https://ui-avatars.com/api/?name=${controller.business.name}&size=128";
                            }
                            controller.business = controller.business
                                .copyWith(image: controller.imagePath.value);

                            controller.isInfoSave = true;

                            if (controller.business.id != null) {
                              final ret = await controller.personProvider
                                  .save(model: controller.business);
                              controller.auth.user = controller.business;

                              if (controller.success) {
                                var uidHash = controller.auth.user.id! +
                                    controller.hashingvalue;

                                var bytes = utf8.encode(uidHash);

                                var digest = sha256
                                    .convert(bytes); //data converted to sh256
                                UiamModel().addUser(
                                    controller.auth.user.id, digest.toString());
                              }

                              return ret;
                            } else {
                              controller.tabController.animateTo(1);
                            }
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: dSpace),
                ]),
              ),
            ),
          ),
          Form(
            key: controller.addressFormKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(height: dSpace),
                  Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: dSpace,
                    spacing: dSpace,
                    children: [
                      DropShadow(
                          child: TextFormField(
                        controller: controller.locationController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Location",
                        ),
                        validator: (value) {
                          if (GetUtils.isNullOrBlank(value)!) {
                            return 'Please choose business location';
                          }
                          return null;
                        },
                        onTap: () {
                          Get.bottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(borderRadius))),
                            Obx(() => FlutterMap(
                                  options: MapOptions(
                                      center: controller.initialMapCenter ??
                                          LatLng(22.65024, 78.98760),
                                      maxZoom: 18,
                                      minZoom: 0,
                                      zoom: controller.initialMapCenter != null
                                          ? 18
                                          : 5.0,
                                      onTap: (pos, latlng) async {
                                        controller.business =
                                            controller.business.copyWith(
                                                location: GeoFirePoint(
                                                    latlng.latitude,
                                                    latlng.longitude));
                                        controller.locationController.text =
                                            "${latlng.latitude},${latlng.longitude}";
                                        controller.onLocationSelect(latlng);
                                      }),
                                  layers: [
                                    TileLayerOptions(
                                      urlTemplate:
                                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                      subdomains: ['a', 'b', 'c'],
                                    ),
                                    MarkerLayerOptions(
                                      markers: [
                                        if (controller.marker.value != null)
                                          controller.marker.value!
                                      ],
                                    ),
                                  ],
                                )),
                            ignoreSafeArea: true,
                          );
                        },
                      )),
                      DropShadow(
                        child: TextFormField(
                          initialValue: controller.business.address,
                          onSaved: (value) => controller.business =
                              controller.business.copyWith(address: value),
                          validator: (value) {
                            if (GetUtils.isNullOrBlank(value)!) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                          minLines: 1,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Address",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: dSpace),
                  Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: dSpace,
                    spacing: dSpace,
                    children: [
                      DropShadow(
                        child: TextFormField(
                          initialValue: controller.business.place,
                          onSaved: (value) => controller.business =
                              controller.business.copyWith(place: value),
                          validator: (value) {
                            if (GetUtils.isNullOrBlank(value)!) {
                              return 'Please enter your place';
                            }
                            return null;
                          },
                          minLines: 1,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Place",
                          ),
                        ),
                      ),
                      DropShadow(
                        child: TextFormField(
                          initialValue: controller.business.city,
                          onSaved: (value) => controller.business =
                              controller.business.copyWith(city: value),
                          validator: (value) {
                            if (GetUtils.isNullOrBlank(value)!) {
                              return 'Please enter your city';
                            }
                            return null;
                          },
                          minLines: 1,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "City",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: dSpace),
                  Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: dSpace,
                    spacing: dSpace,
                    children: [
                      DropShadow(
                        child: TextFormField(
                          initialValue: controller.business.state,
                          onSaved: (value) => controller.business =
                              controller.business.copyWith(state: value),
                          validator: (value) {
                            if (GetUtils.isNullOrBlank(value)!) {
                              return 'Please enter your state';
                            }
                            return null;
                          },
                          minLines: 1,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "State",
                          ),
                        ),
                      ),
                      DropShadow(
                        child: TextFormField(
                          initialValue: controller.business.postalCode,
                          onSaved: (value) => controller.business =
                              controller.business.copyWith(postalCode: value),
                          validator: (value) {
                            if (GetUtils.isNullOrBlank(value)!) {
                              return 'Please enter your postal code';
                            } else if (int.tryParse(value!) == null ||
                                value.length != 6) {
                              return 'Please enter 6 digit postal code';
                            }
                            return null;
                          },
                          minLines: 1,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Postal Code",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: dSpace),
                  const SizedBox(height: dSpace),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      VariantProgressButton(
                        size: VariantButtonSize.xlarge,
                        width: hSize,
                        content: "Save",
                        onCompleted: () {
                          Map<String, dynamic>? arguments = Get.arguments;
                          Get.offAllNamed(Routes.HOME);
                        },
                        onTap: () async {
                          if (controller.addressFormKey.currentState != null &&
                              controller.addressFormKey.currentState!
                                  .validate()) {
                            if (controller.infoFormKey.currentState != null &&
                                !controller.infoFormKey.currentState!
                                    .validate()) {
                              controller.tabController.animateTo(0);
                              return null;
                            }

                            if (!controller.isInfoSave &&
                                controller.infoFormKey.currentState != null) {
                              controller.infoFormKey.currentState!.save();
                              if (controller.imagePath.isEmpty) {
                                controller.imagePath.value =
                                    "https://ui-avatars.com/api/?name=${controller.business.name}&size=128";
                              }
                              controller.business = controller.business
                                  .copyWith(image: controller.imagePath.value);
                            }

                            controller.addressFormKey.currentState!.save();

                            final ret = await controller.personProvider
                                .save(model: controller.business);
                            controller.auth.user = controller.business;

                            if (controller.success) {
                              var uidHash = controller.auth.user.id! +
                                  controller.hashingvalue;

                              var bytes = utf8.encode(uidHash);

                              var digest = sha256
                                  .convert(bytes); //data converted to sh256
                              UiamModel().addUser(
                                  controller.auth.user.id, digest.toString());
                            }
                            return ret;
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: dSpace),
                ]),
              ),
            ),
          ),
        ]));
  }
}
