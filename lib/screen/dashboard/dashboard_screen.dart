import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:capstone_project_lms/provider/acitiveclass_provider.dart';
import 'package:capstone_project_lms/provider/getuser_provider.dart';
import 'package:capstone_project_lms/provider/join_provider.dart';
import 'package:capstone_project_lms/provider/material_provider.dart';
import 'package:capstone_project_lms/provider/navbar_provider.dart';
import 'package:capstone_project_lms/widgets/popupdialog_widget.dart';
import 'package:capstone_project_lms/widgets/hexcolor_widget.dart';
import 'package:capstone_project_lms/widgets/list_class_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../provider/activityhistory_provider.dart';
import '../../widgets/loading_inscreen_widget.dart';
import '../../widgets/loading_widget.dart';
import '../detailClass/detail_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  Future<void> showInformationDialog(BuildContext context) async {
    Color secColor = HexColor('#415A80');
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
    Color secColor = HexColor('#415A80');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Study Space',
        ),
      ),
      body: Consumer<ActiveClassProvider>(
        builder: (context, value, _) {
          switch (value.dataStatus) {
            case DataStatus.none:
              return Padding(
                padding: const EdgeInsets.all(10),
                child: CustomScrollView(slivers: [
                  //User Dashboard
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    floating: true,
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: secColor,
                                    child: const Icon(
                                      Icons.person_outline,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Hi ${context.watch<GetUserProvider>().userDataProvider.data?.fullName ?? 'Alexa'} !',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              //Notification Button
                              IconButton(
                                  onPressed: () {
                                    context
                                        .read<NavbarProvider>()
                                        .getIndexNavbar(2);
                                  },
                                  icon:
                                      const Icon(Icons.notifications_outlined))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  //Join class Button
                  SliverToBoxAdapter(
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
                        await showInformationDialog(context);
                      },
                    ),
                  ),
                  const SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  //Active Class Text
                  if (value.dataClass.data!.isNotEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Active Class',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<NavbarProvider>()
                                    .getIndexNavbar(1);
                              },
                              child: const Text(
                                'View All',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (value.dataClass.data!.isNotEmpty)
                    SliverToBoxAdapter(
                      child: SizedBox(
                          height: 150.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
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
                                      .getListClass(value
                                              .dataClass.data?[index].id
                                              .toString() ??
                                          'null');
                                  if (mounted) {
                                    try {
                                      var data =
                                          Provider.of<GetMaterialClassProvider>(
                                                  context,
                                                  listen: false)
                                              .listClass
                                              .data;
                                      if (data != null && data.isNotEmpty) {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return DetailScreen(
                                              classId: value
                                                      .dataClass.data?[index].id
                                                      .toString() ??
                                                  'null',
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
                                              message:
                                                  'Class Materi is Empty :(',
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
                                child: listClass(
                                  value.dataClass.data?[index].name ?? '...',
                                  value.dataClass.data?[index].createdBy ??
                                      '...',
                                  value.dataClass.data?[index].createdBy ==
                                          Provider.of<GetUserProvider>(context,
                                                  listen: false)
                                              .userDataProvider
                                              .data!
                                              .email
                                      ? 'Admin'
                                      : 'User',
                                ),
                              );
                            },
                            itemCount: value.dataClass.data?.length ?? 0,
                          )),
                    ),
                  if (value.dataClass.data!.isEmpty)
                    SliverToBoxAdapter(
                      child: LottieBuilder.asset(
                        "assets/emptyScreen.json",
                        fit: BoxFit.fill,
                      ),
                    ),
                  if (value.dataClass.data!.isEmpty)
                    const SliverToBoxAdapter(
                        child: Center(
                      child: Text(
                        'Oops, you haven\'t join any class..',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    )),
                ]),
              );
            case DataStatus.loading:
              return const LoadingWidget();
            case DataStatus.error:
              return PopUpDialogWidget(
                text: 'Something Wrong...',
                type: ContentType.failure,
              );
          }
        },
      ),
    );
  }
}
