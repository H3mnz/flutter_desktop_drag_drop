import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop_drag_drop/app/utils/image_utils.dart';
import 'package:flutter_desktop_drag_drop/app/widgets/drop_area_widget.dart';
import 'package:flutter_desktop_drag_drop/app/widgets/toolbar_widget.dart';
import 'package:window_manager/window_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WindowListener {
  //
  bool hovering = false;
  List<XFile> droppedFiles = [];
  //
  @override
  void onWindowFocus() {
    super.onWindowFocus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ToolbarWidget(
            title: 'Drag Drop Files',
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Drop your images',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white),
                  ),
                  Text(
                    'JPG, PNG, GIF files are allowed',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Row(
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: DropAreaWidget(
                            onFiles: (files) {
                              for (var file in files) {
                                if (!droppedFiles.any((element) => element.path == file.path)) {
                                  droppedFiles.add(file);
                                }
                              }

                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Droped Files', style: Theme.of(context).textTheme.titleLarge),
                                  if (droppedFiles.isNotEmpty)
                                    TextButton(
                                      onPressed: () {
                                        droppedFiles.clear();
                                        setState(() {});
                                      },
                                      child: const Text('Remove all'),
                                    )
                                ],
                              ),
                              const SizedBox(height: 8),
                              Expanded(
                                child: ListView.separated(
                                  itemCount: droppedFiles.length,
                                  separatorBuilder: (context, index) => const SizedBox(height: 4),
                                  itemBuilder: (context, index) => ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    onTap: () {},
                                    leading: Image.asset(
                                      ImageUtils.imgeByMimeType(droppedFiles[index].path),
                                      width: 30,
                                      height: 30,
                                    ),
                                    title: Text(droppedFiles[index].name),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
