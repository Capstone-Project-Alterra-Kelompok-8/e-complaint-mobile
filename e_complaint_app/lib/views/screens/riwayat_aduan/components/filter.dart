import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  final Function(String) onCategorySelected;
  final String? initialCategory;

  const Filter(
      {Key? key, required this.onCategorySelected, this.initialCategory})
      : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Text(
                'Filter',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Divider(height: 1),
        Expanded(
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  'Pilih Kategori',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              RadioListTile<String>(
                title: Text('Kesehatan'),
                value: 'Kesehatan',
                groupValue: _selectedCategory,
                activeColor: Color.fromARGB(255, 255, 183, 0),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                  widget.onCategorySelected(value!);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: Text('Pendidikan'),
                value: 'Pendidikan',
                groupValue: _selectedCategory,
                activeColor: Color.fromARGB(255, 255, 183, 0),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                  widget.onCategorySelected(value!);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: Text('Kependudukan'),
                value: 'Kependudukan',
                groupValue: _selectedCategory,
                activeColor: Color.fromARGB(255, 255, 183, 0),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                  widget.onCategorySelected(value!);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: Text('Keamanan'),
                value: 'Keamanan',
                groupValue: _selectedCategory,
                activeColor: Color.fromARGB(255, 255, 183, 0),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                  widget.onCategorySelected(value!);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: Text('Infrastruktur'),
                value: 'Infrastruktur',
                groupValue: _selectedCategory,
                activeColor: Color.fromARGB(255, 255, 183, 0),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                  widget.onCategorySelected(value!);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: Text('Transportasi'),
                value: 'Transportasi',
                groupValue: _selectedCategory,
                activeColor: Color.fromARGB(255, 255, 183, 0),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                  widget.onCategorySelected(value!);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: Text('Sosial'),
                value: 'Sosial',
                groupValue: _selectedCategory,
                activeColor: Color.fromARGB(255, 255, 183, 0),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                  widget.onCategorySelected(value!);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
