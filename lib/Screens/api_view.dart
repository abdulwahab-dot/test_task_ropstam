
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task/Model/data_model.dart';
import 'package:test_task/Screens/login_screen.dart';
import 'package:test_task/Utils/data_util.dart';
import 'package:test_task/Utils/navigator.dart';
import 'package:test_task/provider/app_state.dart';
import 'package:test_task/provider/auth_provider.dart';

class ApiView extends StatefulWidget {
  const ApiView({Key? key}) : super(key: key);

  @override
  State<ApiView> createState() => _ApiViewState();
}

class _ApiViewState extends State<ApiView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool _islogged = true;
    AuthenticationProvider auth = AuthenticationProvider();
    return Consumer<AppState>(
      builder: (context, provider, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.purple,
            child: const Icon(CupertinoIcons.refresh_thick),
            onPressed: () async {
              List<DataModel> data = await DataUtil().getData();
              provider.updateDataModel(data);
            },
          ),
          appBar:  CupertinoNavigationBar(
            backgroundColor: Colors.purple,
            middle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Test Api Data(List View)",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18),),
                GestureDetector(onTap: (){
                    setState(() {
                      auth.isLogedin == false;
                    });
                    PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());

                },child: Icon(Icons.logout,size: 25,color: Colors.white,)),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
            child: Container(
              height: size.height -
                  const CupertinoNavigationBar().preferredSize.height,
              width: size.width,
              child: provider.dataList.isEmpty
                  ? Center(child: const Text("No Data Available",style: TextStyle(fontSize: 25),))
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text("${provider.dataList[index].title}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                          leading: Text("${provider.dataList[index].id}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700)),
                        );
                      },
                      itemCount: provider.dataList.length,
                    ),
            ),
          ),
        );
      },
    );
  }
}
