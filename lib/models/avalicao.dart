class Avaliacao {
  final int id;
  final String comentario;
  final int nota;

  Avaliacao({required this.id, required this.comentario, required this.nota});

  factory Avaliacao.fromJson(Map<String, dynamic> json) {
    return Avaliacao(
      id: json['id'],
      comentario: json['comentario'],
      nota: json['nota'],
    );
  }
}