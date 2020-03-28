import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:restoran/core/utils/utils.dart';
import 'package:restoran/features/menu/domain/entities/datum.dart';
import 'package:restoran/features/menu/domain/entities/menu.dart';
import 'package:restoran/features/menu/presentation/pages/home_menu.dart';

class OrderDetail extends StatefulWidget {
  final List<Datum> data;
  final int harga;

  const OrderDetail({
    Key key,
    this.data,
    this.harga,
  }) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  List<Datum> data;
  int harga;
  int jumlahBayar = 0;
  int kembali = 0;
  final textEditingController = TextEditingController();
  final Utils utils = Utils();

  @override
  void initState() {
    data = widget.data;
    harga = widget.harga;
    textEditingController.addListener(handleTextChange);
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  handleTextChange() {
    setState(() {
      jumlahBayar = int.tryParse(textEditingController.text) ?? 0;
      kembali = jumlahBayar - harga;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "Pembayaran",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            Positioned(
              bottom: MediaQuery.of(context).size.height * .2,
              left: 0,
              right: 0,
              top: 0,
              child: ListView(
                padding: EdgeInsets.only(bottom: 80),
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    height: 5,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black26,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(16),
                  //   child: Center(
                  //     child: Text(
                  //       "Pembayaran",
                  //       style: TextStyle(fontSize: 16, height: 1.5),
                  //     ),
                  //   ),
                  // ),
                  ListView.builder(
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                    ),
                    itemCount: data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              data[i].nama,
                              style: TextStyle(fontSize: 16, height: 1.5),
                            ),
                          ),
                          Text(
                            utils.convertCurrency(data[i].harga),
                            style: TextStyle(fontSize: 16, height: 1.5),
                          ),
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Total",
                            style: TextStyle(fontSize: 16, height: 1.5),
                          ),
                        ),
                        Text(
                          utils.convertCurrency(harga),
                          style: TextStyle(fontSize: 16, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 8,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Nominal Pembayaran",
                            style: TextStyle(fontSize: 16, height: 1.5),
                          ),
                        ),
                        Text(
                          utils.convertCurrency(jumlahBayar),
                          style: TextStyle(fontSize: 16, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 8,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Uang Kembali",
                            style: TextStyle(fontSize: 16, height: 1.5),
                          ),
                        ),
                        Text(
                          utils.convertCurrency(kembali),
                          style: TextStyle(fontSize: 16, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     left: 16,
                  //     right: 16,
                  //     top: 8,
                  //   ),
                  //   child: Row(
                  //     children: <Widget>[
                  //       Text(
                  //         "Masukan nominal pembayaran",
                  //         style: TextStyle(fontSize: 16, height: 1.5),
                  //       ),
                  //       Expanded(
                  //         child: TextField(
                  //           controller: textEditingController,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Card(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        enableInteractiveSelection: false,
                        decoration: InputDecoration(
                            // border: ,
                            hintText: "Masukan jumlah uang yang dibayarkan",
                            hintStyle: TextStyle(fontStyle: FontStyle.italic),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8))),
                        controller: textEditingController,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 4, left: 10),
                              child: RaisedButton(
                                onPressed: () async {
                                  showFloatingFlushbar(context, "Info",
                                      "Transaksi anda berhasil dibatalkan");

                                  await Future.delayed(Duration(seconds: 2));
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeMenu(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "BATAL",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, left: 4),
                              child: RaisedButton(
                                onPressed: () async {
                                  if (jumlahBayar < harga) {
                                    showFloatingFlushbar(
                                        context,
                                        "Pembayaran gagal",
                                        "Uang anda tidak cukup untuk melakukan transaksi ini");
                                  } else {
                                    showSuccess(context);
                                    await Future.delayed(Duration(seconds: 2));
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeMenu(),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  "BAYAR SEKARANG",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showFloatingFlushbar(BuildContext context, String title, message) {
    Flushbar(
      duration: Duration(seconds: 1),
      isDismissible: true,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      borderRadius: 8,
      backgroundGradient: LinearGradient(
        colors: [Colors.red.shade800, Colors.redAccent.shade700],
        stops: [0.6, 1],
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      // All of the previous Flushbars could be dismissed by swiping down
      // now we want to swipe to the sides
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      // The default curve is Curves.easeOut
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: title,
      message: message,
    )..show(context);
  }

  void showSuccess(BuildContext context) {
    Flushbar(
      duration: Duration(seconds: 1),
      isDismissible: true,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      borderRadius: 8,
      backgroundGradient: LinearGradient(
        colors: [Colors.green.shade800, Colors.greenAccent.shade700],
        stops: [0.6, 1],
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      // All of the previous Flushbars could be dismissed by swiping down
      // now we want to swipe to the sides
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      // The default curve is Curves.easeOut
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: 'Pembayaran berhasil',
      message: 'Terimakasih sudah berbelanja di tempat kami',
    )..show(context);
  }
}
