/// countries : [{"code":"AD","name":"Andorra","phone":"376","currency":"EUR","languages":[{"code":"ca","name":"Catalan","native":"Català","rtl":false}],"emoji":"🇦🇩","emojiU":"U+1F1E6 U+1F1E9","native":"Andorra","continent":{"code":"EU","name":"Europe"}},null]

class CountriesModel {
  CountriesModel({
      List<Countries>? countries,}){
    _countries = countries;
}

  CountriesModel.fromJson(dynamic json) {
    if (json['countries'] != null) {
      _countries = [];
      json['countries'].forEach((v) {
        _countries?.add(Countries.fromJson(v));
      });
    }
  }
  List<Countries>? _countries;
CountriesModel copyWith({  List<Countries>? countries,
}) => CountriesModel(  countries: countries ?? _countries,
);
  List<Countries>? get countries => _countries;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_countries != null) {
      map['countries'] = _countries?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// code : "AD"
/// name : "Andorra"
/// phone : "376"
/// currency : "EUR"
/// languages : [{"code":"ca","name":"Catalan","native":"Català","rtl":false}]
/// emoji : "🇦🇩"
/// emojiU : "U+1F1E6 U+1F1E9"
/// native : "Andorra"
/// continent : {"code":"EU","name":"Europe"}

class Countries {
  Countries({
      String? code, 
      String? name, 
      String? phone, 
      String? currency, 
      List<Languages>? languages, 
      String? emoji, 
      String? emojiU, 
      String? native, 
      Continent? continent,}){
    _code = code;
    _name = name;
    _phone = phone;
    _currency = currency;
    _languages = languages;
    _emoji = emoji;
    _emojiU = emojiU;
    _native = native;
    _continent = continent;
}

  Countries.fromJson(dynamic json) {
    _code = json['code'];
    _name = json['name'];
    _phone = json['phone'];
    _currency = json['currency'];
    if (json['languages'] != null) {
      _languages = [];
      json['languages'].forEach((v) {
        _languages?.add(Languages.fromJson(v));
      });
    }
    _emoji = json['emoji'];
    _emojiU = json['emojiU'];
    _native = json['native'];
    _continent = json['continent'] != null ? Continent.fromJson(json['continent']) : null;
  }
  String? _code;
  String? _name;
  String? _phone;
  String? _currency;
  List<Languages>? _languages;
  String? _emoji;
  String? _emojiU;
  String? _native;
  Continent? _continent;
Countries copyWith({  String? code,
  String? name,
  String? phone,
  String? currency,
  List<Languages>? languages,
  String? emoji,
  String? emojiU,
  String? native,
  Continent? continent,
}) => Countries(  code: code ?? _code,
  name: name ?? _name,
  phone: phone ?? _phone,
  currency: currency ?? _currency,
  languages: languages ?? _languages,
  emoji: emoji ?? _emoji,
  emojiU: emojiU ?? _emojiU,
  native: native ?? _native,
  continent: continent ?? _continent,
);
  String? get code => _code;
  String? get name => _name;
  String? get phone => _phone;
  String? get currency => _currency;
  List<Languages>? get languages => _languages;
  String? get emoji => _emoji;
  String? get emojiU => _emojiU;
  String? get native => _native;
  Continent? get continent => _continent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['name'] = _name;
    map['phone'] = _phone;
    map['currency'] = _currency;
    if (_languages != null) {
      map['languages'] = _languages?.map((v) => v.toJson()).toList();
    }
    map['emoji'] = _emoji;
    map['emojiU'] = _emojiU;
    map['native'] = _native;
    if (_continent != null) {
      map['continent'] = _continent?.toJson();
    }
    return map;
  }

}

/// code : "EU"
/// name : "Europe"

class Continent {
  Continent({
      String? code, 
      String? name,}){
    _code = code;
    _name = name;
}

  Continent.fromJson(dynamic json) {
    _code = json['code'];
    _name = json['name'];
  }
  String? _code;
  String? _name;
Continent copyWith({  String? code,
  String? name,
}) => Continent(  code: code ?? _code,
  name: name ?? _name,
);
  String? get code => _code;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['name'] = _name;
    return map;
  }

}

/// code : "ca"
/// name : "Catalan"
/// native : "Català"
/// rtl : false

class Languages {
  Languages({
      String? code, 
      String? name, 
      String? native, 
      bool? rtl,}){
    _code = code;
    _name = name;
    _native = native;
    _rtl = rtl;
}

  Languages.fromJson(dynamic json) {
    _code = json['code'];
    _name = json['name'];
    _native = json['native'];
    _rtl = json['rtl'];
  }
  String? _code;
  String? _name;
  String? _native;
  bool? _rtl;
Languages copyWith({  String? code,
  String? name,
  String? native,
  bool? rtl,
}) => Languages(  code: code ?? _code,
  name: name ?? _name,
  native: native ?? _native,
  rtl: rtl ?? _rtl,
);
  String? get code => _code;
  String? get name => _name;
  String? get native => _native;
  bool? get rtl => _rtl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['name'] = _name;
    map['native'] = _native;
    map['rtl'] = _rtl;
    return map;
  }

}