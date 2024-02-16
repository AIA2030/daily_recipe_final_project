class Ads {
  String? docId;
  String? name;
  String? image;


  Ads();


  Ads.fromJson(Map<String, dynamic> data, [String? id]) {
    docId = id;
    name = data['name'];
    image = data['image'];

  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "image": image,

    };
  }
}

