import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:archive/archive_io.dart';
import 'package:cp_awesome_flutter_cli/command/base_command/icommand.dart';
import 'package:cp_awesome_flutter_cli/command/commands/change_bundle_id.dart';
import 'package:cp_awesome_flutter_cli/command/commands/change_name.dart';
import 'package:cp_awesome_flutter_cli/constants/const.dart';

class ProjectBuilder extends ICommand {
  @override
  String get command => 'create project';

  @override
  String get errorMessage => '';

  @override
  Future<void> execute() async {
    stdout.write('Please enter the project name:');
    String appName = stdin.readLineSync()!;
    stdout.write('Please enter the bundle id:');
    String bundleId = stdin.readLineSync()!;
    print('downloading project...\n');
    http.Client client = http.Client();
    var req = await client.get(Uri.parse(projectUrl));
    print('unzipping...\n');
    final archive = ZipDecoder().decodeBytes(req.bodyBytes);
    print('please wait...\n');
    extractArchiveToDisk(archive, Directory.current.path);
    // String newPath = replacePathPrefix(Directory.current.path,appName);
    // renameDirectory(Directory.current.path,newPath);
    String path;
    if (Platform.isMacOS || Platform.isLinux) {
      path = '$baseProjectName/';
    } else {
      path = '.\\$baseProjectName';
    }
    await ChangeName(appName, path).execute();
    await ChangeBundleId(bundleId, path).execute();
    await Directory(baseProjectName).rename(appName);
  }
}


// String replacePathPrefix(String originalPath, String replacement) {
//   List<String> parts = originalPath.split('/');
//   if (parts.isNotEmpty) {
//     parts[0] = replacement;
//     return parts.join('/');
//   }
//   return originalPath;
// }



// void renameDirectory(String currentPath, String newPath) {
//   var currentDirectory = Directory(currentPath);
//   var newDirectory = Directory(newPath);

//   if (currentDirectory.existsSync()) {
//     try {
//       currentDirectory.renameSync(newDirectory.path);
//       print('Directory name changed successfully.');
//     } catch (e) {
//       print('An error occurred while renaming the directory: $e');
//     }
//   } else {
//     print('The current directory does not exist.');
//   }
// }