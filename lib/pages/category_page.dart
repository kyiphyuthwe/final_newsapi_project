import 'package:cached_network_image/cached_network_image.dart';
import 'package:finalnewsapiproject/models/headline_model.dart';
import 'package:finalnewsapiproject/network/resp_obj.dart';
import 'package:finalnewsapiproject/pages/details_page_headline.dart';
import 'package:finalnewsapiproject/providers/headline_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  var currentIndex = 0;

  var categoryName = ["business", "technology", "entertainment"];

  @override
  void initState() {
    super.initState();
    context.read<HeadlineProvider>().getApiData(categoryName[currentIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<HeadlineProvider>(
          builder: (context, apiProvider, child) {
            final response = apiProvider.respObj;

            if (response.apiState == ApiState.initial) {
              return const Center(child: CircularProgressIndicator());
            } else if (response.apiState == ApiState.success) {
              if (response.data != null) {
                List<HeadlineModel> articles = response.data;
                return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                DetailsPageHeadline(apiModel: article),
                          ),
                        );
                      },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CachedNetworkImage(
                            // String? name;
                            imageUrl: article.urlToImage ?? "url", //''
                            errorWidget: (context, url, error) =>
                                const CircularProgressIndicator(),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      title: Text(
                        article.title ?? "Title",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        article.author ?? "Author", //  ''
                        style: const TextStyle(fontWeight: FontWeight.bold),
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
    );
  }
}

// class DetailsPageHeadline extends StatelessWidget {
//   final HeadlineModel apiModel;
//   const DetailsPageHeadline({super.key, required this.apiModel});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           Text(
//             apiModel.title.toString().toUpperCase(),
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             apiModel.content.toString(),
//             style: const TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.normal,
//             ),
//           ),
//           SizedBox(
//             width: double.infinity,
//             height: 200,
//             child: CachedNetworkImage(
//               imageUrl: apiModel.urlToImage.toString(),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HealthPage extends StatefulWidget {
//   const HealthPage({super.key});

//   @override
//   State<HealthPage> createState() => _HealthPageState();
// }

// class _HealthPageState extends State<HealthPage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<HeadlineProvider>().getApiData("health");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SafeArea(
//         child: Consumer<HeadlineProvider>(
//           builder: (context, apiProvider, child) {
//             final response = apiProvider.respObj;

//             if (response.apiState == ApiState.initial) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (response.apiState == ApiState.success) {
//               if (response.data != null) {
//                 List<HeadlineModel> articles = response.data;
//                 return ListView.builder(
//                   itemCount: articles.length,
//                   itemBuilder: (context, index) {
//                     final article = articles[index];
//                     return ListTile(
//                       onTap: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (_) => DetailsPage(apiModel: article),
//                           ),
//                         );
//                       },
//                       leading: ClipRRect(
//                         borderRadius: BorderRadius.circular(100),
//                         child: SizedBox(
//                           width: 50,
//                           height: 50,
//                           child: CachedNetworkImage(
//                             imageUrl: article.urlToImage.toString(),
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                       title: Text(
//                         article.title.toString(),
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Text(
//                         article.author.toString(),
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       trailing: const Icon(Icons.more_horiz),
//                     );
//                   },
//                 );
//               } else {
//                 return const Center(
//                   child: Text("Empty List"),
//                 );
//               }
//             } else {
//               return Center(
//                 child: Text(response.data.toString()),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
