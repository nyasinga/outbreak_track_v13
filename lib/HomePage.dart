import 'dart:async';
import 'dart:convert';

import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_cupertino.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:outbreak_tracker/DialogHelpers.dart';
import 'package:outbreak_tracker/entities/LocationLatLng.dart';
import 'package:outbreak_tracker/entities/app_state.dart';
import 'package:outbreak_tracker/util/GlobalAppConstants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool searchSelected = false;
  String currentCountry = 'Kenya';
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  LocationLatLng locationLatLng = new LocationLatLng();
  var logoPaddingValueSearch = 150.0;
  var logoPaddingValueDetails = 0.0;
  Map<String, double> userLocation;

  String searchValue = "";
  String _mapStyle;

  int totalCases = 0;

  DialogHelpers _dialogHelpers = new DialogHelpers();

  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  Future<Map<String, double>> _getUserDefaultLocation() async {
    var location = new Location();
    userLocation = await location.getLocation();

    return userLocation;
  }

  Future<LocationLatLng> findSearchedLocation(String location) async {
    http.Response response = await http.get(
        Uri.encodeFull(
            'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$location&key=${GlobalAppConstants.mapsApiKey}'),
        headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      var locationDetails = json.decode(response.body);

      locationLatLng.lat =
          locationDetails['results'][0]['geometry']['location']['lat'];
      locationLatLng.lng =
          locationDetails['results'][0]['geometry']['location']['lng'];
    }

    return locationLatLng;
  }

  void addMarkerToMarkerList(double lat, double lng) {
    markers.clear();
    Marker marker = Marker(
        markerId: MarkerId('currentSelected'), position: LatLng(lat, lng));
    setState(() {
      markers[marker.markerId] = marker;
    });
  }

  void resetCameraPosition() {
    markers.clear();
    animateCameraPosition(_center.latitude, _center.longitude, 1.0);
  }

  void animateCameraPosition(lat, lng, zoom) {
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, lng),
      zoom: zoom,
    )));
  }

  void detailsLinkClicked(String s, BuildContext context, state) {
    int countryId = getCountryId(state);
    int caseId = 1;
    switch (s) {
      case 'Country Data':
        _dialogHelpers.showCountryData(context, countryId, caseId);
        break;
      case 'Hotspot':
        _dialogHelpers.showHotspotData(context, countryId, caseId);
        break;
      case 'Rate of spread':
        _dialogHelpers.showRateOfSpreadData(context, countryId, caseId);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: searchSelected
              ? CupertinoButton(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        CupertinoIcons.back,
                        color: CupertinoColors.white,
                      ),
                      Text(
                        GlobalAppConstants.search,
                        style: TextStyle(
                          color: CupertinoColors.white,
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      searchSelected = false;
                      searchValue = "";
                      resetCameraPosition();
                    });
                  },
                )
              : Container(),
          backgroundColor: GlobalAppConstants.appMainColor,
        ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Stack(
            children: <Widget>[
              Container(
                child: GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _center, zoom: 1.0),
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) {
                    controller.setMapStyle(_mapStyle);
                    mapController = controller;
                    _controller.complete(controller);
                  },
                  markers: Set<Marker>.of(markers.values),
                ),
              ),
              Container(
                color: Color.fromRGBO(255, 255, 255, 0.7),
              ),
              searchSelected
                  ? Align(
                      //User already searched
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/graphics/outbreak-logo.jpeg'),
                          ),
                          Container(
                            width: 140.0,
                            padding: EdgeInsetsDirectional.only(
                                top: 20.0),
                            child: Divider(
                              thickness: 7.0,
                              color:
                              GlobalAppConstants.appMainColor,
                            ),
                          ),
                          Text(
                            GlobalAppConstants.countryData,
                            style: TextStyle(
                                color: GlobalAppConstants.appMainColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: EdgeInsetsDirectional.only(top: 20.0),
                          ),
                          Container(
                              height: 40,
                              color: CupertinoColors.white,
                              child: SizedBox.expand(
                                  child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Wrap(
                                  spacing: 30,
                                  direction: Axis.horizontal,
                                  alignment: WrapAlignment.spaceBetween,
                                  children: <Widget>[
                                    StoreConnector<AppState, AppState>(
                                      converter: (store) => store.state,
                                      builder: (context, state) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              detailsLinkClicked(
                                                  GlobalAppConstants.countryData,
                                                  context, state);
                                            });
                                          },
                                          child: Text(
                                            '${GlobalAppConstants.countryData}',
                                            style: TextStyle(
                                                color: GlobalAppConstants
                                                    .appMainColor),
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      },
                                    ),
                                    StoreConnector<AppState, AppState>(
                                      converter: (store) => store.state,
                                      builder: (context, state) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              detailsLinkClicked(
                                                  GlobalAppConstants.hotspot,
                                                  context, state);
                                            });
                                          },
                                          child: Text(
                                            '${GlobalAppConstants.hotspot}',
                                            style: TextStyle(
                                                color: GlobalAppConstants
                                                    .appMainColor),
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      },
                                    ),
                                    StoreConnector<AppState, AppState>(
                                      converter: (store) => store.state,
                                      builder: (context, state) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              detailsLinkClicked(
                                                  GlobalAppConstants.rateOfSpread,
                                                  context, state);
                                            });
                                          },
                                          child: Text(
                                            '${GlobalAppConstants.rateOfSpread}',
                                            style: TextStyle(
                                                color: GlobalAppConstants
                                                    .appMainColor),
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )))
                        ],
                      ),
                    )
                  : Stack(
                      children: <Widget>[
                        Container(
                          //User has not searched searched
                          padding: EdgeInsets.only(top: logoPaddingValueSearch),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topCenter,
                                child: AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastOutSlowIn,
                                  child: Column(
                                    children: <Widget>[
                                      Image(
                                        image: AssetImage(
                                            'assets/graphics/OT-logo.jpg'),
                                      ),
                                      Container(
                                        padding: EdgeInsetsDirectional.only(
                                            top: 20.0),
                                      ),
                                      Container(
                                        width: 140.0,
                                        child: Divider(
                                          thickness: 7.0,
                                          color:
                                              GlobalAppConstants.appMainColor,
                                        ),
                                      ),
                                      Text(
                                        GlobalAppConstants.searchCountry,
                                        style: TextStyle(
                                            color:
                                                GlobalAppConstants.appMainColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                          width: 250,
                                          padding: EdgeInsetsDirectional.only(
                                              top: 10.0),
                                          child: CupertinoButton(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    currentCountry,
                                                    style: TextStyle(
                                                        color: CupertinoColors
                                                            .black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            onPressed:
                                                _openCupertinoCountryPicker,
                                            color: CupertinoColors.white,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              width: 250,
                              padding: EdgeInsetsDirectional.only(bottom: 65.0),
                              child: CupertinoButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Next',
                                      style: TextStyle(
                                          color: CupertinoColors.black),
                                    ),
                                    Icon(
                                      CupertinoIcons.forward,
                                      color: CupertinoColors.black,
                                    ),
                                  ],
                                ),
                                onPressed: () {
//                                        showProgressBar();
                                  if (searchValue == '') {
                                    searchValue =
                                        CountryPickerUtils.getCountryByIsoCode(
                                                'KE')
                                            .name;
                                  }
                                  findSearchedLocation(searchValue)
                                      .then((value) {
                                    setState(() {
                                      locationLatLng = value;
                                      addMarkerToMarkerList(
                                          value.lat, value.lng);
                                      animateCameraPosition(
                                          value.lat, value.lng, 5.0);
                                      if (value.lat != null) {
                                        searchSelected = true;
                                      }
                                    });
                                  });
                                },
                                color: CupertinoColors.white,
                              )),
                        ),
                      ],
                    )
            ],
          ),
        ));
  }

  void _openCupertinoCountryPicker() => showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 150),
          child: ListView(
            children: <Widget>[
              CountryPickerCupertino(
                backgroundColor: Colors.white,
                itemBuilder: _buildCupertinoItem,
                pickerSheetHeight: 500.0,
                pickerItemHeight: 75,
                onValuePicked: (Country country) {
                  setState(() {
                    currentCountry = country.name;
                    searchValue = country.name;
                  });
                },
                initialCountry: CountryPickerUtils.getCountryByIsoCode('KE'),
              ),
              CupertinoButton(
                child: Row(
                  children: <Widget>[
                    Text(
                      'Done',
                      style: TextStyle(color: CupertinoColors.black),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  setState(() {
                    currentCountry = searchValue;
                  });
                },
                color: CupertinoColors.white,
              )
            ],
          ),
        );
      });

  Widget _buildCupertinoItem(Country country) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: CupertinoColors.black,
        fontSize: 16.0,
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: 8.0),
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          Text("+${country.phoneCode}"),
          SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      ),
    );
  }

  void showProgressBar() {}

  int getCountryId(state) {
    int countryId = state.countries[currentCountry]['id'];
    return countryId;
  }
}
