// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        centerTitle: true,
        title: Text(
          "Student App",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 25,
              color: const Color.fromRGBO(0, 0, 0, 1)),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 30,
            ),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 1),
              boxShadow: [
                BoxShadow(
                  blurRadius: 16,
                  spreadRadius: 5,
                  offset: Offset(0, 8),
                  color: Color.fromRGBO(22, 34, 51, 0.08),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'Announcements',
                style: TextStyle(color: Colors.blue, fontSize: 30),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("student_parent_data")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData && snapshot.data != null) {
                  return Expanded(
                      child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> StuddentDataMap =
                          snapshot.data!.docs[index].data()
                              as Map<String, dynamic>;

                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 20, left: 20, right: 20),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 16,
                                spreadRadius: 5,
                                offset: Offset(0, 8),
                                color: Color.fromRGBO(22, 34, 51, 0.08),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 200,
                                width: double.infinity,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(
                                    right: 10, bottom: 10),
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 16,
                                        spreadRadius: 5,
                                        offset: Offset(0, 8),
                                        color: Color.fromRGBO(22, 34, 51, 0.08),
                                      ),
                                    ],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          StuddentDataMap["backgroundimage"],
                                        ),
                                        fit: BoxFit.fill)),
                                // child: Image.network(
                                //   StuddentDataMap["image"],
                                //   fit: BoxFit.fill,
                                // ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Title :",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          StuddentDataMap["title"],
                                          style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Description :",
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 230,
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Text(
                                      StuddentDataMap["description"],
                                      style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ));
                }
              }
              return Text("no data");
            },
          ),
        ],
      ),
    );
  }
}
