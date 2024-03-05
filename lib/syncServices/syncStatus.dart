enum Status { initialized, syncing, complete }

class DownloadStatus {
  String label;
  int synced = 0;
  int total = 0;

  Status status;

  DownloadStatus(
      {required this.synced,
      required this.total,
      required this.status,
      required this.label});

  DownloadStatus increment() {
    synced = synced + 1;
    return this;
  }

  DownloadStatus complete() {
    status = Status.complete;
    return this;
  }
}
