import 'package:gasejakt/business_logic/models/kommune.dart';
import 'package:gasejakt/services/location/location_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationServiceImpl extends LocationService {
  final _kommuneHost = "ws.geonorge.no";
  final _kommunePath = "kommuneinfo/v1/kommuner";
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  final List<Kommune> _kommunelist = [];

  @override
  Future<List<Kommune>> getKommuner() async {
    if (_kommunelist.length > 0) return _kommunelist; //?
    _kommunelist.clear();
    final uri = Uri.https(_kommuneHost, _kommunePath);
    http.Response response = await http.get(uri, headers: _headers);
    final jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    jsonResponse.map((json) {
      _kommunelist.add(Kommune.fromJson(json));
    }).toList();
    _kommunelist.sort((a, b) => a.compareTo(b));
    // _kommunelist.sort((a, b) {
    //   if (a.isSelected && !b.isSelected)
    //     return -1;
    //   else
    //     return a.navn.compareTo(b.navn);
    // });

    return _kommunelist;
  }

  @override
  Future<Kommune> getSelectedKommune() async {
    var selectedKommune = _kommunelist
            ?.firstWhere((kommune) => kommune.isSelected, orElse: () => null) ??
        null;
    return selectedKommune;
  }

  @override
  void setSelectedKommune(String kommunenummer) {
    for (Kommune pres in _kommunelist) {
      pres.isSelected = pres.id == kommunenummer;
    }
    _kommunelist.sort((a, b) => a.compareTo(b));
  }
}
