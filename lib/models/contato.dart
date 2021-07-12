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
}
