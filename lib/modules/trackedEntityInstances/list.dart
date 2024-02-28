import 'package:dhis2_flutter_toolkit/components/DetailsRow.dart';
import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntityAttributeValue.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntityAttributeValue.dart';
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
  late TrackedEntityRepository repository;
  late ObjectBox db;
  final PagingController<int, TrackedEntity> _pagingController =
      PagingController(firstPageKey: 0);

  fetchPage(int page) async {
    String keyword = searchController.text;

    if (keyword.isNotEmpty) {
      repository.byIdentifiableToken(keyword);
    } else {
      repository.clearQuery();
    }
    QueryBuilder<TrackedEntity> queryBuilder = repository.queryBuilder;
    Query<TrackedEntity> query = queryBuilder.build();
    query
      ..limit = 50
      ..offset = page;
    List<TrackedEntity> entities = await query.findAsync();
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
      repository = TrackedEntityRepository(db);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tracked Entity Instances",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                    builderDelegate: PagedChildBuilderDelegate<TrackedEntity>(
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DetailsRow(label: "Full name", value: fullName),
                              DetailsRow(
                                label: "Attributes",
                                value: attributeValues
                                    .map((value) {
                                      return "${value.trackedEntityAttribute.target!.name}: ${value.value}";
                                    })
                                    .toList()
                                    .join(", "),
                              ),
                              DetailsRow(
                                  label: "Enrollments",
                                  value: enrollments.length.toString()),
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
