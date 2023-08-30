import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_mobile/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

class PokemonFavorite extends StatefulWidget {
  final int id;
  const PokemonFavorite({super.key, required this.id});

  @override
  State<PokemonFavorite> createState() => _PokemonFavoriteState();
}

class _PokemonFavoriteState extends State<PokemonFavorite> {
  late Stream<DocumentSnapshot> _documentStream;

  @override
  void initState() {
    _documentStream = FirebaseFirestore.instance
        .collection('pokemons')
        .doc(widget.id.toString())
        .snapshots();
    super.initState();
  }

  _markFavoriteStatus(int id, bool value) {
    Provider.of<PokemonProvider>(context, listen: false)
        .updatePokemonFavoriteStatus(id, value);
  }

  Widget renderFavoriteIcon(bool state){
    if(state){
      return IconButton(
        onPressed: () => _markFavoriteStatus(widget.id, false),
        icon: const Icon(Icons.favorite));
    }else{
    return IconButton(
        onPressed: () => _markFavoriteStatus(widget.id, true),
        icon: const Icon(Icons.favorite_border));
  }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _documentStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }else{
          
        }
        var data = snapshot.data!; //Map<String, dynamic>

        bool flagFavorite = false;

        try{
          if(data["isFavorite"] == true){
            flagFavorite = true;
          }
        } on StateError{
          print('state error');
        }

        print('favorito $flagFavorite');

        return renderFavoriteIcon(flagFavorite);
      },
    );
    // return IconButton(
    //     onPressed: () => {
    //       _markFavoriteStatus(widget.id, true)
    //     },
    //     icon: const Icon(Icons.favorite_border));
  }
}