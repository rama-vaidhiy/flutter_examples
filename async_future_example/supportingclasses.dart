//{id: 3, name: Clementine Bauch, username: Samantha, email: Nathan@yesenia.net,
// address: {street: Douglas Extension, suite: Suite 847, city: McKenziehaven,
// zipcode: 59590-4157, geo: {lat: -68.6102, lng: -47.0653}}, phone: 1-463-123-4447,
// website: ramiro.info, company: {name: Romaguera-Jacobson,
// catchPhrase: Face to face bifurcated interface, bs: e-enable strategic applications}}

//geo: {lat: -68.6102, lng: -47.0653}
class Geo {
  String lat;
  String lng;

  Geo({required this.lat, required this.lng});

  factory Geo.fromJson(Map<String, dynamic> inputData) {
    return Geo(lat: inputData['lat'], lng: inputData['lng']);
  }

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };
}

//address: {street: Douglas Extension, suite: Suite 847, city: McKenziehaven,
// zipcode: 59590-4157, geo: {lat: -68.6102, lng: -47.0653}}
class Address {
  String street;
  String suite;
  String city;
  String zipcode;
  Geo geo;

  Address(
      {required this.street,
      required this.suite,
      required this.city,
      required this.zipcode,
      required this.geo});

  factory Address.fromJson(Map<String, dynamic> inputData) {
    return Address(
      city: inputData['city'],
      suite: inputData['suite'],
      street: inputData['street'],
      zipcode: inputData['zipcode'],
      geo: Geo.fromJson(inputData['geo']),
    );
  }

  Map<String, dynamic> toJson() => {
        'city': city,
        'suite': suite,
        'street': street,
        'zipcode': zipcode,
        'geo': geo.toJson(),
      };
}

//company: {name: Romaguera-Jacobson,
// catchPhrase: Face to face bifurcated interface, bs: e-enable strategic applications}
class Company {
  String name;
  String catchphrase;
  String bs;

  Company({required this.name, required this.catchphrase, required this.bs});
  factory Company.fromJson(Map<String, dynamic> inputData) {
    return Company(
        name: inputData['name'],
        catchphrase: inputData['catchPhrase'],
        bs: inputData['bs']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'catchPhrase': catchphrase,
        'bs': bs,
      };
}

class User {
  int id;
  String name;
  String username;
  String email;
  Address address;
  String phone;
  String website;
  Company company;
  User(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.address,
      required this.phone,
      required this.website,
      required this.company});

  factory User.fromJson(Map<String, dynamic> inputData) {
    return User(
        id: inputData['id'],
        name: inputData['name'],
        username: inputData['username'],
        email: inputData['email'],
        address: Address.fromJson(inputData['address']),
        phone: inputData['phone'],
        website: inputData['website'],
        company: Company.fromJson(inputData['company']));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'username': username,
        'email': email,
        'address': address.toJson(),
        'phone': phone,
        'website': website,
        'company': company.toJson(),
      };
}
