import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    if(result != null){
     String result2 =  "${result!.code}" ;
     showCupertinoDialog(context:context, builder: (context)=>
         CupertinoAlertDialog(
           title: new Text("Мы получили это`"),
           content: new Text("$result2"),
           actions: <Widget>[
             CupertinoDialogAction(
               isDefaultAction: true,
               onPressed: (){
                 print("popp");
                 Navigator.pop(context);
                 Navigator.pop(context);

               },

               child: Text("Хорошо"),
             ),
             // CupertinoDialogAction(
             //   child: Text("Хорошо"),
             // )
           ],
         )
     );
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: Row(
                  children: [
                    SizedBox(width: 20,),
                    IconButton(onPressed: (){ Navigator.pop(context); }, icon: Icon(Icons.arrow_back_ios)),
                    Spacer()
                  ],
                ),
              ),
            ),
            Expanded(flex: 9, child: _buildQrView(context)),



            // Expanded(
            //   flex: 1,
            //   child: FittedBox(
            //     fit: BoxFit.contain,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: <Widget>[
            //         if (result != null)
            //           Text(
            //               'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
            //         else
            //           Text('Scan a code'),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: <Widget>[
            //             Container(
            //               margin: EdgeInsets.all(8),
            //               child: RaisedButton(
            //                   onPressed: () async {
            //                     await controller?.toggleFlash();
            //                     setState(() {});
            //                   },
            //                   child: FutureBuilder(
            //                     future: controller?.getFlashStatus(),
            //                     builder: (context, snapshot) {
            //                       return Text('Flash: ${snapshot.data}');
            //                     },
            //                   )),
            //             ),
            //             Container(
            //               margin: EdgeInsets.all(8),
            //               child: RaisedButton(
            //                   onPressed: () async {
            //                     await controller?.flipCamera();
            //                     setState(() {});
            //                   },
            //                   child: FutureBuilder(
            //                     future: controller?.getCameraInfo(),
            //                     builder: (context, snapshot) {
            //                       if (snapshot.data != null) {
            //                         return Text(
            //                             'Camera facing ${describeEnum(snapshot.data!)}');
            //                       } else {
            //                         return Text('loading');
            //                       }
            //                     },
            //                   )),
            //             )
            //           ],
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: <Widget>[
            //             Container(
            //               margin: EdgeInsets.all(8),
            //               child: RaisedButton(
            //                 onPressed: () async {
            //                   await controller?.pauseCamera();
            //                 },
            //                 child: Text('pause', style: TextStyle(fontSize: 20)),
            //               ),
            //             ),
            //             Container(
            //               margin: EdgeInsets.all(8),
            //               child: RaisedButton(
            //                 onPressed: () async {
            //                   await controller?.resumeCamera();
            //                 },
            //                 child: Text('resume', style: TextStyle(fontSize: 20)),
            //               ),
            //             )
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // )



          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
     return QRView(
      key: qrKey,

      onQRViewCreated: _onQRViewCreated,
   
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}