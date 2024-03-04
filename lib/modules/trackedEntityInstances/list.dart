import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntityAttributeValue.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntityAttributeValue.dart';
import 'package:dhis2_flutter_toolkit/state/client.dart';
import 'package:dhis2_flutter_toolkit/state/db.dart';
import 'package:dhis2_flutter_toolkit/utils/debounce.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class TeiList extends StatefulWidget {
  const TeiList({super.key});

  @override
  State<TeiList> createState() => _TeiListState();
}

final debouncer = Debouncer(milliseconds: 1000);

class _TeiListState extends State<TeiList> {
  TextEditingController searchController = TextEditingController();
  late D2TrackedEntityRepository repository;
  late ObjectBox db;
  final PagingController<int, D2TrackedEntity> _pagingController =
      PagingController(firstPageKey: 0);

  fetchPage(int page) async {
    String keyword = searchController.text;

    if (keyword.isNotEmpty) {
      repository.byIdentifiableToken(keyword);
    } else {
      repository.clearQuery();
    }
    QueryBuilder<D2TrackedEntity> queryBuilder = repository.queryBuilder;
    Query<D2TrackedEntity> query = queryBuilder.build();
    query
      ..limit = 50
      ..offset = page;
    List<D2TrackedEntity> entities = await query.findAsync();
    final isLastPage = entities.length < 100;
    if (isLastPage) {
      _pagingController.appendLastPage(entities);
    } else {
      final nextPageKey = page + 1;
      _pagingController.appendPage(entities, nextPageKey);
    }
  }

  @override
  void initState() {
    setState(() {
      db = Provider.of<DBProvider>(context, listen: false).db;
      repository = D2TrackedEntityRepository(db);
    });

    _pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });

    searchController.addListener(() {
      debouncer.run(() => _pagingController.refresh());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final client =
        Provider.of<D2HttpClientProvider>(context, listen: false).client;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Tracked Entity Instances",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            IconButton(
                onPressed: () async {
                  final response =
                      await D2TrackedEntityRepository(db).syncMany(client);
                },
                icon: const Icon(
                  Icons.sync,
                  color: Colors.white,
                )),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.url,
                controller: searchController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    isDense: true,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                    ),
                    label: const Text("Search")),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: PagedListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (
                      context,
                      item,
                    ) =>
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: Divider(),
                        ),
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<D2TrackedEntity>(
                        itemBuilder: (context, item, index) {
                      List<D2TrackedEntityAttributeValue> attributeValues =
                          D2TrackedEntityAttributeValueRepository(db)
                              .byTrackedEntity(item.id)
                              .find();

                      List<D2Enrollment> enrollments =
                          D2EnrollmentRepository(db)
                              .byTrackedEntity(item.id)
                              .find();

                      final attribute = attributeValues.where((value) =>
                          value.trackedEntityAttribute.target?.name ==
                              "First name" ||
                          value.trackedEntityAttribute.target?.name ==
                              "Last name");
                      String fullName = attribute
                          .map((value) => value.value.toString())
                          .join(" ");

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                          onTap: () {
                            context.push("/tei/${item.id}");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          fullName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(enrollments.isNotEmpty
                                            ? "Has Enrollments"
                                            : "No Enrollments")
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuButton<String>(
                                onSelected: (String value) async {
                                  switch (value) {
                                    case "TrackedEntity":
                                      final response =
                                          await D2TrackedEntityRepository(db)
                                              .syncOne(client, item);
                                      print(response);
                                      break;
                                    default:
                                  }
                                  print(value);
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'TrackedEntity',
                                    child: Text('Tracked Entity'),
                                  ),
                                ],
                                icon: const Icon(
                                  Icons.sync,
                                  color: Colors.blueAccent,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    })),
              ),
            )
          ],
        ),
      ),
    );
  }
}
