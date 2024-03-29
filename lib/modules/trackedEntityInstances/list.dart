import 'package:dhis2_flutter_toolkit/dhis2_flutter_toolkit.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../state/client.dart';
import '../../state/db.dart';
import '../../utils/debounce.dart';

class TeiList extends StatefulWidget {
  final String? programId;

  const TeiList({super.key, this.programId});

  @override
  State<TeiList> createState() => _TeiListState();
}

final debouncer = Debouncer(milliseconds: 1000);

class _TeiListState extends State<TeiList> {
  TextEditingController searchController = TextEditingController();
  late D2TrackedEntityRepository repository;
  late D2ObjectBox db;
  final PagingController<int, D2TrackedEntity> _pagingController =
      PagingController(firstPageKey: 0);

  bool uploadStarted = false;

  fetchPage(int page) async {
    repository.initializeQuery();
    Query<D2TrackedEntity> query = repository.query;
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
      if (widget.programId != null) {
        D2Program? program =
            D2ProgramRepository(db).getById(int.parse(widget.programId!));
        if (program != null) {
          repository.setProgram(program);
        }
      }
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

    return StreamBuilder<D2SyncStatus>(
      stream: repository.controller.stream,
      builder: (context, data) {
        D2SyncStatus? status = data.data;
        var error = data.error;
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Tracked Entity Instances",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () async {
                      uploadStarted = true;
                      await repository.setupUpload(client).upload();
                      error != null ? null : uploadStarted = false;
                    },
                    icon: const Icon(
                      Icons.upload_file_outlined,
                      color: Colors.white,
                    )),
              ],
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: uploadStarted
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Intl.message("Upload In Progress",
                            name: "_SyncPageState_build", args: [context]),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24.0),
                      ),
                      status != null
                          ? Text(
                              "Syncing ${status.label} ${status.synced}/${status.total}")
                          : const Text("Error"),
                      error != null ? Text(error.toString()) : const Text(""),
                    ],
                  ),
                )
              : Padding(
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
                              builderDelegate:
                                  PagedChildBuilderDelegate<D2TrackedEntity>(
                                      itemBuilder: (context, item, index) {
                                List<D2TrackedEntityAttributeValue>?
                                    attributeValues =
                                    D2TrackedEntityAttributeValueRepository(db)
                                            .byTrackedEntity(item.id)
                                            .find() ??
                                        [];

                                List<D2Enrollment>? enrollments =
                                    D2EnrollmentRepository(db)
                                            .byTrackedEntity(item.id)
                                            .find() ??
                                        [];

                                final attribute = attributeValues.where(
                                    (value) =>
                                        value.trackedEntityAttribute.target
                                                ?.name ==
                                            "First name" ||
                                        value.trackedEntityAttribute.target
                                                ?.name ==
                                            "Last name");
                                String fullName = attribute
                                    .map((value) => value.value.toString())
                                    .join(" ");

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: InkWell(
                                    onTap: () {
                                      context.push("/tei/${item.id}");
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    fullName,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                                uploadStarted = true;
                                                await repository
                                                    .setupUpload(client)
                                                    .uploadOne(item);
                                                error != null
                                                    ? null
                                                    : uploadStarted = false;

                                                break;
                                              default:
                                            }
                                          },
                                          itemBuilder: (BuildContext context) =>
                                              <PopupMenuEntry<String>>[
                                            const PopupMenuItem<String>(
                                              value: 'TrackedEntity',
                                              child: Text('Tracked Entity'),
                                            ),
                                          ],
                                          icon: const Icon(
                                            Icons.upload_rounded,
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
      },
    );
  }
}
