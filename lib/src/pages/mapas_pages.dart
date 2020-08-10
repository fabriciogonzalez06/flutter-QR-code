import 'package:flutter/material.dart';
//providers
import 'package:qrreadapp/src/bloc/scans_bloc.dart';
//utils
import 'package:qrreadapp/src/utils/utils.dart' as utils;
//models
import 'package:qrreadapp/src/models/scan_model.dart';
class MapasPage extends StatelessWidget {
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ScanModel>>(
        stream: scansBloc.scansStream,
        builder: (BuildContext contex, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final scans = snapshot.data;

          if (scans.length == 0) {
            return Center(
              child: Text('No hay información'),
            );
          }

          return ListView.builder(
              itemCount: scans.length,
              itemBuilder: (BuildContext context, i) => Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.red,
                    ),
                    onDismissed: (direccion) =>
                        scansBloc.borrarScan(scans[i].id),
                    child: ListTile(
                      onTap: ()=>utils.abrirScan(scans[i],context),
                      leading: Icon(
                        Icons.map,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(scans[i].valor),
                      subtitle: Text('ID: ${scans[i].id}'),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      ),
                    ),
                  ));
        });
  }



}
