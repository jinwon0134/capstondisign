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

  // 미리 지정한 흡연 구역 좌표 리스트
  final List<LatLng> smokingZones = [
    LatLng(36.3369, 127.4604),
    LatLng(36.3350, 127.4500),
    LatLng(36.3380, 127.4550),
  ];

  final Set<Marker> _markers = {};
  int _userMarkerIdCounter = 0; // 유저가 찍는 마커 고유 ID 카운터

  @override
  void initState() {
    super.initState();

    // 미리 지정한 흡연 구역 마커 추가
    for (int i = 0; i < smokingZones.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId('smoking_zone_$i'),
          position: smokingZones[i],
          infoWindow: InfoWindow(title: '흡연 구역 #${i + 1}'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        ),
      );
    }
  }

  Future<void> _searchLocation(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        final loc = locations.first;
        setState(() {
          _searchedLocation = LatLng(loc.latitude, loc.longitude);

          // 기존 검색 마커 제거
          _markers.removeWhere((m) => m.markerId.value == 'searched');
          // 검색 위치 마커 추가
          _markers.add(
            Marker(
              markerId: const MarkerId('searched'),
              position: _searchedLocation!,
              infoWindow: InfoWindow(title: address),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
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

  void _onMapTapped(LatLng pos) {
    setState(() {
      final markerId = MarkerId('user_marker_$_userMarkerIdCounter');
      _userMarkerIdCounter++;

      _markers.add(
        Marker(
          markerId: markerId,
          position: pos,
          infoWindow: InfoWindow(title: '내가 찍은 위치'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          onTap: () {
            print('내가 찍은 마커 클릭됨: ${pos.latitude}, ${pos.longitude}');
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _mapController?.dispose();
    _searchController.dispose();
    super.dispose();
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
                target: LatLng(36.3366, 127.4529), // 대전대 중심 좌표
                zoom: 16,
              ),
              markers: _markers,
              onMapCreated: (controller) => _mapController = controller,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onTap: _onMapTapped, // 지도 탭 시 마커 찍기
              cameraTargetBounds: CameraTargetBounds(
                LatLngBounds(
                  southwest: LatLng(36.3318, 127.4525),
                  northeast: LatLng(36.3388, 127.4639),
                ),
              ),
              minMaxZoomPreference: MinMaxZoomPreference(15, 20),
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
                  if (_markers.isNotEmpty) {
                    print("저장된 마커 위치들:");
                    for (var marker in _markers) {
                      print(
                          '${marker.markerId.value}: ${marker.position.latitude}, ${marker.position.longitude}');
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("마커 위치가 콘솔에 출력되었습니다.")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("찍힌 마커가 없습니다.")),
                    );
                  }
                },
                child: const Text(
                  "위치 저장하기",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
