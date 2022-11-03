import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:simple_screens/map/map_address.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

const kGoogleApiKey = 'AIzaSyAGn2AmTYDhFx5XsQ2Lc46vUGkNvPJlTJ4';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _MapState extends State<Map> {
  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

  Set<Marker> markers = {};

  double latitude = 37.42796133580664;
  double longitude = -122.085749655962;

  bool isUser = false;

  @override
  void initState() {
    _determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        title: Text(
          'search',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: _handlePressButton,
              child: Icon(
                Icons.search,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            child: GoogleMap(
                markers: markers,
                mapType: MapType.normal,
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                    target: LatLng(37.42796133580664, -122.085749655962),
                    zoom: 30),
                onMapCreated: (GoogleMapController controller) {
                  googleMapController = controller;
                },
                circles: {
                  isUser
                      ? Circle(
                          circleId: CircleId("1"),
                          center: LatLng(latitude, longitude),
                          radius: 20,
                          strokeWidth: 2,
                          fillColor: Colors.blue.withOpacity(0.2),
                          strokeColor: Colors.blue)
                      : Circle(circleId: CircleId("2"))
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 80, right: 10),
            child: GestureDetector(
              onTap: () async {
                Position position = await _determinePosition();

                setState(() {
                  latitude = position.latitude;
                  longitude = position.longitude;
                  isUser = true;
                });

                googleMapController.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                        target: LatLng(latitude, longitude), zoom: 17)));
                setState(() {});

                markers.clear();

                markers.add(Marker(
                    markerId: const MarkerId('currentLocation'),
                    draggable: true,
                    onDragEnd: (value) async {
                      setState(() {
                        latitude = value.latitude;
                        longitude = value.longitude;
                        isUser = false;
                      });
                    },
                    position: LatLng(latitude, longitude)));
              },
              child: Container(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: new BoxDecoration(
                    color: Color.fromARGB(255, 252, 171, 49),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.my_location_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
                backgroundColor: Color.fromARGB(255, 252, 171, 49),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () async {
                List<Placemark> placemarks =
                    await placemarkFromCoordinates(latitude, longitude);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MapAddress(
                        countryName: placemarks[0].country,
                        streetName: placemarks[0].street,
                        zipCode: placemarks[0].postalCode,
                        name: placemarks[0].name,
                        governorate: placemarks[0].administrativeArea,
                        locality: placemarks[0].locality,
                        sublocality: placemarks[0].subLocality,
                        lat: latitude,
                        lng: longitude)));
              },
              child: Text('Confirm'),
            ),
          )
        ],
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.unableToDetermine) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: Mode.overlay,
        language: 'en',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white))),
        components: [Component(Component.country, "LB")]);

    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Message',
        message: response.errorMessage!,
        contentType: ContentType.failure,
      ),
    ));
  }

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        draggable: true,
        onDragEnd: (value) async {
          setState(() {
            latitude = value.latitude;
            longitude = value.longitude;
            isUser = false;
          });
        },
        infoWindow: InfoWindow(title: detail.result.formattedAddress),
      ),
    );

    setState(() {
      latitude = lat;
      longitude = lng;
      isUser = false;
    });
    setState(() {});

    googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 15));
  }
}
