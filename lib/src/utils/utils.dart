import 'package:flutter/material.dart';
import 'package:qrreadapp/src/provider/db_provider.dart';
import 'package:url_launcher/url_launcher.dart';

abrirScan(ScanModel scan,BuildContext context) async {

  if(scan.tipo=='http'){

  if (await canLaunch(scan.valor)) {
    await launch(scan.valor);
  } else {
    throw 'Could not launch ${scan.valor}';
  }
  }else{
    Navigator.pushNamed(context, 'mapa',arguments: scan);
  }

}

