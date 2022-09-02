import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var key = "AIzaSyCSQSnWCdRnVX0cK_OT8EFfWyP7FsKnkTE";
  var gifData;
  String? gifURL;
  List<String> gifs = [];
  final TextEditingController _controller = TextEditingController();

  Future<void> getGIF(String word) async {
    gifData = await http.get(Uri.parse(
        "https://tenor.googleapis.com/v2/search?q=$word&key=$key&client_key=my_test_app&limit=8"));
    final gifDataParsed = jsonDecode(gifData.body);
    gifs.clear();
    setState(() {
      for (int i = 0; i < 8; i++) {
        gifs.add(
            gifDataParsed["results"][i]["media_formats"]["mediumgif"]["url"]);
      }
    });
  }

  @override
  void initState() {
    getGIF("homelander");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<Card> listItems = [];
    // for (int i = 0; i < 8; i++) {
    //   listItems.add(Card(child: Image.network("${gifs[i]}")));
    // }

    return (gifs.isEmpty)
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            appBar: AppBar(title: const Text("GIF App"), centerTitle: true),
            body: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _controller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: "Search GIF.",
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        getGIF(_controller.text);
                      },
                      child: const Text("Search")),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView.separated(
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return GifCard(gifs[index]);
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: Colors.white,
                            thickness: 5,
                            height: 5,
                          );
                        },
                      )),
                ],
              ),
            ),
          );
  }
}

class GifCard extends StatelessWidget {
  final String gifUrl;

  const GifCard(this.gifUrl);

  @override
  Widget build(BuildContext context) {
    return Image(
      fit: BoxFit.cover,
      image: NetworkImage(gifUrl),
    );
  }
}
