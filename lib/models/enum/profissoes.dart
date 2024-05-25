enum Profissoes {
  LIMPEZA,
  JARDINAGEM,
  MUDANCA,
  MANUTENCAO,
  ENTREGAS,
  SEGURANCA_RESIDENCIAL,
  CANALIZACAO,
  INSTALACOES_ELETRICAS,
  MONTAGEM_MOVEIS,
}

extension ProfissoesExtension on Profissoes {
  String get descricao {
    switch (this) {
      case Profissoes.LIMPEZA:
        return "Limpeza";
      case Profissoes.JARDINAGEM:
        return "Jardinagem";
      case Profissoes.MUDANCA:
        return "Mudança";
      case Profissoes.MANUTENCAO:
        return "Manutenção";
      case Profissoes.ENTREGAS:
        return "Entregas";
      case Profissoes.SEGURANCA_RESIDENCIAL:
        return "Segurança Residencial";
      case Profissoes.CANALIZACAO:
        return "Canalização";
      case Profissoes.INSTALACOES_ELETRICAS:
        return "Instalações Elétricas";
      case Profissoes.MONTAGEM_MOVEIS:
        return "Montagem de Móveis";
      default:
        return '';
    }
  }
  
static Profissoes fromString(String str) {
  switch (str) {
    case "LIMPEZA":
      return Profissoes.LIMPEZA;
    case "JARDINAGEM":
      return Profissoes.JARDINAGEM;
    case "MUDANCA":
      return Profissoes.MUDANCA;
    case "MANUTENCAO":
      return Profissoes.MANUTENCAO;
    case "ENTREGAS":
      return Profissoes.ENTREGAS;
    case "SEGURANCA_RESIDENCIAL":
      return Profissoes.SEGURANCA_RESIDENCIAL;
    case "CANALIZACAO":
      return Profissoes.CANALIZACAO;
    case "INSTALACOES_ELETRICAS":
      return Profissoes.INSTALACOES_ELETRICAS;
    case "MONTAGEM_MOVEIS":
      return Profissoes.MONTAGEM_MOVEIS;
    default:
      throw Exception('Profissao desconhecida: $str');
  }
}

}
