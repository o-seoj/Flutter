import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kmarket_shopping_app/providers/auth_provider.dart';
import 'package:kmarket_shopping_app/screens/main/my_tab.dart';
import 'package:kmarket_shopping_app/screens/member/login_screen.dart';
import 'package:kmarket_shopping_app/services/token_storage_service.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget{

  final Function(int) onTabSwitch;

  const HomeTab({super.key, required this.onTabSwitch});

  @override
  State<StatefulWidget> createState() =>_HomeTabState();

}

class _HomeTabState extends State<HomeTab>{

  final tokenStorageService = TokenStorageService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: _buildAppBar(context),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(context),
            _buildSlideBanner(context),
            _buildProductSection(context, '베스트 상품'),
            _buildProductSection(context, '히트상품'),
            _buildProductSection(context, '추천상품'),
            _buildProductSection(context, '최신상품'),
            _buildProductSection(context, '할인상품'),
            _buildFooter(context),

          ],
        ),
      )
    );
  }

  // 상단 앱바 디자인 함수
  Widget _buildAppBar(BuildContext context){

    // AuthProvider 구독
    final authProvider = Provider.of<AuthProvider>(context);
    bool isLoggedIn = authProvider.isLoggedIn;

    log('isLoggedIn : $isLoggedIn');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('images/logo.png', width: 140,),
        IconButton(
          onPressed: () async {

            if(isLoggedIn){
              /*
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => MyTab())
              );
              */

              // 마이페이지 탭 전환
              widget.onTabSwitch(3);

            }else{
              await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_)=>LoginScreen())
              );
              setState(() {});
            }



          },
          icon: Icon(
            isLoggedIn ? Icons.person : Icons.login,
            size: 30,
          ),
        )
      ],
    );
  }

  // 검색바 디자인 함수
  Widget _buildSearchBar(BuildContext context){
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: '상품 검색',
          border: null,
        ),
      ),
    );
  }

  // 슬라이드 디자인 함수
  Widget _buildSlideBanner(BuildContext context){

    final List<String> bannerImages = [
      'images/slider_item1.jpg',
      'images/slider_item2.jpg',
      'images/slider_item3.jpg',
      'images/slider_item4.jpg',
      'images/slider_item5.jpg',
    ];

    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: bannerImages.length,
        itemBuilder: (context, index){
          final pathImage = bannerImages[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 6),
            child: Image.asset(pathImage),
          );
        }
      ),
    );
  }

  // 상품 섹션 디자인 함수
  Widget _buildProductSection(BuildContext context, String title){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            itemBuilder: (context, index){
              return Container(
                width: 150,
                height: 150,
                child: Column(
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      color: Colors.grey,
                      child: Image.asset('images/sample_thumb.jpg'),
                    ),
                    Text('가을 티셔츠'),
                    Text('16,000원')
                  ],
                ),
              );
            }
          ),
        )
      ],
    );
  }

  // 하단 푸터 디자인 함수
  Widget _buildFooter(BuildContext context){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.0),
      color: Colors.grey[200],
      child: Column(
        children: [
          Text('회사 정보 및 약관'),
          Text('고객센터 : 000-000-0000', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
          Text('ⓒKmarket Shpping App. All right reserved.', style: TextStyle(fontSize: 10),),
        ],
      ),
    );
  }

}