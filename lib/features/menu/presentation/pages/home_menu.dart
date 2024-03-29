import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image/network.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../core/utils/utils.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/datum.dart';
import '../bloc/bloc.dart';
import 'order_detail.dart';

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
      // key: globalKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Restoku",
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: Container(
            height: 4,
            color: Colors.grey,
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
              padding: const EdgeInsets.all(12),
              child: Stack(
                children: <Widget>[
                  new Icon(
                    Icons.shopping_cart,
                    color: Colors.grey,
                    size: 30,
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
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: new Text(
                        data.length.toString(),
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 10,
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
                  return StaggeredGridView.countBuilder(
                    padding: EdgeInsets.only(
                      top: 12,
                      left: 0,
                      right: 0,
                      bottom: 16,
                    ),
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
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
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImageWithRetry(
                                        state.menu.data[i].gambar),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        state.menu.data[i].nama,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          height: 1.5,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 5,
                                left: 0,
                                child: Container(
                                  color: Colors.green.withOpacity(.7),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      utils.convertCurrency(
                                          state.menu.data[i].harga),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.fit(2),
                  );
                  // return ListView.builder(
                  //   shrinkWrap: true,
                  //   itemCount: state.menu.data.length,
                  //   itemBuilder: (context, i) {
                  //     return InkWell(
                  //       onTap: (() {
                  //         setState(() {
                  //           data.add(Datum(
                  //             id: state.menu.data[i].id,
                  //             nama: state.menu.data[i].nama,
                  //             harga: state.menu.data[i].harga,
                  //             gambar: "",
                  //           ));
                  //           jumlahHarga += state.menu.data[i].harga;
                  //         });
                  //         showFloatingFlushbar(context);
                  //       }),
                  //       child: ListTile(
                  //         title: Text(state.menu.data[i].nama),
                  //       ),
                  //     );
                  //   },
                  // );
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
