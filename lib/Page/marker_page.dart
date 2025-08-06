// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoding/geocoding.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({super.key});

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   GoogleMapController? _mapController;
//   final TextEditingController _searchController = TextEditingController();

//   LatLng? _searchedLocation;

//   // 1. 미리 지정한 흡연 구역 좌표 리스트
//   final List<LatLng> smokingZones = [
//     LatLng(36.3375, 127.4530),
//     LatLng(36.3350, 127.4500),
//     LatLng(36.3380, 127.4550),
//   ];

//   // 마커 집합
//   final Set<Marker> _markers = {};

//   @override
//   void initState() {
//     super.initState();

//     // 2. 미리 지정한 흡연 구역 마커 추가
//     for (int i = 0; i < smokingZones.length; i++) {
//       _markers.add(
//         Marker(
//           markerId: MarkerId('smoking_zone_$i'),
//           position: smokingZones[i],
//           infoWindow: InfoWindow(title: '흡연 구역 #${i + 1}'),
//           icon:
//               BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
//         ),
//       );
//     }
//   }

//   Future<void> _searchLocation(String address) async {
//     try {
//       List<Location> locations = await locationFromAddress(address);
//       if (locations.isNotEmpty) {
//         final loc = locations.first;
//         setState(() {
//           _searchedLocation = LatLng(loc.latitude, loc.longitude);

//           // 검색 위치 마커는 기존에 있던 검색 마커만 지우고 추가
//           _markers.removeWhere((m) => m.markerId.value == 'searched');
//           _markers.add(
//             Marker(
//               markerId: const MarkerId('searched'),
//               position: _searchedLocation!,
//               infoWindow: InfoWindow(title: address),
//               icon: BitmapDescriptor.defaultMarkerWithHue(
//                   BitmapDescriptor.hueBlue),
//             ),
//           );
//         });

//         _mapController?.animateCamera(
//           CameraUpdate.newLatLngZoom(_searchedLocation!, 16),
//         );
//       }
//     } catch (e) {
//       print('검색 실패: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('위치를 찾을 수 없습니다.')),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _mapController?.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("금연 정보"),
//         leading: BackButton(),
//       ),
//       body: Column(
//         children: [
//           // 위치 검색창
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _searchController,
//                     decoration: const InputDecoration(
//                       hintText: "대전대학교 서문",
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.search),
//                     ),
//                     onSubmitted: _searchLocation,
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.close),
//                   onPressed: () {
//                     _searchController.clear();
//                   },
//                 ),
//               ],
//             ),
//           ),

//           // 구글맵 위젯
//           Expanded(
//               child: GoogleMap(
//             // 초기 카메라 위치는 대전대 중심 좌표로 설정
//             initialCameraPosition: const CameraPosition(
//               target: LatLng(36.3366, 127.4529), // 대전대 중심 좌표
//               zoom: 16,
//             ),
//             cameraTargetBounds: CameraTargetBounds(
//               LatLngBounds(
//                 southwest: LatLng(36.332, 127.448), // 대전대 남서쪽 끝
//                 northeast: LatLng(36.342, 127.458), // 대전대 북동쪽 끝
//               ),
//             ),

//             markers: _markers,
//             onMapCreated: (controller) => _mapController = controller,
//             myLocationEnabled: true,
//             myLocationButtonEnabled: true,
//           )),

//           // 위치 저장 버튼
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
//                 onPressed: () {
//                   if (_searchedLocation != null) {
//                     print("저장된 위치: $_searchedLocation");
//                     // TODO: 저장 로직 구현
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("먼저 위치를 검색해주세요.")),
//                     );
//                   }
//                 },
//                 child: const Text("위치 저장하기",
//                     style: TextStyle(color: Colors.white)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
