import 'dart:async';
import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:capstone_project_lms/provider/acitiveclass_provider.dart';
import 'package:capstone_project_lms/provider/counselling_provider.dart';
import 'package:capstone_project_lms/provider/feedback_provider.dart';
import 'package:capstone_project_lms/provider/material_provider.dart';
import 'package:capstone_project_lms/widgets/loading_inscreen_widget.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../provider/activityhistory_provider.dart';
import '../../widgets/hexcolor_widget.dart';
import '../../widgets/list_class_widget.dart';
import '../../widgets/popupdialog_widget.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, this.classId = '', this.indexClass})
      : super(key: key);
  final String? classId;
  final int? indexClass;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String? linkVideo;
  formatLink(String link) {
    String? videoId;
    videoId = YoutubePlayer.convertUrlToId(link);
    return videoId;
  }

  final bool _isPlayerReady = false;
  bool isSelected = false;
  int _selectedIndex = 0;

  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  // ignore: unused_field
  late YoutubeMetaData _videoMetaData;
  String? descriptionData;

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void initState() {
    Provider.of<FeedbackProvider>(context, listen: false)
        .getFeedback(widget.classId!);
    _controller = YoutubePlayerController(
      initialVideoId:
          Provider.of<GetMaterialClassProvider>(context, listen: false)
                  .listClass
                  .data?[0]
                  .videoUrl ??
              '',
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
    final Completer<WebViewController> controller =
        Completer<WebViewController>();
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
                                Provider.of<ActivityHistoryProvider>(context,
                                        listen: false)
                                    .history();
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

    String ppt = '';
    return Consumer<GetMaterialClassProvider>(
      builder: (context, materialClass, child) {
        switch (materialClass.materialStatus) {
          case MaterialStatus.none:
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
                  ],
                  bottomActions: [
                    CurrentPosition(),
                    ProgressBar(isExpanded: true),
                    FullScreenButton(
                      color: Colors.white,
                    )
                  ],
                  onReady: () {
                    if (_isPlayerReady) {
                      _controller.updateValue(
                        _controller.value.copyWith(isReady: true),
                      );
                    } else {
                      var vidId = formatLink(
                          Provider.of<GetMaterialClassProvider>(context,
                                      listen: false)
                                  .listClass
                                  .data?[_selectedIndex]
                                  .videoUrl ??
                              '');
                      _controller.load(vidId);
                    }
                  },
                ),
                builder: (context, player) => Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.white,
                        title: GestureDetector(
                          onTap: () => showModalBottomSheet(
                              context: context,
                              builder: (context) => SingleChildScrollView(
                                      child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(children: [
                                      const Text(
                                        'Title Class',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        context
                                                .watch<
                                                    GetMaterialClassProvider>()
                                                .listClass
                                                .data?[0]
                                                .classEntity
                                                ?.name ??
                                            '...',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ]),
                                  ))),
                          child: SizedBox(
                            child: Text(
                              materialClass
                                      .listClass.data?[0].classEntity?.name ??
                                  '...',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,

                              // child:
                            ),
                          ),
                        ),
                        centerTitle: true,
                        leading: IconButton(
                            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                                context, '/main', (route) => false),
                            icon: Icon(
                              Icons.arrow_back_ios_new_sharp,
                              color: secColor,
                            )),
                      ),
                      body: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            if (materialClass.listClass.data?[_selectedIndex]
                                        .videoUrl !=
                                    null &&
                                materialClass.listClass.data?[_selectedIndex]
                                        .videoUrl !=
                                    "")
                              player,
                            if (materialClass.listClass.data?[_selectedIndex]
                                        .fileUrl !=
                                    null &&
                                materialClass.listClass.data?[_selectedIndex]
                                        .fileUrl !=
                                    "")
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  return SizedBox(
                                    height: constraints.maxWidth * 9 / 16,
                                    child: WebView(
                                      onWebViewCreated: (WebViewController
                                          webViewController) {
                                        controller.complete(webViewController);
                                      },
                                      initialUrl: materialClass.listClass
                                              .data?[_selectedIndex].fileUrl ??
                                          '..',
                                      javascriptMode:
                                          JavascriptMode.unrestricted,
                                      gestureNavigationEnabled: true,
                                      backgroundColor: const Color(0x00000000),
                                    ),
                                  );
                                },
                              ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 10),
                                  child: Text(
                                    materialClass.listClass
                                            .data?[_selectedIndex].title ??
                                        '..',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 10),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/members');
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
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "${materialClass.listClass.data?[0].classEntity?.users?.length} Members",
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      sliver: SliverToBoxAdapter(
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
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
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        materialClass
                                                                .listClass
                                                                .data?[
                                                                    _selectedIndex]
                                                                .createdBy ??
                                                            '..',
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        materialClass
                                                                .listClass
                                                                .data?[
                                                                    _selectedIndex]
                                                                .createdBy ??
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
                                            HtmlWidget(
                                                materialClass
                                                        .listClass
                                                        .data?[_selectedIndex]
                                                        .content ??
                                                    '..',
                                                onErrorBuilder: (context,
                                                        element, error) =>
                                                    Text(
                                                        '$element error: $error'),
                                                onLoadingBuilder: (context,
                                                        element,
                                                        loadingProgress) =>
                                                    const CircularProgressIndicator(),
                                                textStyle: const TextStyle(
                                                    fontSize: 12)),
                                          ],
                                        ),
                                      )),
                                  SliverPadding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 20),
                                    sliver: SliverToBoxAdapter(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              'Any Questions?',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                                              onPressed: () async {
                                                // if(txtTopic)

                                                showInformationDialog(context);
                                              },
                                              child: const Text(
                                                'REQUEST COUNSELLING',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                            onTap: () async {
                                              setState(() {
                                                _selectedIndex = index;
                                              });
                                              if (Provider.of<ActiveClassProvider>(
                                                          context,
                                                          listen: false)
                                                      .materialClass
                                                      .data?[index]
                                                      .videoUrl !=
                                                  null) {
                                                var vidId = formatLink(
                                                    Provider.of<ActiveClassProvider>(
                                                                context,
                                                                listen: false)
                                                            .materialClass
                                                            .data?[index]
                                                            .videoUrl ??
                                                        '');
                                                _controller.load(vidId);
                                              } else if (Provider.of<
                                                              ActiveClassProvider>(
                                                          context,
                                                          listen: false)
                                                      .materialClass
                                                      .data?[index]
                                                      .fileUrl !=
                                                  null) {
                                                ppt = materialClass
                                                        .listClass
                                                        .data?[_selectedIndex]
                                                        .fileUrl ??
                                                    '';
                                                setState(() {
                                                  materialClass
                                                      .listClass
                                                      .data?[_selectedIndex]
                                                      .fileUrl = null;
                                                });

                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 100),
                                                    () {});
                                                setState(() {
                                                  materialClass
                                                      .listClass
                                                      .data?[_selectedIndex]
                                                      .fileUrl = ppt;
                                                });
                                              }
                                            },
                                            child: Card(
                                              color: _selectedIndex == index
                                                  ? thColor
                                                  : Colors.white,
                                              elevation: 5,
                                              child: listClassVertical(
                                                  materialClass.listClass
                                                          .data?[index].title ??
                                                      '..',
                                                  materialClass
                                                          .listClass
                                                          .data?[index]
                                                          .createdBy ??
                                                      '..',
                                                  materialClass
                                                          .listClass
                                                          .data?[index]
                                                          .classEntity
                                                          ?.users
                                                          ?.length
                                                          .toString() ??
                                                      '..'),
                                            ),
                                          );
                                        },
                                        childCount: materialClass
                                                .listClass.data?.length ??
                                            0, // 1000 list items
                                      ),
                                    ),
                                  ),
                                  SliverPadding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    sliver: SliverToBoxAdapter(
                                      child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          secColor)),
                                              onPressed: () async {
                                                String? dataUrl = Provider.of<
                                                            ActiveClassProvider>(
                                                        context,
                                                        listen: false)
                                                    .dataClass
                                                    .data?[widget.indexClass!]
                                                    .reportUrl;
                                                try {
                                                  if (dataUrl != null) {
                                                    final Uri url =
                                                        Uri.parse(dataUrl);

                                                    if (await canLaunchUrl(
                                                        url)) {
                                                      await launchUrl(url);
                                                    }
                                                  } else {
                                                    var snackBar = SnackBar(
                                                        elevation: 0,
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        content:
                                                            AwesomeSnackbarContent(
                                                          title: 'Oops!',
                                                          message:
                                                              'Report still in progress',
                                                          contentType:
                                                              ContentType
                                                                  .warning,
                                                        ));
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snackBar);
                                                  }
                                                } catch (e) {
                                                  var snackBar = SnackBar(
                                                      elevation: 0,
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      content:
                                                          AwesomeSnackbarContent(
                                                        title: 'Oops!',
                                                        message:
                                                            'Something Wrong..',
                                                        contentType:
                                                            ContentType.failure,
                                                      ));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                }
                                              },
                                              child: const Text(
                                                  'DOWNLOAD REPORT'))),
                                    ),
                                  ),
                                ],
                              )),
                            if (konten == 3)
                              Expanded(child: Consumer<FeedbackProvider>(
                                builder: (context, value, child) {
                                  return CustomScrollView(
                                    slivers: [
                                      SliverPadding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        sliver: SliverList(
                                          delegate: SliverChildBuilderDelegate(
                                            (BuildContext context, int index) {
                                              return listFeedBack(
                                                  value
                                                          .feedbackResponse
                                                          .data?[index]
                                                          .user
                                                          ?.fullName ??
                                                      '..',
                                                  value
                                                          .feedbackResponse
                                                          .data?[index]
                                                          .user
                                                          ?.roles?[0]
                                                          .name ??
                                                      '..',
                                                  value
                                                          .feedbackResponse
                                                          .data?[index]
                                                          .content ??
                                                      '..');
                                            },

                                            childCount: value.feedbackResponse
                                                    .data?.length ??
                                                0, // 1000 list items
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              )),
                          ],
                        ),
                        // child:
                      ),
                    ));

          case MaterialStatus.loading:
            return AlertDialog(
              content: loadingInScreen(),
              elevation: 0,
              backgroundColor: Colors.transparent,
            );
          case MaterialStatus.error:
            return PopUpDialogWidget(
              text: 'Something Wrong...',
              type: ContentType.failure,
            );
        }
      },
    );
  }
}
