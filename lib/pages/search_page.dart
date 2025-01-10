import 'package:cached_network_image/cached_network_image.dart';
import 'package:finalnewsapiproject/models/everything_model.dart';
import 'package:finalnewsapiproject/network/resp_obj.dart';
import 'package:finalnewsapiproject/pages/details_page.dart';
import 'package:finalnewsapiproject/providers/everything_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onSubmitted: (value) {
                  context.read<EverythingProvider>().getApiData();
                },
                decoration: const InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<EverythingProvider>(
                builder: (context, apiProvider, child) {
                  final response = apiProvider.respObj;

                  if (response.apiState == ApiState.initial ||
                      response.apiState == ApiState.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (response.apiState == ApiState.success) {
                    if (response.data != null) {
                      List<EverythingModel> articles = response.data;
                      return ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          final article = articles[index];
                          return ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DetailsPage(apiModel: article),
                                ),
                              );
                            },
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CachedNetworkImage(
                                  imageUrl: article.urlToImage.toString(),
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) =>
                                      Container(),
                                ),
                              ),
                            ),
                            title: Text(
                              article.title.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              article.author.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: const Icon(Icons.more_horiz),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text("Empty List"),
                      );
                    }
                  } else {
                    return Center(
                      child: Text(response.data.toString()),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
