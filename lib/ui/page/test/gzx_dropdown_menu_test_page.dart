import 'package:flutter/material.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';

class SortCondition {
  String name;
  bool isSelected;

  SortCondition({this.name, this.isSelected});
}

class GZXDropDownMenuPage extends StatefulWidget {
  @override
  _GZXDropDownMenuPageState createState() => _GZXDropDownMenuPageState();
}

class _GZXDropDownMenuPageState extends State<GZXDropDownMenuPage> {
  List<String> _dropDownHeaderItemStrings = ['全城', '品牌', '距离', '筛选'];
  List<SortCondition> _brandSortConditions = [];
  List<SortCondition> _distanceSortConditions = [];
  SortCondition _selectBrandSortConditions;
  SortCondition _selectDistanceSortConditions;
  GZXDropdownMenuController _dropdownMenuController = GZXDropdownMenuController();

  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey _stackKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _brandSortConditions.add(SortCondition(name: '全部', isSelected: true));
    _brandSortConditions.add(SortCondition(name: '金逸影城', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '中影国际城我比较长，你看我选择后是怎么显示的', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '星美国际城', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '博纳国际城', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '大地影院', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '嘉禾影城', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '太平洋影城', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城1', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城2', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城3', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城4', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城5', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城6', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城7', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城8', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城9', isSelected: false));
    _selectBrandSortConditions = _brandSortConditions[0];

    _distanceSortConditions.add(SortCondition(name: '距离近', isSelected:  true));
    _distanceSortConditions.add(SortCondition(name: '距离远', isSelected:  false));
    _selectDistanceSortConditions = _distanceSortConditions[0];
  }

  @override
  Widget build(BuildContext context) {
    print("GZXDropDownMenu build....");

    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
        ),
      ),
      backgroundColor: Colors.white,
      endDrawer: Container(
        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4, top: 0),
        color: Colors.white,
      ),
      body: Stack(
        key: _stackKey,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 44,
                color: Theme.of(context).primaryColor,
                alignment: Alignment.center,
                child: Text(
                  '拉下框',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white
                  ),
                ),
              ),
              GZXDropDownHeader(
                items: [
                  GZXDropDownHeaderItem(_dropDownHeaderItemStrings[0]),
                  GZXDropDownHeaderItem(_dropDownHeaderItemStrings[1]),
                  GZXDropDownHeaderItem(_dropDownHeaderItemStrings[2]),
                  GZXDropDownHeaderItem(_dropDownHeaderItemStrings[3]),
                ],
                stackKey: _stackKey,
                controller: _dropdownMenuController,
                onItemTap: (index) {
                  if(index == 3) {
                    _dropdownMenuController.hide();
                    _scaffoldKey.currentState.openEndDrawer();
                  }
                },
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: 100,
                  separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {},
                      leading: Text('test$index'),
                    );
                  },
                ),
              ),
            ],
          ),
          GZXDropDownMenu(
            controller: _dropdownMenuController,
            menus: [
              GZXDropdownMenuBuilder(
                dropDownHeight: 40 * 0.8,
                dropDownWidget: _buildQuanChengWidget((selectValue) {
                  _dropDownHeaderItemStrings[0] = selectValue;
                  _dropdownMenuController.hide();
                  setState(() {});
                })
              ),
              GZXDropdownMenuBuilder(
                dropDownHeight: 40 * 0.8,
                dropDownWidget: _buildConditionListWidget(_brandSortConditions, (value) {
                  _selectBrandSortConditions = value;
                  _dropDownHeaderItemStrings[1] = _selectBrandSortConditions.name == '全部' ? '品牌' : _selectBrandSortConditions.name;
                  _dropdownMenuController.hide();
                  setState(() {});
                }),
              ),
              GZXDropdownMenuBuilder(
                dropDownHeight: 40.0 * _distanceSortConditions.length,
                dropDownWidget: _buildConditionListWidget(_distanceSortConditions, (value) {
                  _selectDistanceSortConditions = value;
                  _dropDownHeaderItemStrings[2] = _selectDistanceSortConditions.name;
                  _dropdownMenuController.hide();
                  setState(() {});
                })
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 下拉的菜单
  int _selectTempFirstLevelIndex = 0;
  int _selectFirstLevelIndex = 0;

  int _selectSecondLevelIndex = -1;

  _buildQuanChengWidget(void itemOnTap(String selectValue)) {
    List firstLevels = new List<String>.generate(15, (int index) {
      if(index == 0) {
        return '全部';
      }
      return '$index区';
    });

    List secondLeveles = new List<String>.generate(15, (int index) {
      if(index == 0) {
        return '全部';
      }
      return '$_selectTempFirstLevelIndex$index街道办';
    });

    return Row(
      children: <Widget>[
        Container(
          width: 100,
          child: ListView(
            children: firstLevels.map((item) {
              int index = firstLevels.indexOf(item);
              return GestureDetector(
                onTap: () {
                  _selectTempFirstLevelIndex = index;

                  if(_selectTempFirstLevelIndex == 0) {
                    itemOnTap('全部');
                    return ;
                  }
                  setState(() {});
                },
                child: Container(
                  height: 40,
                  color: _selectTempFirstLevelIndex == index ? Colors.grey[200] : Colors.white,
                  alignment: Alignment.center,
                  child: _selectTempFirstLevelIndex == index
                    ? Text('$item', style: TextStyle(color: Colors.red))
                    : Text('$item'),
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.grey[200],
            child: _selectTempFirstLevelIndex == 0
              ? Container()
              : ListView(
                children: secondLeveles.map((item) {
                  int index = secondLeveles.indexOf(item);
                  return GestureDetector(
                    onTap: () {
                      _selectSecondLevelIndex = index;
                      _selectFirstLevelIndex = _selectTempFirstLevelIndex;
                      if(_selectSecondLevelIndex == 0) {
                        itemOnTap(firstLevels[_selectFirstLevelIndex]);
                      } else {
                        itemOnTap(item);
                      }
                    },
                    child: Container(
                      height: 40.0,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 20.0),
                          _selectFirstLevelIndex == _selectTempFirstLevelIndex && _selectSecondLevelIndex == index
                          ? Text('$item', style: TextStyle(color: Colors.red))
                          : Text('$item'),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
          ),
        ),
      ],
    );
  }

  _buildConditionListWidget(items, void itemOnTap(SortCondition)){
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0),
      itemBuilder: (BuildContext context, int index) {
        SortCondition goodsConditions = items[index];
        return GestureDetector(
          onTap: () {
            for(var value in items) {
              value.isSelected = false;
            }
            goodsConditions.isSelected = true;
            itemOnTap(goodsConditions);
          },
          child: Container(
            height: 40.0,
            child: Row(
              children: <Widget>[
                SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    goodsConditions.name,
                    style: TextStyle(color: goodsConditions.isSelected ? Colors.red : Colors.black),
                  ),
                ),
                goodsConditions.isSelected ? Icon(Icons.check, color: Theme.of(context).primaryColor,size: 16) : SizedBox(),
                SizedBox(width: 16.0)
              ],
            ),
          ),
        );
      },
    );
  }
}
