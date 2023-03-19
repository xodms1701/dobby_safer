import 'package:doby_safer/config/db_helper.dart';
import 'package:doby_safer/enums/config_type.dart';
import 'package:doby_safer/models/config.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

const title = {
  ConfigType.overtimeWork: "연장근무수당",
  ConfigType.holidayWorkWithinEight: "8시간 이내 휴일 근무",
  ConfigType.holidayWorkOverEight: "8시간 초과 휴일 근무",
  ConfigType.nightShift: "야간 수당 (+)"
};

class MyPageView extends StatefulWidget {
  const MyPageView({super.key});

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('마이페이지'),
      ),
      body: FutureBuilder(
        future: DBHelper().getAllConfig(),
        builder: (BuildContext context, AsyncSnapshot<List<Config>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                Config item = snapshot.data![index];
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 5.0,
                          offset: const Offset(0, 10),
                        )
                      ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            TextField(
                              decoration: InputDecoration(labelText: title[item.type]),
                              controller: TextEditingController(text: item.value.toString()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              padding: const EdgeInsets.all(8.0),
            );
          }
          else {
            return const Center(child: CircularProgressIndicator(),);
          }
        }
      ),
    );
  }
}