import 'package:cached_network_image/cached_network_image.dart';
import 'package:finalnewsapiproject/models/everything_model.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final EverythingModel apiModel;

  const DetailsPage({super.key, required this.apiModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Stack(children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.75,
                child: CachedNetworkImage(
                  imageUrl: apiModel.urlToImage.toString(),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 5,
                child: Text(
                  apiModel.title.toString().toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                  left: 10,
                  bottom: 30,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text("Trendy"),
                  )),
              Positioned(
                  left: 80,
                  bottom: 30,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(apiModel.source?.name ?? 'No Source Name'),
                  ))
            ]),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white10,
              ),
              height: 70,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        width: 50,
                        height: 50,
                        imageUrl: apiModel.urlToImage.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Author :",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Text(
                          apiModel.author.toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_outline,
                        color: Colors.pink,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.forward_outlined)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Description: ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            apiModel.description.toString(),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        const Text(
                          "Content : ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            apiModel.description.toString(),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
