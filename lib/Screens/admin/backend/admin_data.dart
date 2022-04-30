import 'package:flutter/material.dart';

class NavigationItem {
  IconData iconData;

  NavigationItem(this.iconData);
}

List<NavigationItem> getNavigationItemList() {
  return <NavigationItem>[
    NavigationItem(Icons.home),
    NavigationItem(Icons.calendar_today),
    NavigationItem(Icons.notifications),
    NavigationItem(Icons.person),
  ];
}

class MenuR {
  String name;
  int offers;
  String image;

  MenuR(this.name, this.offers, this.image);
}

List<MenuR> getMenuList() {
  return <MenuR>[
    MenuR(
      "ชุดเปิด",
      174,
      "asset/image/monstra.png",
    ),
    MenuR(
      "Avis",
      126,
      "asset/image/monstra.png",
    ),
    MenuR(
      "Avis",
      126,
      "asset/image/monstra.png",
    ),
    MenuR(
      "Avis",
      126,
      "asset/image/monstra.png",
    ),
    MenuR(
      "Avis",
      126,
      "asset/image/monstra.png",
    ),
  ];
}

class Recom {
  String name;
  int offers;
  String image;

  Recom(this.name, this.offers, this.image);
}

List<Recom> getRecomList() {
  return <Recom>[
    Recom(
      "",
      174,
      "asset/image/998c3d_f0abdc6794074dcdbc736fd27704903c_mv2.png",
    ),
    Recom(
      "",
      126,
      "asset/image/coveid-Herb-Beauty-819x1024.jpg",
    ),
    Recom(
      "",
      126,
      "asset/image/vilertong-cci-khemhealthyherb-covid-19-015-1024x1024.jpg",
    ),
    Recom(
      "",
      126,
      "asset/image/สมุนไพรพื้นบ้าน-0-2000x2500-FB-beauty-5july2021-819x1024.png",
    ),
    Recom(
      "",
      126,
      "asset/image/85.jpg",
    ),
  ];
}

class MenuRecom {
  String name;
  int offers;
  String image;

  MenuRecom(this.name, this.offers, this.image);
}

List<MenuRecom> getMenuRecomList() {
  return <MenuRecom>[
    MenuRecom(
      "ซุปใส/ซุปน้ำดำ",
      174,
      "asset/image/monstra.png",
    ),
    MenuRecom(
      "ซุปหมู/ซุปต้มยำ",
      126,
      "asset/image/monstra.png",
    ),
    MenuRecom(
      "ชุปน้ำดำ/ซุปข้น",
      126,
      "asset/image/monstra.png",
    ),
    MenuRecom(
      "เซ็ทน้ำจิ้ม1",
      126,
      "asset/image/monstra.png",
    ),
    MenuRecom(
      "เซ็ทน้ำจิ้ม2",
      126,
      "asset/image/monstra.png",
    ),
    MenuRecom(
      "สันคอหมูสไลด์",
      126,
      "asset/image/monstra.png",
    ),
    MenuRecom(
      "สามชั้นสไลด์",
      126,
      "asset/image/monstra.png",
    ),
    MenuRecom(
      "กุ้งแม่น้ำ",
      126,
      "asset/image/monstra.png",
    ),
    MenuRecom(
      "ซูชิ",
      126,
      "asset/image/monstra.png",
    ),
    MenuRecom(
      "ชุดเปิด",
      126,
      "asset/image/monstra.png",
    ),
  ];
}

class Filter {
  String name;

  Filter(this.name);
}

List<Filter> getFilterList() {
  return <Filter>[
    Filter("Best Match"),
    Filter("Highest Price"),
    Filter("Lowest Price"),
  ];
}
