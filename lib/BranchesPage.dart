import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:test_shopping/Branch.dart';

import 'StoreMainMenuPage.dart';

class BranchesPage extends StatefulWidget {
  @override
  _BranchesPageState createState() => _BranchesPageState();
}

class _BranchesPageState extends State<BranchesPage> {
  Set<Marker> _BranchesList = {};

  Completer<GoogleMapController> _controller = Completer();
  void OnCompelet(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchpoint();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[600],
        title: Text('Store',
            style: TextStyle(fontSize: 25.0, color: Colors.white)),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Store()));
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: GoogleMap(
        onMapCreated: OnCompelet,
        initialCameraPosition:
            CameraPosition(target: LatLng(35.721144, 51.385587), zoom: 5.0),
        markers: _BranchesList,
      ),
    );
  }

  void fetchpoint() async {
    var url = 'http://welearnacademy.ir/flutter/branches.json';
    Response response = await get(url);
    setState(() {
      var branchpoint = json.decode(utf8.decode(response.bodyBytes));
      for (var point in branchpoint) {
        var b = Branch(point['shop_name'], point['id'], point['tel'],
            point['lat'], point['lng'], point['manager']);
        Marker marker = Marker(
          markerId: MarkerId(b.id.toString()),
          position: LatLng(b.lat, b.lng),
          infoWindow: InfoWindow(title: b.shopName, snippet: b.tel),
        );
        _BranchesList.add(marker);
      }
    });
  }
}
