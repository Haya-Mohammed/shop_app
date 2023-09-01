class SearchModel {
  late bool status;
  late String message;
  late DataModel data;

  SearchModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  late int? currentPage;
  late List<ProductModel> data = [];
  late String? firstPageUrl;
  late int? from;
  late int? lastPage;
  late String? lastPageUrl;
  late String? nextPageUrl;
  late String? path;
  late int? perPage;
  late String? prevPageUrl;
  late int? to;
  late int? total;

  DataModel.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(ProductModel.fromJson(element));
    });
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    currentPage = json['next_page_url'];
    nextPageUrl = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class ProductModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}