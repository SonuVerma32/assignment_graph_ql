import 'package:assignment_graph_ql/controller/countries_bloc.dart';
import 'package:assignment_graph_ql/model/countries_model.dart';
import 'package:assignment_graph_ql/view/country_by_code.dart';
import 'package:flutter/material.dart';

class CountriesHome extends StatefulWidget {
  const CountriesHome({Key? key}) : super(key: key);

  @override
  State<CountriesHome> createState() => _CountriesHomeState();
}

class _CountriesHomeState extends State<CountriesHome> {
  final CountriesBloc _countriesBloc = CountriesBloc();

  @override
  void initState(){
    super.initState();
    _countriesBloc.getCountries();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 45,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Colors.white,
                ),
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                onChanged: (v){
                  _countriesBloc.searchByCountry(v.trim());
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Search by language',
                  enabled: true,
                  border: UnderlineInputBorder(
                  ),
                  suffixIcon: Icon(Icons.search,color: Colors.white),
                ),
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.orangeAccent.withOpacity(0.7),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh,color: Colors.white),
              onPressed: (){
                _countriesBloc.getCountries();
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('Search'),
          icon: const Icon(Icons.search),
          backgroundColor: Colors.orangeAccent.shade200,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> const CountryByCode()));
          },
        ),
        body: StreamBuilder<List<Countries>>(
          stream: _countriesBloc.countriesStream,
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
                return Card(
                  child: ExpansionTile(
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
                          const Text('Code: ',style: TextStyle(fontWeight: FontWeight.bold,),),
                          Text(snapshot.data![index].code.toString(),style: const TextStyle(fontWeight: FontWeight.bold,),)
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
                      ),
                      const Divider(),
                    ],
                  ),
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
