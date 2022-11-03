import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MapAddress extends StatefulWidget {
  final String? countryName;
  final String? streetName;
  final String? zipCode;
  final String? governorate;
  final String? name;
  final String? locality;
  final String? sublocality;
  final double? lat;
  final double? lng;

  const MapAddress({
    Key? key,
    required this.countryName,
    required this.streetName,
    required this.zipCode,
    required this.governorate,
    required this.name,
    required this.locality,
    required this.sublocality,
    required this.lat,
    required this.lng,
  }) : super(key: key);

  @override
  State<MapAddress> createState() => _MapAddressState();
}

class _MapAddressState extends State<MapAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "countryName : " + widget.countryName!,
              style: TextStyle(
                  color: Color.fromARGB(255, 252, 171, 49), fontSize: 20),
            ),
            Text("streetName : " + widget.streetName!,
                style: TextStyle(
                    color: Color.fromARGB(255, 252, 171, 49), fontSize: 20)),
            Text("Zipcode : " + widget.zipCode!,
                style: TextStyle(
                    color: Color.fromARGB(255, 252, 171, 49), fontSize: 20)),
            Text(
              "governorate: " + widget.governorate!,
              style: TextStyle(
                  color: Color.fromARGB(255, 252, 171, 49), fontSize: 20),
            ),
            Text("name : " + widget.name!,
                style: TextStyle(
                    color: Color.fromARGB(255, 252, 171, 49), fontSize: 20)),
            Text("locality : " + widget.locality!,
                style: TextStyle(
                    color: Color.fromARGB(255, 252, 171, 49), fontSize: 20)),
            Text(
              "sublocality: " + widget.sublocality!,
              style: TextStyle(
                  color: Color.fromARGB(255, 252, 171, 49), fontSize: 20),
            ),
            Text("lat :  + ${widget.lat!}",
                style: TextStyle(
                    color: Color.fromARGB(255, 252, 171, 49), fontSize: 20)),
            Text("lng:  + ${widget.lng!}",
                style: TextStyle(
                    color: Color.fromARGB(255, 252, 171, 49), fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
