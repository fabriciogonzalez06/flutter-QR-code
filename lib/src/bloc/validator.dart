import 'dart:async';

import 'package:qrreadapp/src/provider/db_provider.dart';

class Validators{


  //recibe scans y salen scan
  final validarGeo= StreamTransformer<List<ScanModel>,List<ScanModel>>.fromHandlers(
    handleData: (scans,sink){
      final geoScans= scans.where((s)=>s.tipo=='geo').toList();
      sink.add(geoScans);
    }
  );

    final validarHttp= StreamTransformer<List<ScanModel>,List<ScanModel>>.fromHandlers(
    handleData: (scans,sink){
      final geoScans= scans.where((s)=>s.tipo=='http').toList();
      sink.add(geoScans);
    }
  );

}