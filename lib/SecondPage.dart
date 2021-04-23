import 'package:demo1/Location Fetcher.dart';
import 'package:demo1/ThirdPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:demo1/variablesFunctions.dart';
import 'package:sizer/sizer.dart';
class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _key = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GetLocation gl= GetLocation();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Future<void> myLocation()async
  {
    Position l1= await gl.determinePosition();
    myLat=l1.latitude;myLong=l1.longitude;
    locationStorage.putIfAbsent(l1.latitude.toDouble(), () => l1.longitude.toDouble());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Form(
                key: _key,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: NoOfPeople-1,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.all(1.0.h),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                icon: Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                ),
                                labelText:
                                "Enter latitude and longitude of person no ${index + 1}",
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: false, decimal: true),
                              onSaved: (value) {
                                print(value);
                                var z= value.toString().split(' ').first;
                                var y= value.toString().split(' ').last;
                                locationStorage.putIfAbsent(double.parse(z), () => double.parse(y));
                                // locationAdder();
                              },
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(bottom: 4.0.h),
              child: Column(
                children: [
                  Text("Wait for the pop-up after pressing below button",style: TextStyle(fontSize: 10.0.sp),)
,
                  ElevatedButton(
                      onPressed: ()async{
                        await myLocation();
                        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Location Fetched, Latitude:${myLat}, Longitude:${myLong}"),
                          duration: Duration(seconds: 2),
                        ));
                      },
                      child: Text("Get My Location")),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(bottom:3.0.h),
              child: ElevatedButton(
                  onPressed: () {
                    if (_key.currentState.validate()) {
                      _key.currentState.save();
                          getCentroid(k);
                          k++;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondPages()));
                    }
                  },
                  child: Text("Save and Next")),
            ),
          ],
        ),
      ),
    );
  }
}
