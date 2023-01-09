class ProvaState {

	final bool isFetching;
	final bool hasError;
	final int id;
	final String nome;
	final String indirizzo;

	ProvaState({
		required this.isFetching,
		required this.hasError,
		required this.id,
		required this.nome,
		required this.indirizzo,
	});

	ProvaState copyWith({
		bool? isFetching,
		bool? hasError,
		int? id,
		String? nome,
		String? indirizzo,
	}) {
		return ProvaState(
			isFetching: isFetching ?? this.isFetching,
			hasError: hasError ?? this.hasError,
			id: id ?? this.id,
			nome: nome ?? this.nome,
			indirizzo: indirizzo ?? this.indirizzo,
		);
	}

	factory ProvaState.initial() {
		return ProvaState(
			isFetching: false,
			hasError: false,
			id: 0,
			nome: "",
			indirizzo: "",
		);
	}

	factory ProvaState.fromJson(Map<String, dynamic> json) {
		return ProvaState(
			isFetching: json.decode(json['isFetching']),
			hasError: json.decode(json['hasError']),
			id: json.decode(json['id']),
			nome: json.decode(json['nome']),
			indirizzo: json.decode(json['indirizzo']),
		);
	}

	Map<String, dynamic> toJson() => {
		'isFetching': json.encode(isFetching),
		'hasError': json.encode(hasError),
		'id': json.encode(id),
		'nome': json.encode(nome),
		'indirizzo': json.encode(indirizzo),
	};

	@override
	bool operator ==(Object other) => 
		identical(this, other) || 
		other is ProvaState && 
		isFetching == other.isFetching &&
		hasError == other.hasError &&
		id == other.id &&
		nome == other.nome &&
		indirizzo == other.indirizzo;

	@override
	int get hashCode => super.hashCode ^ 
		isFetching.hashCode ^
		hasError.hashCode ^
		id.hashCode ^
		nome.hashCode ^
		indirizzo.hashCode;
}