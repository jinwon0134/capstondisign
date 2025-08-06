import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _mapController;
  final TextEditingController _searchController = TextEditingController();
  LatLng? _searchedLocation;
  final Set<Marker> _markers = {};

  Future<void> _searchLocation(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        final loc = locations.first;
        setState(() {
          _searchedLocation = LatLng(loc.latitude, loc.longitude);
          _markers.clear();
          _markers.add(
            Marker(
              markerId: const MarkerId('searched'),
              position: _searchedLocation!,
              infoWindow: InfoWindow(title: address),
            ),
          );
        });

        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(_searchedLocation!, 16),
        );
      }
    } catch (e) {
      print('검색 실패: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('위치를 찾을 수 없습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("금연 정보"),
        leading: BackButton(),
      ),
      body: Column(
        children: [
          // 위치 검색창
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: "대전대학교 서문",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: _searchLocation,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _searchController.clear();
                  },
                ),
              ],
            ),
          ),

          // 구글맵 위젯
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(36.336, 127.452), // 기본 위치: 대전대 근처
                zoom: 15,
              ),
              markers: _markers,
              onMapCreated: (controller) => _mapController = controller,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),

          // 위치 저장 버튼
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {
                  if (_searchedLocation != null) {
                    print("저장된 위치: $_searchedLocation");
                    // TODO: 저장 로직 구현
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("먼저 위치를 검색해주세요.")),
                    );
                  }
                },
                child: const Text("위치 저장하기",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
