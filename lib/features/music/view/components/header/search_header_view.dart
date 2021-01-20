import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:simple_streaming_app/core/view/theme/color_theme.dart';

class SearchHeaderView extends StatefulWidget implements PreferredSizeWidget{
  final SearchHeaderViewData viewData;

  SearchHeaderView({
    @required this.viewData
  });

  @override
  Size get preferredSize => Size.fromHeight(58);

  @override
  State<StatefulWidget> createState() {
    return _SearchHeaderView();
  }
}

class _SearchHeaderView extends State<SearchHeaderView> {
  TextEditingController controller;
  FocusNode focusNode = FocusNode();
  static final String _SEARCH_ARTIST_DEBOUNCER_KEY = '_search_artist_debouncer';

  @override
  void initState() {
    controller = TextEditingController(text: '');
    controller.addListener((){
      EasyDebounce.debounce(
        _SEARCH_ARTIST_DEBOUNCER_KEY,
        Duration(milliseconds: 500),
        () => this.handleOnSearch()
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      automaticallyImplyLeading: false,
      bottom: PreferredSize(
        preferredSize: widget.preferredSize,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            bottom: 8.0
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: ColorTheme.lightGrey
              ),
            )
          ),
          child: buildContainer(),
        ),
      ),
    );
  }

  Widget buildContainer(){
    return Container(
      child: Row(
        children: [
          Expanded(
            child: buildInputView(),
          ),
          SizedBox(
            height: 4.0,
          ),
          buildCloseButtonView(),
          SizedBox(
            height: 12.0,
          ),
        ],
      ),
    );
  }

  Widget buildCloseButtonView(){
    if(controller.text.length > 1){
      return GestureDetector(
        onTap: this.handleOnClearText,
        child: Container(
          color: ColorTheme.transparent,
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 8.0
          ),
          child: Icon(
            Icons.close,
            size: 20.0,
            color: ColorTheme.neutralDarkGrey
          ),
        ),
      );
    }

    return SizedBox();
  }

  Widget buildInputView(){
    return Container(
      margin: EdgeInsets.only(
        left: 8.0
      ),
      child: TextFormField(
        focusNode: focusNode,
        controller: this.controller,
        cursorColor: ColorTheme.neutralDarkGrey,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: ColorTheme.neutralDarkGrey
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: ColorTheme.neutralBlueGrey
          ),
          border: InputBorder.none,
          hintText: widget.viewData.placeholderText
        ),
      ),
    );
  }

  /// handlers
  void handleOnSearch(){
    if(widget.viewData.onSearch != null && this.controller.text.length >= 3){
      widget.viewData.onSearch(
        searchedText: this.controller.text
      );
    }
    setState(() {});
  }

  void handleOnClearText(){
    setState(() {
      controller.text = '';
    });
  }
}

class SearchHeaderViewData{
  String placeholderText;
  Function({ String searchedText }) onSearch;

  SearchHeaderViewData({
    @required this.placeholderText,
    @required this.onSearch
  });
}