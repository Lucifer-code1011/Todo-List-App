import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../notification/local_notification.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _todoController = TextEditingController();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  var _option = 'Other';
  int _highcounter = 0;
  int _lowcounter = 0;
  int taskCounter = 0;
  int value = 0;

  late LocalNotificationService service;
  final CollectionReference Tasks =
      FirebaseFirestore.instance.collection('Tasks');

  @override
  void initState() {
    service = LocalNotificationService();
    service.intialize();
    super.initState();
  }

  void _showNotification() {
    service.showNotification(
      id: 1,
      title: 'Welcome Sir',
      body: 'Lets start coding',
    );
  }

  void _showTimer() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }

  Future<void> _delete(String productId) async {
    await Tasks.doc(productId).delete();

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('You have deleted a task')));
  }

  _appBar() {
    return PreferredSize(
      preferredSize: const Size(double.infinity, 190),
      child: Column(
        children: [
          SizedBox(
            height: 80.2,
            width: double.infinity,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          /// USER NAME
                          Text("You have assigned",
                              style: GoogleFonts.roboto(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade700,
                              )),

                          /// CHAT MESSAGE
                          Container(
                            margin: const EdgeInsets.only(top: 2.0),
                            child: GestureDetector(
                              child: Text(
                                '$taskCounter tasks',
                                maxLines: null,
                                style: GoogleFonts.roboto(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 25, 16, 16),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {}, // Handle your callback.
                        splashColor: Colors.brown.withOpacity(0.5),
                        child: Icon(
                          IconlyLight.notification,
                        )),
                  ),
                ]),
          ),
          Container(
            height: 100,
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: SizedBox(
                          width: 100,
                          height: 32,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Color.fromARGB(224, 0, 0, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              'Priority',
                              style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 20),
                        child: Badge(
                          badgeColor: const Color.fromARGB(208, 0, 0, 0),
                          position: BadgePosition.topEnd(top: -6, end: -23),
                          badgeContent: Text(
                            _lowcounter.toString(),
                            style: const TextStyle(
                                fontSize: 13, color: Colors.white),
                          ),
                          elevation: 0,
                          child: Text(
                            '🟢 Low',
                            style: GoogleFonts.roboto(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 10),
                        child: Badge(
                          badgeColor: const Color.fromARGB(208, 0, 0, 0),
                          position: BadgePosition.topEnd(top: -6, end: -23),
                          badgeContent: Text(
                            _highcounter.toString(),
                            style: const TextStyle(
                                fontSize: 13, color: Colors.white),
                          ),
                          elevation: 0,
                          child: Text(
                            '🔴 High',
                            style: GoogleFonts.roboto(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 35,
                      bottom: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Your Tasks',
                          style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, bottom: 7),
                          child: Text(
                            '$taskCounter',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF5F52EE),
                            ),
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: StreamBuilder(
          stream: Tasks.snapshots(), //build connection
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        SizedBox(
                          height: 180,
                          width: 180,
                          child: Lottie.asset(
                            'assets/images/astronaut.json',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Empty List!",
                          style: GoogleFonts.roboto(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "You have no tasks at the movement.",
                          style: GoogleFonts.roboto(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            if (snapshot.hasData) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, int index) {
                    final DocumentSnapshot documentSnapshot =
                        snapshot.data!.docs[index];

                    Future.delayed(Duration(microseconds: 1000), () {
                      taskCounter = snapshot.data!.docChanges.length;
                    });

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: const BoxDecoration(
                        border: Border(),
                      ),
                      child: Slidable(
                        key: UniqueKey(),
                        endActionPane: ActionPane(
                          dismissible: DismissiblePane(
                            onDismissed: () async {
                              setState(() {
                                if (documentSnapshot["task_priority"] ==
                                    'Low') {
                                  _lowcounter--;
                                } else if (documentSnapshot["task_priority"] ==
                                    'High') {
                                  _highcounter--;
                                } else if (documentSnapshot["task_priority"] ==
                                    'Other') {
                                  _lowcounter--;
                                }

                                _delete(documentSnapshot.id);
                              });
                            },
                          ),
                          motion: const StretchMotion(),
                          extentRatio: 0.5,
                          children: [
                            SlidableAction(
                              // An action can be bigger than the other
                              flex: 1,
                              onPressed: ((context) async {
                                setState(() {
                                  if (documentSnapshot["task_priority"] ==
                                      'Low') {
                                    _lowcounter--;
                                  } else if (documentSnapshot[
                                          "task_priority"] ==
                                      'High') {
                                    _highcounter--;
                                  } else if (documentSnapshot[
                                          "task_priority"] ==
                                      'Other') {
                                    _lowcounter--;
                                  }

                                  _delete(documentSnapshot.id);
                                });
                              }),
                              borderRadius: BorderRadius.circular(10),

                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red.shade300,
                              icon: IconlyLight.delete,
                            ),
                          ],
                        ),
                        child: ListTile(
                          onTap: () {
                            // print('Clicked on Todo Item.');
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 5),
                          tileColor: const Color.fromRGBO(248, 245, 245, 1),
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              //scrossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    // task name
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8.0, 0.0, 8.0, 4.0),
                                          child: SizedBox(
                                            width: 260,
                                            child: Text(
                                              documentSnapshot["task_title"],
                                              style: GoogleFonts.roboto(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                                decorationThickness: 1.5,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: SizedBox(
                                            height: 20,
                                            child: Row(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 8.0),
                                                  child: Icon(
                                                    IconlyLight.calendar,
                                                    size: 15,
                                                  ),
                                                ),
                                                Text(
                                                  documentSnapshot["task_time"],
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 8.0,
                                      ),
                                      child:
                                          (documentSnapshot["task_priority"] ==
                                                  'High')
                                              ? Image.asset(
                                                  'assets/images/high-importance.png',
                                                  height: 20,
                                                  width: 20,
                                                )
                                              : Image.asset(
                                                  'assets/images/low-importance.png',
                                                  height: 20,
                                                  width: 20,
                                                ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return const Text("Error");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(165, 0, 0, 0),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            backgroundColor: Color.fromARGB(255, 243, 239, 239),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(15),
                topStart: Radius.circular(15),
              ),
            ),
            builder: (context) => SingleChildScrollView(
              padding: EdgeInsetsDirectional.only(
                start: 0,
                end: 0,
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 5,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 12.0),
                    child: Text(
                      'Task Title',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0.0),
                    child: Center(
                      child: SizedBox(
                        height: 24,
                        child: Wrap(
                          children: <Widget>[
                            TextField(
                              cursorColor: Colors.black,
                              cursorHeight: 24,
                              controller: _todoController,
                              autofocus: true,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  IconlyLight.arrow_right_circle,
                                  size: 24,
                                ),
                                prefixIconColor: Colors.black,
                                border: InputBorder.none,
                              ),
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 76, 75, 75),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 12.0),
                    child: Text(
                      'Priority',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 25,
                          width: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              _option = 'Low';
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.green.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Text(
                              'Low',
                              style: GoogleFonts.roboto(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.green.shade900,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: SizedBox(
                            height: 25,
                            width: 80,
                            child: ElevatedButton(
                              onPressed: () {
                                _option = 'High';
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.red.shade100,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Text(
                                'High',
                                style: GoogleFonts.roboto(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                    child: Text(
                      'Set Time',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _showTimer();
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor:
                                const Color.fromARGB(255, 214, 212, 212),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          icon: const Icon(
                            Icons.timer_outlined,
                            size: 16,
                            color: Colors.black,
                          ),
                          label: Text(
                            _timeOfDay.format(context).toString(),
                            style: GoogleFonts.roboto(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            FirebaseFirestore.instance.collection("Tasks").add({
                              "task_title": _todoController.text,
                              "task_time":
                                  _timeOfDay.format(context).toString(),
                              "task_priority": _option,
                            }).then((value) {});
                            setState(() {
                              if (_option == 'Low') {
                                _lowcounter++;
                              } else if (_option == 'High') {
                                _highcounter++;
                              } else if (_option == 'Other') {
                                _lowcounter++;
                              }

                              _option = 'Other';
                            });

                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Create',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          );
        },
        child: const Icon(
          MdiIcons.plus,
        ),
      ),
    ));
  }
}
