class PathsConst {
  final String screenName;
  late final String _viewClassName;
  PathsConst(this.screenName) {
    String name = screenName[0].toUpperCase() + screenName.substring(1);
    for (int i = 0; i < name.length; i++) {
      if (name[i] == '_' && i < name.length - 1) {
        name = name.substring(0, i) +
            name[i + 1].toUpperCase() +
            name.substring(i + 2);
      }
    }
    _viewClassName = name;
  }

  /// Paths
  String get controllerFilePath =>
      '$screenFolderName/$controllerFolderName/$controllerFileName';

  String get mainViewFilePath => '$screenFolderName/$mainViewFileName';

  String get viewFilePath => '$screenFolderName/$viewFolderName/$viewFileName';

  /// folder name
  String get screenFolderName => '${screenName}_screen';

  String get viewFolderName => 'view';

  String get controllerFolderName => 'controller';

  /// file Name
  String get controllerFileName => '${screenName}_controller.dart';

  String get mainViewFileName => '${screenName}_screen.dart';

  String get viewFileName => '$screenName.dart';

  /// class Name
  String get controllerClassName => '${_viewClassName}Controller';

  String get mainViewClassName => '${_viewClassName}Screen';

  /// Contents
  String get mainViewFileContent => """
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '$controllerFolderName/$controllerFileName';
import '$viewFolderName/$viewFileName';

class $mainViewClassName extends StatelessWidget {
  const $mainViewClassName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: $controllerClassName(),
      builder: (_) => const $_viewClassName(),
    );
  }
}""";

  String get controllerFileContent => """
import 'package:flutter_base_project/app/common/base_view/controller/base_controller.dart';

class $controllerClassName extends BaseControllerInterface {


  @override
  void onReady() async{
    onReadyGeneric((){

    });
  }

}""";


  String get viewFileContent => """
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../$controllerFolderName/$controllerFileName';
import 'package:flutter_base_project/app/common/base_view/base_view.dart';
  
class $_viewClassName extends GetView<$controllerClassName> {
  const $_viewClassName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

     return Scaffold(
      key: controller.scaffoldKey,


      //AppBar
      appBar: AppBar(),
      

      ///Body
      body: BaseView<$controllerClassName>(
        controller: controller,
        child: Container(),
      ),
    );
  }
}""";
}
