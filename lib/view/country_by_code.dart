import 'package:flutter/material.dart';

import '../controller/countries_bloc.dart';
import '../model/countries_model.dart';

class CountryByCode extends StatefulWidget {
  const CountryByCode({Key? key}) : super(key: key);

  @override
  State<CountryByCode> createState() => _CountryByCodeState();
}

class _CountryByCodeState extends State<CountryByCode> {
  final CountriesBloc _countriesBloc = CountriesBloc();

  @override
  void initState(){
    super.initState();
    _countriesBloc.searchByCode('');
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (v){
                _countriesBloc.searchByCode(v);
              },
              decoration: const InputDecoration(
                border: UnderlineInputBorder(
                ),
                suffixIcon: Icon(Icons.search,color: Colors.white),
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.orangeAccent.withOpacity(0.7),
        ),
        body: StreamBuilder<List<Countries>>(
          stream: _countriesBloc.countriesByCodeStream,
          builder: (BuildContext context, snapshot){
            return snapshot.hasData
                ? ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, index){
                String languages = '';
                if (snapshot.data![index].languages!.length != 1) {
                  for (var element in snapshot.data![index].languages!) {
                    languages += "${element.name!}, ";
                  }
                } else {
                  snapshot.data![index].languages!.isNotEmpty
                      ? languages = languages = snapshot.data![index].languages![0].name!
                      : languages = '';
                }
                return ExpansionTile(
                  title: Text(snapshot.data![index].name.toString()),
                  leading: Text(snapshot.data![index].emoji.toString()),
                  subtitle: Text(snapshot.data![index].continent!.name.toString()),
                  // trailing: Text(snapshot.data![index].code.toString()),
                  children: [
                    Row(
                      children: [
                        const Text('Currency: ',style: TextStyle(fontWeight: FontWeight.bold,),),
                        Text(snapshot.data![index].currency.toString(),style: const TextStyle(fontWeight: FontWeight.bold,),)
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Text('Native: ',style: TextStyle(fontWeight: FontWeight.bold,),),
                        Text(snapshot.data![index].native.toString(),style: const TextStyle(fontWeight: FontWeight.bold,),)
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Text('Languages: ',style: TextStyle(fontWeight: FontWeight.bold,),),
                        Text(languages,style: const TextStyle(fontWeight: FontWeight.bold,),)
                      ],
                    )
                  ],
                );
              },
            )
                : const Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}
