import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_task/bloc/project_item_bloc/project_item_event.dart';
import 'package:project_task/bloc/project_item_bloc/project_item_state.dart';
import 'package:project_task/service/project_item_service.dart';
import 'package:uuid/uuid.dart';

class ProjectItemBloc extends Bloc<ProjectItemEvent, ProjectItemState> {
  final ProjectItemService projectItemService;
  ProjectItemBloc(this.projectItemService) : super(ProjectItemState());

  @override
  Stream<ProjectItemState> mapEventToState(ProjectItemEvent event) async* {
    yield ProjectItemStateLoading();
    if (event is ProjectItemEventFetch) {
      List<dynamic> res = await projectItemService.getProjectItem(event.token);
      yield ProjectItemStateFetch(projects: res[0], items: res[1]);
    } else if (event is ProjectItemAddProject) {
      List<dynamic> res =
          await projectItemService.addProject(event.token, event.name);
      yield ProjectItemStateFetch(projects: res[0], items: res[1]);
    } else if (event is ProjectItemAddItem) {
      var tempId = Uuid().v4();
      var res = await projectItemService.addItem(
          event.token, event.content, event.projectId, tempId);
      if (res != null) {
        yield ProjectItemStateAddItemDone(res['temp_id_mapping'][tempId]);
      }
    }
  }
}
