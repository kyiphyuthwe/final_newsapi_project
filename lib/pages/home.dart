import 'package:carousel_slider/carousel_slider.dart';
import 'package:finalnewsapiproject/constants/build_widget.dart';
import 'package:finalnewsapiproject/models/everything_model.dart';
import 'package:finalnewsapiproject/network/resp_obj.dart';
import 'package:finalnewsapiproject/pages/category_page.dart';
import 'package:finalnewsapiproject/providers/headline_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int activeIndex = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   // Replace 'categoryName' with an actual category or pass it dynamically
  //   Future.microtask(() => Provider.of<HeadlineProvider>(context, listen: false)
  //       .getApiData("business"));
  // }
  late TabController tabController;
  final categoryName = ["business", "technology", "entertainment"];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    context.read<HeadlineProvider>().getApiData(categoryName[activeIndex]);

    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        // Fetch data based on selected category
        context
            .read<HeadlineProvider>()
            .getApiData(categoryName[tabController.index]);
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose(); // Dispose of TabController to avoid memory leaks
    super.dispose();
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HeadlineProvider>(builder: (context, apiProvider, child) {
        final response = apiProvider.respObj;

        if (response.apiState == ApiState.initial) {
          return const Center(child: CircularProgressIndicator());
        } else if (response.apiState == ApiState.success) {
          if (response.data != null) {
            List<EverythingModel> articles = response.data;
            return SafeArea(
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 5),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54, width: 1),
                      borderRadius: BorderRadius.circular(20)),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                              hintText: "Search News",
                              border: InputBorder.none),
                        ),
                      ),
                      const Icon(Icons.search),
                    ],
                  ),
                  // child: const SearchPage(),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Good Morning",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10, bottom: 20),
                      child: Text(
                        "Explore the world by one Click",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                CarouselSlider.builder(
                  itemCount: 5,
                  itemBuilder: (context, index, realindex) {
                    String? res =
                        articles[index].urlToImage ?? 'images/general.jpg';
                    String? res1 = articles[index].author ?? 'Unknown Author';
                    return BuildWidget(
                      image: res,
                      index: index,
                      name: res1,
                    );
                  },
                  options: CarouselOptions(
                      height: 250,
                      autoPlay: true,
                      // viewportFraction: 1,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      }),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(child: buildIndicator()),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: TabBar(
                    controller: tabController,
                    indicatorColor: Colors.transparent,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey.withOpacity(0.5),
                    isScrollable: true,
                    tabs: const <Widget>[
                      Tab(
                        child: Text(
                          "Business",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Tech",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Entertainment",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    indicator: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: TabBarView(
                      controller: tabController,
                      children: <Widget>[CategoryPage()],
                    ),
                  ),
                )
              ]),
            );
          } else {
            return const Text("Error");
          }
        }
        return const Text("Default");
      }),
    );
  }

//buildindicatorwidget
  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 5,
        effect: const ExpandingDotsEffect(
            dotWidth: 15, dotHeight: 15, activeDotColor: Colors.blue),
      );
}

//categorytileclass
class CategoryTile extends StatelessWidget {
  final image, categoryName;
  const CategoryTile({super.key, this.categoryName, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              image,
              width: 200,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: 120,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black26,
            ),
            child: Center(
              child: Text(
                categoryName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
