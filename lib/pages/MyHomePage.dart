import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fyp/providers.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // if (ref.read(userProvider).value == null)
    //   Navigator.pushReplacementNamed(context, "/login");
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          icon: const Icon(Icons.logout_outlined),
          tooltip: 'Logout',
          onPressed: () async {
            ref.read(firebaseAuthProvider).signOut();
            print(ref.read(userProvider).value);
          },
        ),
      ]),
      body: Column(
        children: [
          // TextField(
          //   controller: ref.read(controllerProvider),
          // ),
          // FloatingActionButton(onPressed: () {
          //   // final aadharNumber = ref.read(controllerProvider).text.toString();
          //   // ref.read(aadharProvider.state).state = aadharNumber;
          //   // print("Aadhar Number is now: " + aadharNumber);
          // }),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: ref.watch(snapshotProvider).map(
                data: (data) {
                  List<Widget> retval = [];
                  DataTable dataTable = new DataTable(
                    columns: const [
                      DataColumn(label: Text("Org Name")),
                      DataColumn(label: Text("Document ID")),
                      DataColumn(label: Text("Permission")),
                    ],
                    rows: [],
                  );
                  data.maybeWhen(
                      data: (data) {
                        data.forEach((element) {
                          dataTable.rows.add(
                            DataRow(cells: [
                              DataCell(
                                Text(element.item1),
                              ),
                              DataCell(
                                Text(element.item2),
                              ),
                              // DataCell(
                              //   Text(element.item3.toString()),
                              // ),
                              DataCell(Switch(
                                onChanged: (value) {
                                  final aadharNumber =
                                      ref.read(aadharProvider).value.toString();
                                  DatabaseReference reference = FirebaseDatabase
                                      .instance
                                      .ref(aadharNumber)
                                      .child(element.item1)
                                      .child(element.item2);
                                  reference.set(!element.item3);
                                },
                                value: element.item3,
                              ))
                            ]),
                          );
                          // retval.add(Row(
                          //   children: [
                          //     Text(element.item1 +
                          //         " " +
                          //         element.item2 +
                          //         " " +
                          //         element.item3.toString()),
                          //     FloatingActionButton(onPressed: () {
                          //       final aadharNumber = ref.read(aadharProvider);
                          //       DatabaseReference reference = FirebaseDatabase
                          //           .instance
                          //           .ref(aadharNumber)
                          //           .child(element.item1)
                          //           .child(element.item2);
                          //       reference.set(!element.item3);
                          //     })
                          //   ],
                          // ));
                        });
                      },
                      orElse: () => print("Passed"));
                  retval.add(dataTable);
                  return retval;
                },
                error: (err) => [],
                loading: (load) => []),
          )
        ],
      ),
    );
  }
}
