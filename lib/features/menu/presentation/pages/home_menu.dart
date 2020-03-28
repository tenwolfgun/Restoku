import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restoran/core/utils/utils.dart';
import 'package:restoran/features/menu/domain/entities/datum.dart';
import 'package:restoran/features/menu/presentation/bloc/bloc.dart';
import 'package:restoran/features/menu/presentation/pages/order_detail.dart';

import '../../../../injection_container.dart';

class HomeMenu extends StatefulWidget {
  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  final MenuBloc menuBloc = sl<MenuBloc>();
  final GlobalKey globalKey = GlobalKey();
  final Utils utils = Utils();
  List<Datum> data = [];
  int jumlahHarga = 0;
  bool isOpen = false;

  @override
  void initState() {
    menuBloc.add(GetMenuEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Restoku",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderDetail(
                    data: data,
                    harga: jumlahHarga,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Stack(
                children: <Widget>[
                  new Icon(
                    Icons.shopping_cart,
                    color: Colors.grey,
                  ),
                  new Positioned(
                    right: 0,
                    child: new Container(
                      padding: EdgeInsets.all(1),
                      decoration: new BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: new Text(
                        data.length.toString(),
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: BlocProvider(
          create: (context) => menuBloc,
          child: BlocListener<MenuBloc, MenuState>(
            listener: (context, state) {
              if (state is LoadOrderState) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(state.menu.length.toString()),
                  ),
                );
              }
            },
            child: BlocBuilder<MenuBloc, MenuState>(
              bloc: menuBloc,
              builder: (context, MenuState state) {
                if (state is LoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadedState) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.menu.data.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: (() {
                          setState(() {
                            data.add(Datum(
                              id: state.menu.data[i].id,
                              nama: state.menu.data[i].nama,
                              harga: state.menu.data[i].harga,
                              gambar: "",
                            ));
                            jumlahHarga += state.menu.data[i].harga;
                          });
                          showFloatingFlushbar(context);
                        }),
                        child: ListTile(
                          title: Text(state.menu.data[i].nama),
                        ),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void showFloatingFlushbar(BuildContext context) {
    // if (isOpen == false) {
    //   setState(() {
    //     isOpen = !isOpen;
    //   });
    // }
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
      title: 'Jumlah: ${data.length}',
      message: 'Total: ${utils.convertCurrency(jumlahHarga)}',
    )..show(context);
  }
}
