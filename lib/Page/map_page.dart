import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _mapController;
  final TextEditingController _searchController = TextEditingController();

  LatLng? _searchedLocation;

  // 1. 미리 지정한 흡연 구역 좌표 리스트
  final List<LatLng> smokingZones = [
    LatLng(36.3369, 127.4604), // 혜화
    LatLng(36.336532, 127.457777), // 문무
    LatLng(36.335830, 127.458063), // 융과
    LatLng(36.3370133, 127.458858), // 인사관
    LatLng(36.333558, 127.461979), // 응용과학관
    LatLng(36.335536, 127.461502), // 창학관옆
    LatLng(36.336378, 127.458901), // 한의학과 배드민턴장
    LatLng(36.336235, 127.46079), // 30주년 4층
    LatLng(36.336480, 127.46165), // 자산도서관
    LatLng(36.337579, 127.459528), // 기숙사 밥
  ];

  final Set<Marker> _markers = {};
  BitmapDescriptor? customIcon;

  @override
  void initState() {
    super.initState();
    _loadCustomMarker();
  }

  Future<void> _loadCustomMarker() async {
    // 원본 이미지 불러오기
    final byteData = await rootBundle.load('assets/images/dambae.png');

    // 원하는 크기로 리사이즈 (targetWidth 조절)
    final codec = await ui.instantiateImageCodec(
      byteData.buffer.asUint8List(),
      targetWidth: 80, // ← 여기 숫자 줄이면 더 작아짐 (예: 32, 24)
    );
    final frameInfo = await codec.getNextFrame();

    final resizedData =
        await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List resizedBytes = resizedData!.buffer.asUint8List();

    final icon = BitmapDescriptor.fromBytes(resizedBytes);

    setState(() {
      customIcon = icon;

      for (int i = 0; i < smokingZones.length; i++) {
        _markers.add(
          Marker(
            markerId: MarkerId('smoking_zone_$i'),
            position: smokingZones[i],
            infoWindow: InfoWindow(title: '흡연 구역 #${i + 1}'),
            icon: customIcon!,
          ),
        );
      }
    });
  }

  Future<void> _searchLocation(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        final loc = locations.first;
        setState(() {
          _searchedLocation = LatLng(loc.latitude, loc.longitude);
          _markers.removeWhere((m) => m.markerId.value == 'searched');
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
            // 초기 카메라 위치는 대전대 중심 좌표로 설정
            initialCameraPosition: const CameraPosition(
              target: LatLng(36.335668, 127.460049), // 대전대 중심 좌표
              zoom: 16,
            ),
            cameraTargetBounds: CameraTargetBounds(
              LatLngBounds(
                southwest: LatLng(36.33189, 127.45252), // 대전대 남서쪽 끝
                northeast: LatLng(36.33887, 127.46395), // 대전대 북동쪽 끝
              ),
            ),

            markers: _markers,
            onMapCreated: (controller) => _mapController = controller,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          )),

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
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({Key? key}) : super(key: key);

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   GoogleMapController? _mapController;
//   final Set<Marker> _markers = {};
//   BitmapDescriptor? customIcon;

//   @override
//   void initState() {
//     super.initState();
//     _loadCustomMarker();
//   }

//   Future<void> _loadCustomMarker() async {
//     final icon = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(size: Size(48, 48)), // 마커 크기
//       'assets/images/dambae.png',
//     );
//     setState(() {
//       customIcon = icon;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         initialCameraPosition: const CameraPosition(
//           target: LatLng(37.5665, 126.9780), // 서울 좌표
//           zoom: 14,
//         ),
//         onMapCreated: (controller) {
//           _mapController = controller;

//           if (customIcon != null) {
//             setState(() {
//               _markers.add(
//                 Marker(
//                   markerId: const MarkerId('smokingSpot'),
//                   position: const LatLng(37.5665, 126.9780),
//                   icon: customIcon!,
//                   infoWindow: const InfoWindow(
//                     title: '흡연 지정 구역',
//                     snippet: '여기서만 흡연 가능합니다.',
//                   ),
//                 ),
//               );
//             });
//           }
//         },
//         markers: _markers,
//       ),
//     );
//   }
// }
