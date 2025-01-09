import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:finalnewsapiproject/constants/build_widget.dart';
import 'package:finalnewsapiproject/models/everything_model.dart';
import 'package:finalnewsapiproject/network/resp_obj.dart';
import 'package:finalnewsapiproject/providers/everything_provider.dart';
import 'package:finalnewsapiproject/providers/headline_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EverythingPage extends StatefulWidget {
  const EverythingPage({super.key});

  @override
  State<EverythingPage> createState() => _EverythingPageState();
}

class _EverythingPageState extends State<EverythingPage> {
  // final categoryName = ["business", "technology", "entertainment"];
  // List<HeadlineModel> categories = [];
  int activeIndex = 0;

  final category = HeadlineProvider().respObj;

  @override
  void initState() {
    super.initState();
    context.read<EverythingProvider>().getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<EverythingProvider>(
          builder: (context, apiProvider, child) {
            final response = apiProvider.respObj;

            if (response.apiState == ApiState.initial) {
              return const Center(child: CircularProgressIndicator());
            } else if (response.apiState == ApiState.success) {
              if (response.data != null) {
                List<EverythingModel> articles = response.data;
                return Column(children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                        top: 20, left: 15, right: 15, bottom: 10),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Walk with Trend",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 0, left: 15, right: 15, bottom: 5),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          child: Text(
                            "Don't stay behind! Read the trend",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(20),
                      height: 300,
                      child: CarouselSlider.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index, realindex) {
                          String? res = articles[index].urlToImage ??
                              'images/general.jpg';
                          String? res1 =
                              articles[index].author ?? 'Unknown Author';
                          return BuildWidget(
                              image: res, index: index, name: res1);
                        },
                        options: CarouselOptions(
                            height: 250,
                            autoPlay: true,
                            // viewportFraction: 1,
                            // enlargeCenterPage: true,
                            // enlargeStrategy: CenterPageEnlargeStrategy.height,
                            onPageChanged: (index, reason) {
                              setState(() {
                                activeIndex = index;
                              });

                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 15, right: 15, bottom: 10),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(
                                        "Top reads of the day",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              Expanded(
                                child: ListView.builder(
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
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                article.urlToImage.toString(),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        article.title.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        article.author.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: const Icon(Icons.more_horiz),
                                    );
                                  },
                                ),
                              );
                            }),
                      )),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 10, left: 15, right: 15, bottom: 10),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Top Reads of the day",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => DetailsPage(apiModel: article),
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
                            ),
                          ),
                        ),
                        title: Text(
                          article.title.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          article.author.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: const Icon(Icons.more_horiz),
                      );
                    },
                  ))
                ]);
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
    );
  }
}

class DetailsPage extends StatelessWidget {
  final EverythingModel apiModel;
  const DetailsPage({super.key, required this.apiModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            apiModel.title.toString().toUpperCase(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            apiModel.content.toString(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 200,
            child: CachedNetworkImage(
              imageUrl: apiModel.urlToImage.toString(),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}