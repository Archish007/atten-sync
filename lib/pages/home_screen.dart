import 'package:attensync/helpers/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LatLng currentLocation = getCurrentLatLngFromSharedPrefs();
  late String currentAddress;
  late CameraOptions _initialCameraPosition;

  @override
  void initState() {
    super.initState();

    // Set initial camera position and current address
    _initialCameraPosition = CameraOptions(
      center: Point(
        coordinates: Position(
          currentLocation.longitude,
          currentLocation.latitude,
        ),
      ),
      zoom: 14,
    );
    currentAddress = getCurrentAddressFromSharedPrefs();
  }

  //final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    //FirebaseAuth.instance.signOut();
  }

  void ConfirmLogout() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              elevation: 10,
              shadowColor: Colors.grey.shade700,
              backgroundColor: Colors.grey.shade200,
              title: const Center(child: Text('Leaving Already?')),
              content: const Text(
                "Sign out now?",
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.grey.shade100)),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'No',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.grey.shade100)),
                        onPressed: () async {
                          Navigator.pop(context);
                          signUserOut();
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'AttenSync',
          style: TextStyle(
            color: Colors.black,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            onPressed: ConfirmLogout,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Stack(
        children: [
          // Mapbox Map added here and user location enabled
          MapWidget(
            key: const ValueKey("mapWidget"),
            styleUri: MapboxStyles.MAPBOX_STREETS,
            cameraOptions: _initialCameraPosition,
            onMapCreated: (MapboxMap mapboxMap) {
              // Enable user location
              mapboxMap.location.updateSettings(LocationComponentSettings(
                enabled: true,
                pulsingEnabled: true,
              ));
            },
            mapOptions: MapOptions(
              contextMode: ContextMode.UNIQUE,
              constrainMode: ConstrainMode.HEIGHT_ONLY,
              viewportMode: ViewportMode.DEFAULT,
              orientation: NorthOrientation.UPWARDS,
              crossSourceCollisions: true,
              pixelRatio: MediaQuery.of(context).devicePixelRatio,
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        '...',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      const Text('You are currently here:'),
                      Text(
                        currentAddress,
                        style: const TextStyle(color: Colors.indigo),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => {},
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20),
                            backgroundColor: Colors.amberAccent),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '...',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
