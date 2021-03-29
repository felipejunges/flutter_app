class ContaBancaria {
  int id;
  String descricao;
  String numeroBanco;
  String agencia;
  String numeroConta;
  bool ativo;
  double saldoInicial;

  ContaBancaria.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        descricao = json['descricao'],
        numeroBanco = json['numeroBanco'],
        agencia = json['agencia'],
        numeroConta = json['numeroConta'],
        ativo = json['ativo'],
        saldoInicial = json['saldoInicial'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    data['numeroBanco'] = this.numeroBanco;
    data['agencia'] = this.agencia;
    data['numeroConta'] = this.numeroConta;
    data['ativo'] = this.ativo;
    data['saldoInicial'] = this.saldoInicial;
    return data;
  }
}
