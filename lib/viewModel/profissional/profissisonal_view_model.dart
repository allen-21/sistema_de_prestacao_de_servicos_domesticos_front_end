import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/config/api_end_points.dart';


class ProfissionalViewModel extends ChangeNotifier {
  Map<String, dynamic>? userDetails;
  String? token;

  Future<void> fetchUserDetails() async {
    final response = await http.get(
      Uri.parse(ApiEndpoints.userDetalhesProfissional),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      userDetails = json.decode(response.body);
      notifyListeners();
    } else {
      throw Exception('Failed to load user details');
    }
  }

  Future<void> alterarDisponibilidade(bool novaDisponibilidade) async {
    final response = await http.patch(
      Uri.parse(ApiEndpoints.userDisponibilidadeProfissional),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: json.encode({"novaDisponibilidade": novaDisponibilidade}),
    );

    if (response.statusCode == 200) {
      await fetchUserDetails();
    } else {
      throw Exception('Failed to update availability');
    }
  }

  
}
