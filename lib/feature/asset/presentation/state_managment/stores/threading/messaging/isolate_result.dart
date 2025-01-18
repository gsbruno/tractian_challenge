import 'dart:isolate';

import 'package:tractian_challenge/feature/asset/domain/entities/node.dart';
import 'package:tractian_challenge/feature/asset/presentation/state_managment/stores/threading/load_worker.dart';

/// Common class for all messages sent by the worker thread to the main thread.
abstract class IsolateResult {
  IsolateResult();

  void execute(LoadWorker loadWorker);
}

/// Message sent by the main thread to the worker thread to get the SendPort to communicate with the worker.
class SendPortMessage extends IsolateResult {
  final SendPort sendPort;

  SendPortMessage({required this.sendPort});

  @override
  void execute(LoadWorker loadWorker) {
    loadWorker.workerInputPort = sendPort;

    loadWorker.loadAllNodes(loadWorker.companyId);
  }
}

/// Message sent by the worker thread to the main thread when the filtering is done.
class FilterNodesResult extends IsolateResult {
  final bool isEnergyFilterActive;
  final bool isAlertFilterActive;
  final String searchText;
  final List<Node> nodes;
  final Map<String, bool> visibleNodes;

  FilterNodesResult({
    required this.isEnergyFilterActive,
    required this.isAlertFilterActive,
    required this.searchText,
    required this.nodes,
    required this.visibleNodes,
  });

  @override
  void execute(LoadWorker loadWorker) {
    loadWorker.onFilterNodesResult(
      isEnergyFilterActive,
      isAlertFilterActive,
      searchText,
      nodes,
      visibleNodes,
    );
  }
}
