import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:capstone_project_lms/provider/navbar_provider.dart';
import 'package:capstone_project_lms/widgets/hexcolor_widget.dart';
import 'package:capstone_project_lms/widgets/list_class_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
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
                        "Ask the admin or mentor for the class code, then input the code here.",
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
                          onPressed: () {
                            Navigator.pop(context);
                            var snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Success!',
                                  message: 'Successfully joined the class',
                                  contentType: ContentType.success,
                                ));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            // CoolAlert.show(
                            //   context: context,
                            //   type: CoolAlertType.success,
                            //   text: 'Successfully joined the class',
                            // );
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
            // return AlertDialog(
            //   content: Form(
            //       key: _formKey,
            //       child: TextFormField(
            //         controller: _textEditingController,
            //         validator: (value) {
            //           return value!.isNotEmpty
            //               ? null
            //               : "Code class Must be filled!";
            //         },
            //         decoration: const InputDecoration(
            //             hintText: "Please Enter Code Class"),
            //       )),
            //   title: const Text('Join Class'),
            //   elevation: 0,
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10.0)),

            //   actions: <Widget>[
            //     InkWell(
            //       child: const Text('OK'),
            //       onTap: () {
            //         if (_formKey.currentState!.validate()) {
            //           // Do something like updating SharedPreferences or User Settings etc.
            //           // Navigator.of(context).pop();
            //           showDialog(
            //               context: context,
            //               builder: (context) {
            //                 return AlertDialog(
            //                   title: const Text("Success"),
            //                   titleTextStyle: const TextStyle(
            //                       fontWeight: FontWeight.bold,
            //                       color: Colors.black,
            //                       fontSize: 20),
            //                   actionsOverflowButtonSpacing: 20,
            //                   actions: [
            //                     ElevatedButton(
            //                         onPressed: () {
            //                           _textEditingController.clear();
            //                           Navigator.of(context).pop();
            //                           Navigator.of(context).pop();
            //                         },
            //                         child: const Text("Ok")),
            //                   ],
            //                   content: const Text("Success to join the class"),
            //                 );
            //               });
            //         }
            //       },
            //     ),
            //   ],
            // );
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
            // pinned: true,
            floating: true,
            // expandedHeight: 200.0,
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
                              children: const [
                                Text(
                                  'Hi, Alexa!',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                Text(
                                  'Status / Occupation',
                                  style: TextStyle(
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
          // SliverAppBar(
          //   automaticallyImplyLeading: false,
          //   backgroundColor: Colors.white,
          //   // pinned: true,
          //   floating: true,
          //   // expandedHeight: 200.0,
          //   elevation: 1,
          //   flexibleSpace: FlexibleSpaceBar(
          //     background: SizedBox(
          //         child: ElevatedButton.icon(
          //       style: ButtonStyle(
          //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //               RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(18.0),
          //                   side: BorderSide(color: secColor))),
          //           backgroundColor: MaterialStateProperty.all(secColor)),
          //       icon: const Icon(Icons.door_front_door),
          //       label: const Text(
          //         'Join Class',
          //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          //       ),
          //       onPressed: () {},
          //     )),
          //     // title: const Text('Active Class'),
          //   ),
          // ),
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
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: ((context) => const MainScreen(
                      //               selectedIndex: 1,
                      //             ))));
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
        ]),
      ),
    );
  }
}
