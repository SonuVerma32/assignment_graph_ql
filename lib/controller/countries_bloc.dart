import 'dart:async';
import 'dart:convert';
import 'package:assignment_graph_ql/model/countries_model.dart';
import 'package:assignment_graph_ql/network/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CountriesBloc{
  final ApiManager _apiManager = ApiManager();
  final _countriesController = StreamController<List<Countries>>();
  final _countriesByCodeController = StreamController<List<Countries>>();
  List<Countries>? searchList = [];
  List<Countries>? countriesData  = [];
  Stream<List<Countries>>? get countriesStream =>
      _countriesController.stream;

  StreamSink<List<Countries>> get countriesSink =>
      _countriesController.sink;

  Stream<List<Countries>>? get countriesByCodeStream =>
      _countriesByCodeController.stream;

  StreamSink<List<Countries>> get countriesByCodeSink =>
      _countriesByCodeController.sink;


  getCountries()async{
    var apiData = await _apiManager.getCountries().onError((error, stackTrace){
      showToast(error.toString());
      getCountries();
    });
    var decode = jsonDecode(apiData);
    countriesData = CountriesModel.fromJson(decode).countries;
    countriesSink.add(countriesData!);
  }

  searchByCountry(String keyword){
    searchList!.clear();
    for (var v in countriesData!) {
      for (var l in v.languages!) {
        if (l.name!.toLowerCase().contains(keyword.toLowerCase())) {
          searchList!.add(v);
        }
      }
    }
    if(keyword == '') {
      countriesSink.add(countriesData!);
    }else{
      countriesSink.add(searchList!);
    }
  }

  searchByCode(String keyword)async{
    searchList!.clear();
    var apiData = await _apiManager.getCountries().onError((error, stackTrace){
      showToast(error.toString());
      searchByCode(keyword);
    });
    var decode = jsonDecode(apiData);
    countriesData = CountriesModel.fromJson(decode).countries;
    for (var v in countriesData!) {
        if (v.code!.toLowerCase().contains(keyword.toLowerCase())) {
          searchList!.add(v);
        }
    }
    if(searchList!.isNotEmpty){
      if(keyword == '') {
        countriesByCodeSink.add(countriesData!);
      }else{
        countriesByCodeSink.add(searchList!);
      }
    }
    else{
      showToast('No related code found, try different country code.');
    }


  }

  void dispose(){
    _countriesController.close();
    _countriesByCodeController.close();
  }
  showToast(String msg){
    return Fluttertoast.showToast(
        msg: msg,
        fontSize: 16,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.brown.shade300
    );
  }
}