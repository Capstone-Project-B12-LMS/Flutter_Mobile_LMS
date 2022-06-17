import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:capstone_project_lms/provider/getuser_provider.dart';
import 'package:capstone_project_lms/provider/navbar_provider.dart';
import 'package:capstone_project_lms/widgets/hexcolor_widget.dart';
import 'package:capstone_project_lms/widgets/list_class_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/join_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late SharedPreferences logindata;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyReq = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController txtFullNameReq = TextEditingController();
  final TextEditingController txtEmailReq = TextEditingController();
  final TextEditingController txtClassReq = TextEditingController();

  Future<void> showInformationDialog(BuildContext context) async {
    Color secColor = HexColor('#415A80');
    return await showDialog(
        context: context,
        builder: (context) {
          // bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: SizedBox(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Class Code",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                          )),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 5, left: 10, right: 10),
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
                                      Provider.of<JoinProvider>(context,
                                              listen: false)
                                          .token,
                                      Provider.of<JoinProvider>(context,
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
                                  _textEditingController.clear();
                                } else {
                                  var snackBar = SnackBar(
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'Oops!',
                                        message: 'Somethng Wrong..',
                                        contentType: ContentType.failure,
                                      ));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: CustomScrollView(slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            floating: true,
            elevation: 1,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hi ${context.watch<GetUserProvider>().userDataProvider.data?.fullName ?? 'Alexa'} !',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                Text(
                                  context
                                          .watch<GetUserProvider>()
                                          .userDataProvider
                                          .data
                                          ?.roles?[0]
                                          .name ??
                                      'Roles',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            var snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Information',
                                  message: 'Coming Soon...',
                                  contentType: ContentType.warning,
                                ));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          icon: const Icon(Icons.notifications_outlined))
                    ],
                  ),
                ),
              ),
              // title: const Text('Active Class'),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          SliverToBoxAdapter(
            child: ElevatedButton.icon(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: secColor))),
                  backgroundColor: MaterialStateProperty.all(secColor)),
              icon: const Icon(Icons.door_front_door),
              label: const Text(
                'Join Class',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              onPressed: () async {
                await showInformationDialog(context);
              },
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
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
                      setState(() {
                        context.read<NavbarProvider>().getIndexNavbar(1);
                      });
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
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/detail');
              },
              child: SizedBox(
                height: 150.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return SizedBox(
                        width: 150.0,
                        child: listClass('UI/UX Design for Beginner', '89%'));
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Card(
                elevation: 10,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Need an online class request?',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      const Text(
                        'Fill out this form',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Card(
                        elevation: 0,
                        child: Form(
                          key: _formKeyReq,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: TextFormField(
                                  controller: txtFullNameReq,
                                  cursorColor: secColor,
                                  validator: (value) {
                                    return value!.isNotEmpty
                                        ? null
                                        : "Full Name must be filled!";
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Full Name',
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide:
                                          BorderSide(color: secColor, width: 2),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: TextFormField(
                                  controller: txtEmailReq,
                                  cursorColor: secColor,
                                  validator: (value) {
                                    return value!.isNotEmpty
                                        ? null
                                        : "Email must be filled!";
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide:
                                          BorderSide(color: secColor, width: 2),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: TextFormField(
                                  controller: txtClassReq,
                                  cursorColor: secColor,
                                  validator: (value) {
                                    return value!.isNotEmpty
                                        ? null
                                        : "Class must be filled!";
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'The class you requested',
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide:
                                          BorderSide(color: secColor, width: 2),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              side:
                                                  BorderSide(color: secColor))),
                                      backgroundColor:
                                          MaterialStateProperty.all(secColor)),
                                  child: const Text(
                                    'SUBMIT A REQUEST',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onPressed: () async {
                                    final isValidForm =
                                        _formKeyReq.currentState!.validate();
                                    if (isValidForm) {
                                      final bool isValid =
                                          EmailValidator.validate(
                                              txtEmailReq.text);
                                      if (isValid) {
                                        var snackBar = SnackBar(
                                            elevation: 0,
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            content: AwesomeSnackbarContent(
                                              title: 'Success!',
                                              message:
                                                  'Successfully Registered!',
                                              contentType: ContentType.success,
                                            ));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      } else {
                                        var snackBar = SnackBar(
                                            elevation: 0,
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            content: AwesomeSnackbarContent(
                                              title: 'Oops!',
                                              message:
                                                  'Your email isn\'t valid!',
                                              contentType: ContentType.warning,
                                            ));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          )
        ]),
      ),
    );
  }
}
