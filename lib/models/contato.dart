class Contato {
  final int id;
  final String nomeContato;
  final int numeroContaContato;

  Contato(
    this.id,
    this.nomeContato,
    this.numeroContaContato,
  );

  @override
  String toString() {
    return 'Contato{id: $id,nomeContato: $nomeContato, numeroContaContato: $numeroContaContato}';
  }

  Contato.fromJson(Map<String, dynamic> json) : //pega um json via parâmetro e o converte para um objeto
        id = json['id'],
        nomeContato = json['name'],
        numeroContaContato = json['accountNumber'];

  Map<String, dynamic> toJson() => { //pega o objeto e devolve um mapa
    'name' : nomeContato,
    'accountNumber' : numeroContaContato,
  };
}
