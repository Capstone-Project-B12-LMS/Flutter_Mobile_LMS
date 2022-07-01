import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:capstone_project_lms/provider/counselling_provider.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../provider/material_provider.dart';
import '../widgets/hexcolor_widget.dart';
import '../widgets/list_class_widget.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, this.classId = ''}) : super(key: key);
  final String? classId;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  loadUserData() async {
    Provider.of<GetMaterialClassProvider>(context, listen: false)
        .getListClass(widget.classId!);
  }

  String? linkVideo;
  formatLink(String link) {
    String? videoId;
    videoId = YoutubePlayer.convertUrlToId(link);
    return videoId;
  }

  final List<String> _ids = [
    'dYRs7Q1vfYI',
    'MkKEWHfy99Y',
    'RaThk0fiphA',
  ];

  bool _muted = false;
  bool _isPlayerReady = false;
  bool isSelected = false;
  int _selectedIndex = 0;

  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  // ignore: unused_field
  late YoutubeMetaData _videoMetaData;

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        // _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void initState() {
    loadUserData();
    // formatLink(link)
    _controller = YoutubePlayerController(
      initialVideoId: _ids.first,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    super.initState();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  final settings = RestrictedAmountPositions(
      maxAmountItems: 4,
      maxCoverage: 0.7,
      minCoverage: 0.1,
      align: StackAlign.left);
  Color thColor = HexColor('#9EC9E2');
  int konten = 1;
  Color secColor = HexColor('#415A80');

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final TextEditingController txtTopic = TextEditingController();
    final TextEditingController txtContent = TextEditingController();
    Future<void> showInformationDialog(BuildContext context) async {
      Color secColor = HexColor('#415A80');
      return await showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Counselling Request Form",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Fill out this form and receive a response within 1-2 days.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  controller: txtTopic,
                                  cursorColor: secColor,
                                  validator: (value) {
                                    return value!.isNotEmpty
                                        ? null
                                        : "Topic must be filled!";
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Topic',
                                    prefixIcon: Icon(
                                      Icons.person_outline,
                                      color: secColor,
                                    ),
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: secColor, width: 2),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  controller: txtContent,
                                  cursorColor: secColor,
                                  validator: (value) {
                                    return value!.isNotEmpty
                                        ? null
                                        : "Content must be filled!";
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Content',
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: secColor,
                                    ),
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: secColor, width: 2),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
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
                                      side: BorderSide(color: secColor))),
                              backgroundColor:
                                  MaterialStateProperty.all(secColor)),
                          onPressed: () async {
                            final isValidForm =
                                formKey.currentState!.validate();
                            if (isValidForm) {
                              await Provider.of<CounsellingProvdider>(context,
                                      listen: false)
                                  .reqCounselling(txtTopic.text,
                                      widget.classId!, txtContent.text);
                              if (mounted) {
                                Navigator.pop(context);
                                if (Provider.of<CounsellingProvdider>(context,
                                            listen: false)
                                        .dataCounselling
                                        .status ==
                                    true) {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text(
                                        'COUNSELLING REQUEST COMPLETE!',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                      content: const Text(
                                        'You\'ll receive a confirmation when your request has been accepted or declined.',
                                        style: TextStyle(color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: <Widget>[
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          side: BorderSide(
                                                              color:
                                                                  secColor))),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          secColor)),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("OK")),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text(
                                        'COUNSELLING REQUEST FAILED!',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                      content: const Text(
                                        'Oops!\nPlease try again later..',
                                        style: TextStyle(color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: <Widget>[
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          side: BorderSide(
                                                              color:
                                                                  secColor))),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          secColor)),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("OK")),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
                            }
                          },
                          child: const Text("SUBMIT A REQUEST")),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 20),
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
              );
            });
          });
    }

    void _showSnackBar(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16.0,
            ),
          ),
          backgroundColor: Colors.blueAccent,
          behavior: SnackBarBehavior.floating,
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      );
    }

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: Icon(
              _muted ? Icons.volume_off : Icons.volume_up,
              color: Colors.white,
            ),
            onPressed: _isPlayerReady
                ? () {
                    _muted ? _controller.unMute() : _controller.mute();
                    setState(() {
                      _muted = !_muted;
                    });
                  }
                : null,
          ),
        ],
        bottomActions: [
          CurrentPosition(),
          ProgressBar(isExpanded: true),
          FullScreenButton(
            color: Colors.white,
          )
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
          _controller
              .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
          _showSnackBar('Next Video Started!');
        },
      ),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Consumer<GetMaterialClassProvider>(
            builder: (context, materialClass, child) {
              return Text(
                materialClass.materialClass.data?[0].classes?.name ?? '...',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              );
            },
            // child:
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: secColor,
              )),
        ),
        body: Consumer<GetMaterialClassProvider>(
          builder: (context, materialClass, child) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  player,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          materialClass
                                  .materialClass.data?[_selectedIndex].title ??
                              '..',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/members');
                              },
                              child: AvatarStack(
                                settings: settings,
                                height: 40,
                                width: 100,
                                avatars: [
                                  for (var n = 0; n < 3; n++)
                                    NetworkImage(
                                        'https://i.pravatar.cc/150?img=$n')
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "${materialClass.materialClass.data?[0].classes?.users?.length} Members",
                                style: const TextStyle(fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: CustomSlidingSegmentedControl<int>(
                          isStretch: true,
                          children: const {
                            1: Text(
                              'Description',
                              textAlign: TextAlign.center,
                            ),
                            2: Text(
                              'Contents',
                              textAlign: TextAlign.center,
                            ),
                            3: Text(
                              'Feedback',
                              textAlign: TextAlign.center,
                            ),
                          },
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          thumbDecoration: BoxDecoration(
                            color: thColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.3),
                                blurRadius: 4.0,
                                spreadRadius: 1.0,
                                offset: const Offset(
                                  0.0,
                                  2.0,
                                ),
                              ),
                            ],
                          ),
                          onValueChanged: (int value) {
                            // print(value);
                            if (value == 1) {
                              setState(() {
                                konten = 1;
                              });
                            } else if (value == 2) {
                              setState(() {
                                konten = 2;
                              });
                            } else if (value == 3) {
                              setState(() {
                                konten = 3;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  if (konten == 1)
                    Expanded(
                        child: CustomScrollView(
                      slivers: [
                        SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            sliver: SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: secColor,
                                          child: const Icon(
                                            Icons.person_outline,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              materialClass.materialClass
                                                      .data?[0].createdBy ??
                                                  '..',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              materialClass.materialClass
                                                      .data?[0].createdBy ??
                                                  '..',
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            )
                                          ],
                                          // child:
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    materialClass.materialClass
                                            .data?[_selectedIndex].content ??
                                        '..',
                                    style: const TextStyle(fontSize: 12),
                                    maxLines: 4,
                                    softWrap: true,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        showBarModalBottomSheet(
                                          context: context,
                                          builder: (context) =>
                                              SingleChildScrollView(
                                            controller:
                                                ModalScrollController.of(
                                                    context),
                                            child: SafeArea(
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10),
                                                      child: Text(
                                                        'Description',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    Text(
                                                      materialClass
                                                              .materialClass
                                                              .data?[
                                                                  _selectedIndex]
                                                              .content ??
                                                          '..',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                        // showModalBottomSheet(
                                        //   context: context,
                                        //   builder: (context) => Container(
                                        //     height: MediaQuery.of(context)
                                        //         .size
                                        //         .height,
                                        //     padding: const EdgeInsets.all(10),
                                        //     child: const Text(
                                        //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
                                        //   ),
                                        // );
                                      },
                                      child: Text(
                                        'See more',
                                        style: TextStyle(color: secColor),
                                      ))
                                ],
                              ),
                            )),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          sliver: SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Any Questions?',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
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
                                                side: BorderSide(
                                                    color: secColor))),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                secColor)),
                                    onPressed: () async {
                                      // if(txtTopic)

                                      showInformationDialog(context);
                                    },
                                    child: const Text(
                                      'REQUEST COUNSELLING',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                  if (konten == 2)
                    Expanded(
                        child: CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          sliver: SliverList(
                            // key: key3,
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (_selectedIndex == index) {
                                        _selectedIndex = 0;
                                      } else {
                                        _selectedIndex = index;
                                      }
                                    });
                                    _controller.load(_ids[(_ids.indexOf(
                                                _controller.metadata.videoId) +
                                            1) %
                                        _ids.length]);
                                  },
                                  child: Card(
                                    color: _selectedIndex == index
                                        ? thColor
                                        : Colors.white,
                                    elevation: 5,
                                    child: listClassVertical(
                                        materialClass.materialClass.data?[index]
                                                .title ??
                                            '..',
                                        materialClass.materialClass.data?[index]
                                                .createdBy ??
                                            '..',
                                        materialClass.materialClass.data?[index]
                                                .classes?.users?.length
                                                .toString() ??
                                            '..'),
                                  ),
                                );
                              },
                              childCount:
                                  materialClass.materialClass.data?.length ??
                                      1, // 1000 list items
                            ),
                          ),
                        ),
                      ],
                    )),
                  if (konten == 3)
                    Expanded(
                        child: CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Feedback ke-${index + 1}'),
                                      duration:
                                          const Duration(milliseconds: 300),
                                    ));
                                  },
                                  child: listFeedBack(
                                      'Name ${index + 1}',
                                      'Role..',
                                      'Ini adalah feedback\nIni adalah feedback\nIni adalah feedback'),
                                );
                              },
                              childCount: 10, // 1000 list items
                            ),
                          ),
                        ),
                      ],
                    )),
                ],
              ),
            );
          },
          // child:
        ),
      ),
    );
  }
}
