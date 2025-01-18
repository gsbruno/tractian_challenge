import 'dart:isolate';

import 'package:tractian_challenge/feature/asset/domain/entities/node.dart';
import 'package:tractian_challenge/feature/asset/presentation/state_managment/stores/threading/messaging/isolate_result.dart';
import 'package:tractian_challenge/feature/asset/presentation/state_managment/stores/threading/messaging/isolate_work.dart';
import 'package:tractian_challenge/feature/asset/presentation/state_managment/stores/threading/worker.dart';

class LoadWorker {
  final String companyId;

  late final Isolate isolate;

  final ReceivePort workerOutputPort = ReceivePort();

  late final SendPort workerInputPort;

  final void Function(bool, bool, String, List<Node>, Map<String, bool>)
      onFilterNodesResult;

  LoadWorker({
    required this.companyId,
    required this.onFilterNodesResult,
  }) {
    _setup();
  }

  void _setup() async {
    // Create the isolate to run the worker. Which will handle data loaing and filtering.
    isolate = await Isolate.spawn<SendPort>(
      _run,
      workerOutputPort.sendPort,
    );

    // Listen to worker messages. This can be either a SendPortMessage or a FilterNodesResult.
    workerOutputPort.listen((message) async {
      if (message is IsolateResult) {
        message.execute(this);
      }
    });
  }

  static void _run(SendPort mainThreadInputPort) {
    final worker = Worker();

    final ReceivePort mainThreadOutputPort = ReceivePort();

    mainThreadInputPort
        .send(SendPortMessage(sendPort: mainThreadOutputPort.sendPort));

    mainThreadOutputPort.listen((message) async {
      if (message is IsolateWork) {
        message.execute(worker, mainThreadInputPort);
        if (message is DisposeWorker) {
          mainThreadOutputPort.close();
        }
      }
    });
  }

  void loadAllNodes(String companyId) {
    workerInputPort.send(LoadAllNodes(companyId: companyId));
  }

  void filterNodes(
    bool isEnergyFilterActive,
    bool isStatusFilterActive,
    String searchText,
  ) {
    workerInputPort.send(FilterNodes(
        isEnergyFilterActive: isEnergyFilterActive,
        isStatusFilterActive: isStatusFilterActive,
        searchText: searchText));
  }

  void dispose() {
    // Send a message to the worker to dispose of it.
    workerInputPort.send(DisposeWorker());

    // Close the communication port with the worker.
    workerOutputPort.close();

    // Kill the isolate.
    isolate.kill();
  }
}
