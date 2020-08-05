import 'package:flutter/material.dart';

void main() {
  runApp(GridViewApp());
}

class GridOptions {
  GridOptions(this._crossAxisCountPotrait, this._crossAxisCountLandscape,
      this._childAspectRatio, this._padding, this._spacing);

  GridOptions.copyOf(GridOptions gridOptions) {
    this._crossAxisCountPotrait = gridOptions._crossAxisCountPotrait;
    this._crossAxisCountLandscape = gridOptions._crossAxisCountLandscape;
    this._childAspectRatio = gridOptions._childAspectRatio;
    this._padding = gridOptions._padding;
    this._spacing = gridOptions._spacing;
  }

  double _childAspectRatio;
  int _crossAxisCountLandscape;
  int _crossAxisCountPotrait;
  double _padding;
  double _spacing;

  @override
  String toString() {
    return 'GridOtions{_crossAxisCountPotrait: $_crossAxisCountPotrait, _crossAxisCountLandscape: $_crossAxisCountLandscape, _childAspectRatio: $_childAspectRatio, _padding: $_padding, _spacing: $_spacing}';
  }
}

class GridViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  _HomeWidgetState() : super() {
    for (int i = 200; i < 1000; i += 100) {
      String imageUrl = "http://placekitten.com/200/$i";
      _kittenTiles.add(GridTile(
          header: GridTileBar(
            title: Text(
              'Cats',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  backgroundColor: Color.fromRGBO(0, 0, 0, 0.5)),
            ),
          ),
          footer: GridTileBar(
            title: Text(
              'How cute',
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          child: Image.network(imageUrl)));
    }
  }

  GridOptions _gridOptions = GridOptions(2, 3, 1.0, 4.0, 4.0);
  List<Widget> _kittenTiles = [];

  void _showGridOptionsDialog() async {
    GridOptions gridOptions = await showDialog<GridOptions>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: CustomDialogWidget(this._gridOptions),
          );
        });
    if (gridOptions != null) {
      setState(() {
        _gridOptions = gridOptions;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('GridView'),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return GridView.count(
              crossAxisCount: (orientation == Orientation.portrait)
                  ? _gridOptions._crossAxisCountPotrait
                  : _gridOptions._crossAxisCountLandscape,
              childAspectRatio: _gridOptions._childAspectRatio,
              padding: EdgeInsets.all(_gridOptions._padding),
              mainAxisSpacing: _gridOptions._spacing,
              crossAxisSpacing: _gridOptions._spacing,
              children: _kittenTiles,
            );
          },
        ),
        bottomNavigationBar: Container(
          child: Text(_gridOptions.toString()),
          padding: EdgeInsets.all(20),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showGridOptionsDialog,
          tooltip: 'Try more grid options',
          child: Icon(Icons.refresh),
        ));
  }
}

class CustomDialogWidget extends StatefulWidget {
  CustomDialogWidget(this._gridOptions) : super();

  GridOptions _gridOptions;

  @override
  _CustomDialogWidgetState createState() =>
      _CustomDialogWidgetState(GridOptions.copyOf(this._gridOptions));
}

class _CustomDialogWidgetState extends State<CustomDialogWidget> {
  _CustomDialogWidgetState(this._gridOptions);

  GridOptions _gridOptions;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            'Grid Options',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Text('Cross Axis Count Portrait'),
              Spacer(),
              DropdownButton<int>(
                value: _gridOptions._crossAxisCountPotrait,
                items: <int>[2, 3, 4, 5, 6].map((value) {
                  return new DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _gridOptions._crossAxisCountPotrait = value;
                  });
                },
              ),
              Spacer(),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Text('Cross Axis Count Landscape'),
              Spacer(),
              DropdownButton<int>(
                value: _gridOptions._crossAxisCountLandscape,
                items: <int>[2, 3, 4, 5, 6].map((value) {
                  return new DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _gridOptions._crossAxisCountLandscape = value;
                  });
                },
              ),
              Spacer(),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Text('Aspect Ratio'),
              Spacer(),
              DropdownButton<double>(
                value: _gridOptions._childAspectRatio,
                items: <double>[1.0, 1.5, 2.0, 2.5].map((value) {
                  return DropdownMenuItem<double>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _gridOptions._childAspectRatio = value;
                  });
                },
              ),
              Spacer(),              
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Text('Padding'),
              Spacer(),
              DropdownButton<double>(
                value: _gridOptions._padding,
                items: <double>[1.0, 2.0, 4.0,8.0,16.0,32.0].map((value) {
                  return DropdownMenuItem<double>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _gridOptions._padding = value;
                  });
                },
              ),
              Spacer(),              
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Text('Spacing'),
              Spacer(),
              DropdownButton<double>(
                value: _gridOptions._spacing,
                items: <double>[1.0, 2.0, 4.0, 8.0,32.0].map((value) {
                  return DropdownMenuItem<double>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _gridOptions._spacing = value;
                  });
                },
              ),
              Spacer(),              
            ],
          ),
          FlatButton(
            onPressed: ()=> Navigator.pop(context, _gridOptions), 
            child: Text('Apply')),
        ],
      ),
    );
  }
}
