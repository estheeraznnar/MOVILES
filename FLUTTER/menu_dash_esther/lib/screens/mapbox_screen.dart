import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapboxScreen extends StatelessWidget {
   
  const MapboxScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    MapboxMap? _mapboxMaap;

    Position plazaTorico = Position(-1.1070361111111, 40.342833333333);

    CameraOptions camara = CameraOptions(
      center: Point(coordinates: plazaTorico),
      zoom: 15,
      bearing:  -161.81,
      pitch: 70.0
    );

    _onMapCreated(MapboxMap mapboxMaap){
      _mapboxMaap = mapboxMaap;

      //Animacion
      mapboxMaap.flyTo(camara, MapAnimationOptions(
        duration: 10000,
        startDelay: 2000,
      ));
    }

    return Scaffold(
      
      appBar: AppBar(title: Text('MapBoxScreen'),), 
      body: MapWidget(
        styleUri: MapboxStyles.STANDARD,
        cameraOptions: CameraOptions(
          center: Point(coordinates: Position(-74.006111111111, 40.712777777778)),
          zoom: 14
        ),
        onMapCreated: _onMapCreated,
      )
    );
  }
}