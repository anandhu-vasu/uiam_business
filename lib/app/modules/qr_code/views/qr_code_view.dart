import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../controllers/qr_code_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QrCodeView extends GetView<QrCodeController> {
  const QrCodeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Get.theme.colorScheme.primary,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 320,
                  width: 280,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    color: Colors.white,
                  
                  ),
                  child: MobileScanner(
                      allowDuplicates: false,
                      fit: BoxFit.cover,
                      controller: MobileScannerController(
                          facing: CameraFacing.back,),
                      onDetect: (barcode, args) {
                        if (barcode.rawValue == null) {
                          debugPrint('Failed to scan Barcode');
                        } else {
                          final String personalid = barcode.rawValue!;
                          FirebaseFirestore.instance.collection('records').add({
                            'personal_id': personalid,
                            'business_id': controller.auth.user.id!,
                            'created_on': FieldValue.serverTimestamp(),
                          });
                          Get.toNamed('/home');
                        }
                      }),
                )
              ],
            )
          
            
          
          ],
        ));
  }
}
