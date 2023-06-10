class StoreModel {
  int? id;
  String? title;
  num? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  StoreModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: Rating.fromJson(json['rating']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
        'rating': rating?.toJson(),
      };
}

class Rating {
  num? rate;
  int? count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json['rate'],
        count: json['count'],
      );

  Map<String, dynamic> toJson() => {
        'rate': rate,
        'count': count,
      };
}
