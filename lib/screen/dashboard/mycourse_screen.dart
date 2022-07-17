import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:capstone_project_lms/api/sign_api.dart';
import 'package:capstone_project_lms/models/class_pagination_response.dart';
import 'package:capstone_project_lms/provider/acitiveclass_provider.dart';
import 'package:capstone_project_lms/provider/getuser_provider.dart';
import 'package:capstone_project_lms/provider/join_provider.dart';
import 'package:capstone_project_lms/provider/material_provider.dart';
import 'package:capstone_project_lms/widgets/list_class_widget.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../provider/activityhistory_provider.dart';
import '../../widgets/hexcolor_widget.dart';
import '../../widgets/loading_inscreen_widget.dart';
import '../detailClass/detail_screen.dart';

class MyCourseScreen extends StatefulWidget {
  const MyCourseScreen({Key? key}) : super(key: key);

  @override
  State<MyCourseScreen> createState() => _MyCourseScreenState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _textEditingController = TextEditingController();
Color secColor = HexColor('#415A80');

class _MyCourseScreenState extends State<MyCourseScreen> {
  static const _pageSize = 20;

  final PagingController<int, ListClassPaginationResponse> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      // final newItems = await RemoteApi.getCharacterList(pageKey, _pageSize);
      final newItems = await API().listClassPagination(pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Future<void> joinClassDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, _) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: SizedBox(
                // height: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Class Code",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text(
                        "Ask the admin / mentor for the class code, then enter the code here.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              controller: _textEditingController,
                              cursorColor: secColor,
                              validator: (value) {
                                return value!.isNotEmpty
                                    ? null
                                    : "Code class Must be filled!";
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter Class Code',
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: secColor,
                                ),
                                hintStyle: const TextStyle(color: Colors.grey),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: secColor, width: 2),
                                ),
                              ),
                            ),
                          )),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(color: secColor))),
                              backgroundColor:
                                  MaterialStateProperty.all(secColor)),
                          onPressed: () async {
                            try {
                              await Provider.of<JoinProvider>(context,
                                      listen: false)
                                  .joinClass(
                                      Provider.of<GetUserProvider>(context,
                                              listen: false)
                                          .userToken,
                                      Provider.of<GetUserProvider>(context,
                                              listen: false)
                                          .userId,
                                      _textEditingController.text);
                              if (mounted) {
                                if (context
                                        .read<JoinProvider>()
                                        .joinResClass
                                        .status ==
                                    true) {
                                  var snackBar = SnackBar(
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'Success',
                                        message:
                                            'Join Success!\nCheck your new class!',
                                        contentType: ContentType.success,
                                      ));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  Navigator.pop(context);
                                  Provider.of<ActiveClassProvider>(context,
                                          listen: false)
                                      .getListClass(Provider.of<JoinProvider>(
                                                  context,
                                                  listen: false)
                                              .joinResClass
                                              .data
                                              ?.id ??
                                          'null');
                                  Provider.of<ActiveClassProvider>(context,
                                          listen: false)
                                      .getActiveClass();
                                  Provider.of<ActivityHistoryProvider>(context,
                                          listen: false)
                                      .history();
                                  _textEditingController.clear();
                                } else {
                                  var snackBar = SnackBar(
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'Oops!',
                                        message: 'Invalid Code!',
                                        contentType: ContentType.failure,
                                      ));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  Navigator.pop(context);
                                  _textEditingController.clear();
                                }
                              }
                            } catch (e) {
                              // print(e);
                            }
                          },
                          child: const Text("JOIN")),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: const BorderSide(
                                          color: Colors.grey))),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey)),
                          onPressed: () {
                            _textEditingController.clear();
                            Navigator.of(context).pop();
                          },
                          child: const Text("CANCEL")),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'My Class',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Consumer<ActiveClassProvider>(
          builder: (context, data, _) {
            return Column(
              children: [
                if (data.dataClass.data!.isEmpty)
                  SizedBox(
                    child: LottieBuilder.asset(
                      "assets/emptyScreen.json",
                      fit: BoxFit.fill,
                    ),
                  ),
                if (data.dataClass.data!.isEmpty)
                  const SizedBox(
                      child: Center(
                    child: Text(
                      'Oops, you haven\'t join any class..',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  )),
                if (data.dataClass.data!.isEmpty)
                  SizedBox(
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(color: secColor))),
                          backgroundColor: MaterialStateProperty.all(secColor)),
                      icon: const Icon(Icons.door_front_door),
                      label: const Text(
                        'JOIN CLASS',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      onPressed: () async {
                        await joinClassDialog(context);
                      },
                    ),
                  ),
                if (data.dataClass.data!.isNotEmpty)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: AlertDialog(
                                  content: loadingInScreen(),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                ),
                                duration: const Duration(seconds: 1),
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ));
                              await Provider.of<GetMaterialClassProvider>(
                                      context,
                                      listen: false)
                                  .getListClass(data.dataClass.data?[index].id
                                          .toString() ??
                                      'null');

                              if (mounted) {
                                try {
                                  var dataClass =
                                      Provider.of<GetMaterialClassProvider>(
                                              context,
                                              listen: false)
                                          .listClass
                                          .data;

                                  if (dataClass != null &&
                                      dataClass.isNotEmpty) {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return DetailScreen(
                                          classId: data
                                              .dataClass.data?[index].id
                                              .toString(),
                                          indexClass: index,
                                        );
                                      },
                                    ));
                                  } else {
                                    var snackBar = SnackBar(
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: AwesomeSnackbarContent(
                                          title: 'Oops!',
                                          message: 'Class Materi is Empty :(',
                                          contentType: ContentType.warning,
                                        ));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                } catch (e) {
                                  var snackBar = SnackBar(
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'Oops!',
                                        message: 'Class Materi is Empty :(',
                                        contentType: ContentType.warning,
                                      ));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                            },
                            child: listClassVertical(
                                data.dataClass.data?[index].name ?? '...',
                                data.dataClass.data?[index].room ?? '...',
                                data.dataClass.data?[index].users?.length
                                        .toString() ??
                                    '...'),
                          );
                        },
                        itemCount: data.dataClass.data?.length ?? 0,
                      ),
                    ),
                  ),
                // if (data.dataClass.data!.isNotEmpty)
                //   RefreshIndicator(
                //     onRefresh: () =>
                //         Future.sync(() => _pagingController.refresh()),
                //     child: PagedListView<int,
                //             ListClassPaginationResponse>.separated(
                //         pagingController: _pagingController,
                //         builderDelegate: PagedChildBuilderDelegate<
                //             ListClassPaginationResponse>(
                //           itemBuilder: (context, item, index) =>
                //               listClassVertical(
                //                   data.dataClass.data?[index].name ?? '...',
                //                   data.dataClass.data?[index].room ?? '...',
                //                   data.dataClass.data?[index].users?.length
                //                           .toString() ??
                //                       '...'),
                //         ),
                //         separatorBuilder: (context, index) => const Divider()),
                //   )
              ],
            );
          },
        ));
  }
}
