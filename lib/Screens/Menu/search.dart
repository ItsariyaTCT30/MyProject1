import 'package:flutter/material.dart';
import 'package:login_logout_app/Screens/Menu/herb2.dart';
import 'package:login_logout_app/Screens/components/Herb_Details_Screens.dart';
import 'package:login_logout_app/constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "กัญชา", "Sname": "Cannabis sativa L. subsp. indica"},
    {"id": 2, "name": "กระท่อม", "Sname": "Mitragyna speciosa (Roxb.) Korth."},
    {
      "id": 3,
      "name": "กระชาย ",
      "Sname": "Boesenbergia rotunda (Linn.) Mansf."
    },
    {"id": 4, "name": "ฝรั่ง", "Sname": "Psidium guajava Linn."},
    {
      "id": 5,
      "name": "กระทือ",
      "Sname": "Zingiber zerumbet (L.) Roscoe ex Sm."
    },
    {"id": 6, "name": "กระเทียม", "Sname": "Allium sativum L."},
    {"id": 7, "name": "กล้วยน้ำว้า", "Sname": "Musa ABB cv'. Kluai 'Namwa'"},
    {"id": 8, "name": "กะเพราแดง", "Sname": "Ocimum tenuiflorum L."},
    {"id": 9, "name": "กานพลู", "Sname": "Syzygium aromaticum (L.) "},
    {"id": 10, "name": "พลู", "Sname": "Piper betle  L."},
    {"id": 11, "name": "ขมิ้นชัน", "Sname": "Curcuma longa L."},
    {"id": 12, "name": "ขลู่", "Sname": "Pluchea indica (L.) "},
    {"id": 13, "name": "ขิง", "Sname": "Zingiber officinale Roscoe"},
    {"id": 14, "name": "ขี้เหล็ก", "Sname": "Senna siamea (Lam.)"},
    {"id": 15, "name": "ข่อย", "Sname": "Streblus asper Lour."},
    {"id": 16, "name": "ข่า", "Sname": "Alpinia galanga (L.)"},
    {"id": 17, "name": "คูน", "Sname": "Cassia fistula L."},
    {"id": 18, "name": "ชุมเห็ดเทศ", "Sname": "Cassia alata (L.)"},
    {"id": 19, "name": "ดีปลี", "Sname": "Piper retrofractum Vahl"},
    {"id": 20, "name": "ตะไคร้", "Sname": "Cymbopogon citratus (DC.)"},
    {"id": 21, "name": "ตำลึง", "Sname": "Coccinia grandis (L.)"},
    {"id": 22, "name": "ทองพันชั่ง ", "Sname": "Rhinacanthus nasutus (L.)"},
    {"id": 23, "name": "ทับทิม", "Sname": "Punica granatum L."},
    {"id": 24, "name": "กระเจี๊ยบแดง", "Sname": "Hibiscus sabdariffa L."},
    {"id": 25, "name": "น้อยหน่า", "Sname": "Annona squamosa L."},
    {"id": 26, "name": "บอระเพ็ด", "Sname": "Tinospora crispa"},
    {
      "id": 27,
      "name": "ฟ้าทะลายโจร",
      "Sname": "Andrographis paniculata ( Burm.f. ) "
    },
    {
      "id": 28,
      "name": "ไพล",
      "Sname": "Zingiber montanum (Koenig) Link ex Dietr."
    },
    {"id": 29, "name": "พริกไทย ", "Sname": "Piper nigrum L."},
    {
      "id": 30,
      "name": "แมงลัก",
      "Sname": "Ocimum basilicum L.f. var. citratum Back."
    },
    {"id": 31, "name": "แก้ว", "Sname": "Murraya paniculata (L.) Jack"},
    {"id": 32, "name": "เสลดพังพอน", "Sname": "Barleria lupulina Lindl."},
    {"id": 33, "name": "อ้อยแดง", "Sname": "Saccharum sinense Roxb."},
    {"id": 34, "name": "สับปะรด", "Sname": "Ananas comosus (L.) Merr."},
    {"id": 35, "name": "สะเดา", "Sname": "Azadirachta indica A. Juss."},
    {"id": 36, "name": "ว่านหางจระเข้", "Sname": "Aloe vera (L.) Burm.f."},
    {"id": 37, "name": "ว่านมหากาฬ", "Sname": "Gynura pseudochina (L.) DC."},
    {"id": 38, "name": "ยอ", "Sname": "Morinda citrifolia L."},
    {"id": 39, "name": "เปลือกมังคุด", "Sname": "Garcinia mangostana L."},
    {"id": 40, "name": "มะแว้งเครือ", "Sname": "Solanum trilobatum L."},
    {"id": 41, "name": "มะเกลือ", "Sname": "Diospyros mollis Griff."},
    {"id": 42, "name": "มะหาด", "Sname": "Artocarpus lacucha Roxb."},
    {
      "id": 43,
      "name": "มะระขี้นก",
      "Sname": "Momordica charantia L. f. charantia"
    },
    {
      "id": 44,
      "name": "มะนาว",
      "Sname": "Citrus x aurantiifolia (Christm.) Swingle"
    },
    {"id": 45, "name": "มะขาม", "Sname": "Tamarindus indica L."},
    {"id": 46, "name": " มะละกอ", "Sname": "Carica papaya L. "},
    {"id": 47, "name": "มะกอกน้ำ ", "Sname": "Elaeocarpus hygrophilus Kurz"},
    {"id": 48, "name": "บัวบก", "Sname": "Centella asiatica (L.) "},
    {
      "id": 49,
      "name": "แพงพวยฝรั่ง ",
      "Sname": "Catharanthus roseus (L.) G.Don"
    },
    {
      "id": 50,
      "name": "หญ้าปักกิ่ง",
      "Sname": "Murdannia loriformis (Hassk.) Rolla Rao et Kammathy"
    },
  ];
  List<Map<String, dynamic>> _foundUsers = [];

  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = _allUsers;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: gColor,
          // The search area here
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        /* Clear the search field */
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
              ),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(_foundUsers[index]["id"]),
                        color: Colors.amberAccent,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          onTap: () {
                            print(_foundUsers[index]['name']);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Herb1(
                                  ssname: _foundUsers[index]['name'],
                                ),
                              ),
                            );
                          },
                          leading: Text(
                            _foundUsers[index]["id"].toString(),
                            style: const TextStyle(fontSize: 24),
                          ),
                          title: Text(_foundUsers[index]['name']),
                          subtitle:
                              Text('${_foundUsers[index]["Sname"].toString()}'),
                        ),
                      ),
                    )
                  : const Text(
                      'ไม่พบผลลัพธ์',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
    //--------------------------------------------------------------
  }
}
