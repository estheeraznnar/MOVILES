class SuperheroResponseDetail {

  final String id;
  final String name;
  final String url;
  

  SuperheroResponseDetail({required this.id, required this.name, required this.url});

  factory SuperheroResponseDetail.fromJson(Map<String, dynamic> json){
    return SuperheroResponseDetail(
      id: json['id'],
      name: json['name'],
      url: json['image']['url']
    );
  }

}