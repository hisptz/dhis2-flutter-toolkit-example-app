enum Status { initialized, syncing, complete }

class SyncStatus {
  String label;
  int synced = 0;
  int total = 0;

  Status status;

  SyncStatus(
      {required this.synced,
      required this.total,
      required this.status,
      required this.label});

  SyncStatus increment() {
    synced = synced + 1;
    return this;
  }

  SyncStatus complete() {
    status = Status.complete;
    return this;
  }
}
