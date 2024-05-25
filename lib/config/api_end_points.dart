import 'package:sistema_de_prestacao_de_servicos_domesticos/config/config_host.dart';

class ApiEndpoints {
  static String loginUrl = "${ConfigHost.baseUrl}/auth/login";
  static String userInfoRoleUrl = "${ConfigHost.baseUrl}/auth/user";
  static String userRegister = "${ConfigHost.baseUrl}/auth/register";

  //Profissional
  static String userRegisterProfissional = "${ConfigHost.baseUrl}/profissional/criar";
  static String userUpdateProfissional = "${ConfigHost.baseUrl}/profissional/atualizar";
  static String userDetalhesProfissional = "${ConfigHost.baseUrl}/profissional/detalhes";
  static String userDisponibilidadeProfissional = "${ConfigHost.baseUrl}/profissional/disponibilidade";

  static String listarProfissionaisPorProfissao(String profissao) {
    return "${ConfigHost.baseUrl}/profissional/profissao/$profissao";

  }
  static String deleteProfissionalById(int id) {
    return "${ConfigHost.baseUrl}/profissional/excluir/" + id.toString();
  }

  //Cliente
  static String userRegisterCliente = "${ConfigHost.baseUrl}/cliente/criar";
  static String userUpdateCliente = "${ConfigHost.baseUrl}/cliente/atualizar";

  static String deleteClienteById(int id) {
    return "${ConfigHost.baseUrl}/cliente/excluir/" + id.toString();
  }

  //Servicos
  static String serviceAdcionar = "${ConfigHost.baseUrl}/servicos/adicionar";
  static String serviceMeus = "${ConfigHost.baseUrl}/servicos/meus";
  static String serviceListar = "${ConfigHost.baseUrl}/servicos/listar";
  static String serviceAvaliacoes = "${ConfigHost.baseUrl}/servicos/avaliacoes";

  static String deleteServiceById(int id) {
    return "${ConfigHost.baseUrl}/servicos/excluir/" + id.toString();
  }
   static String listarServiceByIdProfissional(int id) {
    return "${ConfigHost.baseUrl}/servicos/lista/" + id.toString();
  }

//Pedidos 
 static String pedidoEnviar = "${ConfigHost.baseUrl}/pedidos/enviar";
 static String pedidoListarProfissional = "${ConfigHost.baseUrl}/pedidos/profissional";
 static String pedidoListarCliente = "${ConfigHost.baseUrl}/pedidos/cliente";

static String pedidoAtualizarEstado(int id) {
    return "${ConfigHost.baseUrl}/pedidos/status/" + id.toString();
  } 

  static String pedidoAvaliacaoPedido(int id) {
    return "${ConfigHost.baseUrl}/pedidos/avaliacao/" + id.toString();
  } 
}