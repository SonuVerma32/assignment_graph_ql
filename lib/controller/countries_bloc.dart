import 'dart:async';
import 'dart:convert';
import 'package:assignment_graph_ql/model/countries_model.dart';
import 'package:assignment_graph_ql/network/api_manager.dart';
import 'package:flutter/material.dart';

class CountriesBloc{
  // object of apiManager class for api call
  final ApiManager _apiManager = ApiManager();
  late BuildContext context;
  final _countriesController = StreamController<List<Countries>>();
  final _countriesByCodeController = StreamController<List<Countries>>();

  // searchList is temporary storage list for searching operations
  List<Countries>? searchList = [];

  // countriesData list holds the data during the whole process of searching
  List<Countries>? countriesData  = [];

  Stream<List<Countries>>? get countriesStream =>
      _countriesController.stream;

  StreamSink<List<Countries>> get countriesSink =>
      _countriesController.sink;

  Stream<List<Countries>>? get countriesByCodeStream =>
      _countriesByCodeController.stream;

  StreamSink<List<Countries>> get countriesByCodeSink =>
      _countriesByCodeController.sink;

// Get List of Countries
  getCountries(BuildContext ctx)async{
    context = ctx;
    var apiData = await _apiManager.getCountries().onError((error, stackTrace){
      showSnackBar(error.toString());
      getCountries(context);
    });
    var decode = jsonDecode(apiData);
    countriesData = CountriesModel.fromJson(decode).countries;
    countriesData!.sort((a, b) => a.name!.compareTo(b.name!));
    countriesSink.add(countriesData!);
  }

// search in the countriesData list for search operation according to country name
  searchByCountry(BuildContext ctx, String keyword){
    context = ctx;
    searchList!.clear();
    for (var v in countriesData!) {
      for (var l in v.languages!) {
        if (l.name!.toUpperCase().contains(keyword.toUpperCase())) {
          searchList!.add(v);
        }
      }
    }
    if(searchList!.isNotEmpty){
      if(keyword == '') {
        countriesSink.add(countriesData!);
      }else{
        countriesSink.add(searchList!);
      }
    } else{
      showSnackBar('Country $keyword not found, try different language.');
    }
  }

  // search in the countriesData list for search operation according to country code
  searchByCode(BuildContext ctx,String keyword)async{
    context = ctx;
    searchList!.clear();
    var apiData = await _apiManager.getCountries().onError((error, stackTrace){
      showSnackBar(error.toString());
      searchByCode(context, keyword);
    });
    var decode = jsonDecode(apiData);
    countriesData = CountriesModel.fromJson(decode).countries;
    countriesData!.sort((a, b) => a.name!.compareTo(b.name!));
    for (var v in countriesData!) {
        if (v.code!.toUpperCase().contains(keyword.toUpperCase())) {
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
      showSnackBar('Code $keyword not found, try different code.');
    }


  }

  void dispose(){
    _countriesController.close();
    _countriesByCodeController.close();
  }


  showSnackBar(String msg){
    var snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: Colors.black,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(label: 'Okay', onPressed: (){}),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}