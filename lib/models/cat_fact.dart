class CatFact {
  String? fact;
  int? length;

  CatFact({this.fact, this.length});

  CatFact.fromJson(Map<String, dynamic> json) {
    fact = json['fact'];
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['fact'] = fact;
    data['length'] = length;
    return data;
  }

  @override
  String toString() => 'Cat(fact: $fact, length: $length)';
}
