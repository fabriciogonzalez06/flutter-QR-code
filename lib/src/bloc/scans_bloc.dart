import 'dart:async';

import 'package:qrreadapp/src/bloc/validator.dart';
import 'package:qrreadapp/src/provider/db_provider.dart';

class ScansBloc with Validators {

    static final ScansBloc _singleton= new ScansBloc._internal();

    factory ScansBloc(){
      return _singleton;
    }

    ScansBloc._internal(){
      //obtener Scans de la base de datos 
      obtenerScans();

    }

    final _scansController =StreamController<List<ScanModel>>.broadcast();

    Stream<List<ScanModel>> get scansStream=> _scansController.stream.transform(validarGeo);
    Stream<List<ScanModel>> get scansStreamHttp=> _scansController.stream.transform(validarHttp);

    disponse(){
      _scansController?.close();
    }


   agregarScan(ScanModel scan) async{
      await DbProvider.db.nuevoScan(scan);
      obtenerScans();

   }


    obtenerScans()async{

        _scansController.sink.add( await DbProvider.db.getTodosScans());

    }

    borrarScan(int id)async{
       await DbProvider.db.deleteScan(id);
       obtenerScans();
    }

    borrarScanTodos()async{
      DbProvider.db.deleteAll();
      //_scansController.sink.add([]);
      obtenerScans();

    }

}