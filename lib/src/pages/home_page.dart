
import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:qrreadapp/src/bloc/scans_bloc.dart';
import 'package:qrreadapp/src/models/scan_model.dart';
import 'package:qrreadapp/src/pages/direcciones_page.dart';
import 'package:qrreadapp/src/pages/mapas_pages.dart';
import 'package:qrreadapp/src/utils/utils.dart' as utils;






class HomePage extends StatefulWidget{


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex=0;
  final scanBloc= new ScansBloc();

  @override
  Widget build(BuildContext context){

      scanBloc.obtenerScans();
      return Scaffold(
        appBar: AppBar(
          title: Text('QR Scanner'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: ()=> scanBloc.borrarScanTodos(),
            )
          ],
        ),
        body:_callPage(this.currentIndex),
        bottomNavigationBar: _crearBottomNavigationBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.filter_center_focus),
          onPressed:()=> _scanQR(context),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
  }

  Widget _callPage(int paginaActual){
     switch (paginaActual) {
       case 0:return new MapasPage();
       case 1: return new DireccionesPage();

       default:
        return new MapasPage();
     }
  }

  BottomNavigationBar _crearBottomNavigationBar(){
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (index){
        setState(() {
          this.currentIndex=index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones')
        ),
      ],
    );
  }


  _scanQR(BuildContext context) async{
      // https://avanza-hn.web.app
      //geo:13.924568835566607,-87.24446669062503
      String futureString;

       try {
        futureString = await BarcodeScanner.scan();
      } catch (e) {
        futureString = e.toString();
      } 


      if(futureString!=null){
        final scan = ScanModel(valor: futureString);
        scanBloc.agregarScan(scan);
     
     
     /*    final scan2 = ScanModel(valor: 'geo:13.924568835566607,-87.24446669062503');
        scanBloc.agregarScan(scan2);
 */
        if(Platform.isIOS){
            Future.delayed(Duration(milliseconds: 750),(){
            utils.abrirScan(scan,context);

            });
        }else{

        utils.abrirScan(scan,context);
        }

      } 
  }
}