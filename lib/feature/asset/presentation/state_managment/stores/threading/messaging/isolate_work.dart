import 'dart:isolate';

import 'package:tractian_challenge/feature/asset/presentation/state_managment/stores/threading/worker.dart';

/// Common class for all messages sent by the main thread to the worker thread.
/// It is used to send actions to the worker thread.
abstract class IsolateWork {
  void execute(Worker worker, SendPort mainThreadInputPort);
}

/// Message that corresponds to an action that will load all nodes.
class LoadAllNodes extends IsolateWork {
  final String companyId;

  LoadAllNodes({required this.companyId});

  @override
  void execute(Worker worker, SendPort mainThreadInputPort) {
    worker.loadAllNodes(companyId).then((value) {
      worker.filterNodes(false, false, '', mainThreadInputPort);
    });
  }
}

/// Message that corresponds to an action that will filter the nodes.
class FilterNodes extends IsolateWork {
  final bool isEnergyFilterActive;
  final bool isStatusFilterActive;
  final String searchText;

  FilterNodes(
      {required this.isEnergyFilterActive,
      required this.isStatusFilterActive,
      required this.searchText});

  @override
  void execute(Worker worker, SendPort mainThreadInputPort) {
    worker.filterNodes(isEnergyFilterActive, isStatusFilterActive, searchText,
        mainThreadInputPort);
  }
}

class DisposeWorker extends IsolateWork {
  @override
  void execute(Worker worker, SendPort mainThreadInputPort) {
    // Dispose of the worker.
    worker.dispose();
  }
}
