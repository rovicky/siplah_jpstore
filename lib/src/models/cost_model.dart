// To parse this JSON data, do
//
//     final costModel = costModelFromJson(jsonString);

import 'dart:convert';

CostModel costModelFromJson(String str) => CostModel.fromJson(json.decode(str));

String costModelToJson(CostModel data) => json.encode(data.toJson());

class CostModel {
  Rajaongkir rajaongkir;

  CostModel({
    this.rajaongkir,
  });

  factory CostModel.fromJson(Map<String, dynamic> json) => CostModel(
    rajaongkir: json["rajaongkir"] == null ? null : Rajaongkir.fromJson(json["rajaongkir"]),
  );

  Map<String, dynamic> toJson() => {
    "rajaongkir": rajaongkir == null ? null : rajaongkir.toJson(),
  };
}

class Rajaongkir {
  Query query;
  Status status;
  NDetails originDetails;
  NDetails destinationDetails;
  List<Result> results;

  Rajaongkir({
    this.query,
    this.status,
    this.originDetails,
    this.destinationDetails,
    this.results,
  });

  factory Rajaongkir.fromJson(Map<String, dynamic> json) => Rajaongkir(
    query: json["query"] == null ? null : Query.fromJson(json["query"]),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    originDetails: json["origin_details"] == null ? null : NDetails.fromJson(json["origin_details"]),
    destinationDetails: json["destination_details"] == null ? null : NDetails.fromJson(json["destination_details"]),
    results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "query": query == null ? null : query.toJson(),
    "status": status == null ? null : status.toJson(),
    "origin_details": originDetails == null ? null : originDetails.toJson(),
    "destination_details": destinationDetails == null ? null : destinationDetails.toJson(),
    "results": results == null ? null : List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class NDetails {
  String subdistrictId;
  String provinceId;
  String province;
  String cityId;
  String city;
  String type;
  String subdistrictName;

  NDetails({
    this.subdistrictId,
    this.provinceId,
    this.province,
    this.cityId,
    this.city,
    this.type,
    this.subdistrictName,
  });

  factory NDetails.fromJson(Map<String, dynamic> json) => NDetails(
    subdistrictId: json["subdistrict_id"] == null ? null : json["subdistrict_id"],
    provinceId: json["province_id"] == null ? null : json["province_id"],
    province: json["province"] == null ? null : json["province"],
    cityId: json["city_id"] == null ? null : json["city_id"],
    city: json["city"] == null ? null : json["city"],
    type: json["type"] == null ? null : json["type"],
    subdistrictName: json["subdistrict_name"] == null ? null : json["subdistrict_name"],
  );

  Map<String, dynamic> toJson() => {
    "subdistrict_id": subdistrictId == null ? null : subdistrictId,
    "province_id": provinceId == null ? null : provinceId,
    "province": province == null ? null : province,
    "city_id": cityId == null ? null : cityId,
    "city": city == null ? null : city,
    "type": type == null ? null : type,
    "subdistrict_name": subdistrictName == null ? null : subdistrictName,
  };
}

class Query {
  String origin;
  String originType;
  String destination;
  String destinationType;
  int weight;
  String courier;

  Query({
    this.origin,
    this.originType,
    this.destination,
    this.destinationType,
    this.weight,
    this.courier,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
    origin: json["origin"] == null ? null : json["origin"],
    originType: json["originType"] == null ? null : json["originType"],
    destination: json["destination"] == null ? null : json["destination"],
    destinationType: json["destinationType"] == null ? null : json["destinationType"],
    weight: json["weight"] == null ? null : json["weight"],
    courier: json["courier"] == null ? null : json["courier"],
  );

  Map<String, dynamic> toJson() => {
    "origin": origin == null ? null : origin,
    "originType": originType == null ? null : originType,
    "destination": destination == null ? null : destination,
    "destinationType": destinationType == null ? null : destinationType,
    "weight": weight == null ? null : weight,
    "courier": courier == null ? null : courier,
  };
}

class Result {
  String code;
  String name;
  List<ResultCost> costs;

  Result({
    this.code,
    this.name,
    this.costs,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    code: json["code"] == null ? null : json["code"],
    name: json["name"] == null ? null : json["name"],
    costs: json["costs"] == null ? null : List<ResultCost>.from(json["costs"].map((x) => ResultCost.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "name": name == null ? null : name,
    "costs": costs == null ? null : List<dynamic>.from(costs.map((x) => x.toJson())),
  };
}

class ResultCost {
  String service;
  String description;
  List<CostCost> cost;

  ResultCost({
    this.service,
    this.description,
    this.cost,
  });

  factory ResultCost.fromJson(Map<String, dynamic> json) => ResultCost(
    service: json["service"] == null ? null : json["service"],
    description: json["description"] == null ? null : json["description"],
    cost: json["cost"] == null ? null : List<CostCost>.from(json["cost"].map((x) => CostCost.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "service": service == null ? null : service,
    "description": description == null ? null : description,
    "cost": cost == null ? null : List<dynamic>.from(cost.map((x) => x.toJson())),
  };
}

class CostCost {
  int value;
  String etd;
  String note;

  CostCost({
    this.value,
    this.etd,
    this.note,
  });

  factory CostCost.fromJson(Map<String, dynamic> json) => CostCost(
    value: json["value"] == null ? null : json["value"],
    etd: json["etd"] == null ? null : json["etd"],
    note: json["note"] == null ? null : json["note"],
  );

  Map<String, dynamic> toJson() => {
    "value": value == null ? null : value,
    "etd": etd == null ? null : etd,
    "note": note == null ? null : note,
  };
}

class Status {
  int code;
  String description;

  Status({
    this.code,
    this.description,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    code: json["code"] == null ? null : json["code"],
    description: json["description"] == null ? null : json["description"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "description": description == null ? null : description,
  };
}
