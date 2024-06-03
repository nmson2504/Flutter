import 'package:flutter/material.dart';

class MyChip extends StatelessWidget {
  const MyChip({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('Chip Sample')),
        body: const FilterChip2(),
      ),
    );
  }
}

bool isFilterChipSelected = true;

class ChipDemo extends StatelessWidget {
  const ChipDemo({super.key});

  // const ChipDemo({super.key});

  void _handleFilterChipSelection(bool isSelected) {
    isFilterChipSelected = isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Wrap(
          spacing: 8.0,
          children: [
            Chip(
              label: Text('Chip Flutter'),
              backgroundColor: Colors.blue,
              labelStyle: TextStyle(color: Colors.white),
            ),
            Chip(
              label: Text('Chip Dart'),
              backgroundColor: Colors.green,
              labelStyle: TextStyle(color: Colors.white),
            ),
            Chip(
              label: Text('Chip Mobile'),
              backgroundColor: Colors.orange,
              labelStyle: TextStyle(color: Colors.white),
            ),
          ],
        ),
        const Divider(),
        Wrap(
          spacing: 8.0,
          children: [
            const Chip(
              avatar: Icon(Icons.star, color: Colors.yellow),
              label: Text('Favorite'),
              backgroundColor: Colors.blue,
              labelStyle: TextStyle(color: Colors.white),
            ),
            const Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text('S'),
              ),
              label: Text('Dart'),
              backgroundColor: Color.fromARGB(255, 154, 226, 241),
              labelStyle: TextStyle(color: Colors.white),
            ),
            Chip(
              avatar: Image.asset('assets/image3.jpg',
                  width: 24,
                  height:
                      24), // Thay thế 'assets/image.png' bằng đường dẫn thật
              label: const Text('Image'),
              backgroundColor: Colors.orange,
              labelStyle: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        const Divider(),
        // ChoiceChip
        Wrap(
          spacing: 8,
          children: [
            ChoiceChip(
                label: const Text('ChoiceChip Item '),
                selected: true,
                onSelected: (bool selected) {
                  null;
                }),
            ChoiceChip(
                label: const Text('ChoiceChip Item '),
                selected: false,
                onSelected: (bool selected) {
                  null;
                }),
            ChoiceChip(
              label: const Text('ChoiceChip Item '),
              selected: true,
              onSelected: (bool selected) {
                null;
              },
              elevation: 10,
            ),
          ],
        ),
        const Divider(),
        // InputChip
        Wrap(
          spacing: 8,
          children: [
            InputChip(
              label: const Text('InputChip 1'),
              selected: true,
              onSelected: (bool selected) {
                null;
              },
              onDeleted: () {
                null;
              },
            ),
            InputChip(
              label: const Text('InputChip 2'),
              selected: false,
              onSelected: (bool selected) {
                null;
              },
              onDeleted: () {
                null;
              },
            ),
          ],
        ),
        const Divider(),
        // FilterChip
        Wrap(spacing: 5.0, children: [
          FilterChip(
            label: const Text('FilerChip 1'),
            selected:
                false, // trạng thái selected/unselected (selected có icon check bên cạnh)
            onSelected:
                _handleFilterChipSelection, // giá trị truyền vào là 1 hàm kiểu: void ValueChanged<bool>?
          ),
          FilterChip(
              label: const Text('FilterChip 2'),
              selected: true,
              onSelected: (isFilterChipSelected) {}),
        ]),
        const Divider(),
        // ActionChip
        Wrap(spacing: 5.0, children: [
          ActionChip(
            avatar: const Icon(Icons.favorite_border),
            label: const Text('ActionChip - Save to favorites'),
            onPressed: () {
              (() {});
            },
          ),
          //
        ]),
      ],
    );
  }
}

// ChoiceChip
class ChoiceChip1 extends StatefulWidget {
  const ChoiceChip1({super.key});

  @override
  State<ChoiceChip1> createState() => _ChoiceChipState();
}

class _ChoiceChipState extends State<ChoiceChip1> {
  int? _value = 1;
  int _selectedChipIndex = 0;

  void _handleChipSelection(int index) {
    setState(() {
      _selectedChipIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Text('Choose an ChoiceChip item'),
          const SizedBox(height: 10.0),
          Wrap(
            spacing: 5,
            children: [
              ChoiceChip(
                label: const Text('Option 1'),
                selected: _selectedChipIndex == 0,
                onSelected: (isSelected) => _handleChipSelection(0),
                elevation: 5, // Đặt giá trị elevation
              ),
              const SizedBox(height: 16),
              ChoiceChip(
                label: const Text('Option 2'),
                selected: _selectedChipIndex == 1,
                onSelected: (isSelected) => _handleChipSelection(1),
                elevation: 5, // Đặt giá trị elevation
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const Text('Choose an ChoiceChip item - List<Widget>.generate'),
          Wrap(
            spacing: 5.0,
            children: List<Widget>.generate(
              3,
              (int index) {
                return ChoiceChip(
                  label: Text('Item $index'),
                  selected: _value == index, // truyền true/false theo điều kiện
                  onSelected: (bool selected) {
                    // nếu selected = true thì gọi setState() để thực thi các lệnh trong nó và build lại UI
                    setState(() {
                      _value = selected ? index : null;
                      // print('ChoiceChip item $_value');
                    });
                  },
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}

// ChoiceChip2
/* Trong ChoiceChip và các loại chip có thuộc tính selected, mặc định ChoiceChip được thiết kế với biểu tượng "checked" chồng lên biểu tượng avatar. Bạn không thể đơn giản tách biểu tượng avatar ra khỏi biểu tượng "checked" một cách dễ dàng mà không sửa đổi một số khía cạnh trong giao diện mặc định. 
Tuy nhiên, bạn có thể tạo một biểu tượng "checked" riêng và định vị nó bên phải hoặc bên trái của ChoiceChip thông qua cách tùy chỉnh ChoiceChip
 */

class ChoiceChip2 extends StatefulWidget {
  const ChoiceChip2({super.key});

  @override
  State<ChoiceChip2> createState() => _ChoiceChipDemoState2();
}

class _ChoiceChipDemoState2 extends State<ChoiceChip2> {
  int _selectedChipIndex = 0;

  void _handleChipSelection(int index) {
    setState(() {
      _selectedChipIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChoiceChip(
              label: const Text('Option 1'),
              selected: _selectedChipIndex == 0,
              onSelected: (isSelected) => _handleChipSelection(0),
            ),
            const SizedBox(width: 8),
            Icon(
              _selectedChipIndex == 0
                  ? Icons.check_circle
                  : Icons.check_circle_outline,
              color: _selectedChipIndex == 0 ? Colors.blue : Colors.grey,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChoiceChip(
              label: const Text('Option 2'),
              selected: _selectedChipIndex == 1,
              onSelected: (isSelected) => _handleChipSelection(1),
            ),
            const SizedBox(width: 8),
            Icon(
              _selectedChipIndex == 1
                  ? Icons.check_circle
                  : Icons.check_circle_outline,
              color: _selectedChipIndex == 1 ? Colors.blue : Colors.grey,
            ),
          ],
        ),
      ],
    );
  }
}

// InputChip

class InputChipExample extends StatefulWidget {
  const InputChipExample({super.key});

  @override
  State<InputChipExample> createState() => _InputChipExampleState();
}

class _InputChipExampleState extends State<InputChipExample> {
  int inputs = 3;
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 5.0,
            children: List<Widget>.generate(
              inputs,
              (int index) {
                return InputChip(
                  label: Text('Person ${index + 1}'),
//                   Whether or not this chip is selected.
// If [onSelected] is not null, this value will be used to determine if the select check mark will be shown or not.
// Must not be null. Defaults to false.
                  selected: selectedIndex == index,
                  onSelected: (bool selected) {
                    //Called when the chip should change between selected and de-selected states.
// When the chip is tapped, then the [onSelected] callback, if set, will be applied to !selected (see [selected]).
                    setState(() {
                      if (selectedIndex == index) {
                        // mới load lên selectedIndex = null nên ko có object nào checked
                        selectedIndex =
                            null; // nếu click trên object đang chọn (index đã chọn rồi) thì switch selectedIndex về null
                      } else {
                        selectedIndex = index;
                      }
                      print('selectedIndex: $selectedIndex');
                    });
                  },
                  onDeleted: () {
                    setState(() {
                      inputs = inputs - 1;
                    });
                  },
                );
              },
            ).toList(),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                inputs = 3;
              });
            },
            child: const Text('Reset'),
          )
        ],
      ),
    );
  }
}

// ActionChip

class ActionChip1 extends StatefulWidget {
  const ActionChip1({super.key});

  @override
  State<ActionChip1> createState() => _ActionChipExampleState();
}

class _ActionChipExampleState extends State<ActionChip1> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ActionChip(
        avatar: Icon(favorite ? Icons.favorite : Icons.favorite_border),
        label: const Text('Save to favorites'),
        onPressed: () {
          setState(() {
            favorite = !favorite;
          });
        },
      ),
    );
  }
}

class ActionChip2 extends StatelessWidget {
  const ActionChip2({super.key});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: const Text('Open Dialog'),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Dialog Title'),
              content: const Text('This is a dialog content.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

// FilterChip
/// Flutter code sample for [FilterChip].

enum ExerciseFilter { walking, running, cycling, hiking }

class FilterChip1 extends StatefulWidget {
  const FilterChip1({super.key});

  @override
  State<FilterChip1> createState() => _FilterChip1State();
}

class _FilterChip1State extends State<FilterChip1> {
  Set<ExerciseFilter> filters = <ExerciseFilter>{};

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Choose an exercise', style: textTheme.labelLarge),
          const SizedBox(height: 5.0),
          Wrap(
            spacing: 5.0,
            children: ExerciseFilter.values.map((ExerciseFilter exercise) {
              return FilterChip(
                label: Text(exercise.name),
                selected: filters.contains(exercise),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      filters.add(exercise);
                    } else {
                      filters.remove(exercise);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 10.0),
          Text(
            'Looking for: ${filters.map((ExerciseFilter e) => e.name).join(', ')}',
            style: textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}

// FilterChip2
List<String> _selectedChips = [];

class FilterChip2 extends StatefulWidget {
  const FilterChip2({super.key});

  @override
  State<FilterChip2> createState() => _FilterChip2State();
}

class _FilterChip2State extends State<FilterChip2> {
  void _handleChipSelection(String chipLabel) {
    setState(() {
      if (_selectedChips.contains(chipLabel)) {
        _selectedChips.remove(chipLabel);
      } else {
        _selectedChips.add(chipLabel);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: [
        for (String label in ['Tag 1', 'Tag 2', 'Tag 3'])
          FilterChip(
            label: Text(label),
            selected: _selectedChips.contains(label),
            onSelected: (isTS) => _handleChipSelection(
                label), //  onSelected: (isTS) - tham số tượng trưng
          ),
      ],
    );
  }
}
// FilterChip - CheckBox

class FilterAndCheckboxDemo extends StatefulWidget {
  const FilterAndCheckboxDemo({super.key});

  @override
  State<FilterAndCheckboxDemo> createState() => _FilterAndCheckboxDemoState();
}

List<String> _filterOptionsCheck = ['Option 1', 'Option 2', 'Option 3'];
List<bool> _selectedFiltersCheck = [false, false, false];

class _FilterAndCheckboxDemoState extends State<FilterAndCheckboxDemo> {
  bool _showChecked = false;

  void _handleFilterSelection(int index) {
    setState(() {
      _selectedFiltersCheck[index] = !_selectedFiltersCheck[index];
    });
  }

  void _handleCheckbox(bool value) {
    setState(() {
      _showChecked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Wrap(
          spacing: 8.0,
          children: [
            for (int i = 0; i < _filterOptionsCheck.length; i++)
              FilterChip(
                label: Text(_filterOptionsCheck[i]),
                selected: _selectedFiltersCheck[i],
                onSelected: (isBool) => _handleFilterSelection(
                    i), // isBool là tham số tượng trưng ko cần khai báo trước
              ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: _showChecked,
              // onChanged: tham số tượng trưng
              onChanged: (newValue) {
                _handleCheckbox(newValue!);
              },
            ),
            const Text('Only Show Checked Items'),
          ],
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _filterOptionsCheck.length,
          itemBuilder: (context, index) {
            if (!_showChecked || _selectedFiltersCheck[index]) {
              return ListTile(
                title: Text(_filterOptionsCheck[index]),
                trailing: _selectedFiltersCheck[index]
                    ? const Icon(Icons.check)
                    : const Icon(Icons.check_box_outline_blank),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}

// FilterBox - CheckBox 2 - update trạng thái đồng thời

class FilterChipAndCheckboxDemo2 extends StatefulWidget {
  const FilterChipAndCheckboxDemo2({super.key});

  @override
  State<FilterChipAndCheckboxDemo2> createState() =>
      _FilterChipAndCheckboxDemo2State();
}

class _FilterChipAndCheckboxDemo2State
    extends State<FilterChipAndCheckboxDemo2> {
  List<String> _options = ['FilterChip 1', 'FilterChip 2', 'FilterChip 3'];
  List<String> _options2 = ['CheckBox 1', 'CheckBox 2', 'CheckBox 3'];
  List<bool> _selectedItems = [false, false, false];

  void _handleSelection(int index, bool value) {
    setState(() {
      _selectedItems[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Wrap(
          spacing: 8.0,
          children: List.generate(_options.length, (index) {
            return FilterChip(
              label: Text(_options[index]),
              selected: _selectedItems[index],
              onSelected: (isSelected) => _handleSelection(index, isSelected),
            );
          }),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8.0,
          children: List.generate(_options2.length, (index) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: _selectedItems[index],
                  onChanged: (value) => _handleSelection(index, value!),
                ),
                Text(_options2[index]),
              ],
            );
          }),
        ),
      ],
    );
  }
}

// FilterBox - Switch

class FilterAndSwitchDemo extends StatefulWidget {
  const FilterAndSwitchDemo({super.key});

  @override
  State<FilterAndSwitchDemo> createState() => _FilterAndSwitchDemoState();
}

List<String> _filterOptions2 = ['Option 1', 'Option 2', 'Option 3'];
List<bool> _selectedFilters2 = [false, false, false];
bool _showChecked = false;

class _FilterAndSwitchDemoState extends State<FilterAndSwitchDemo> {
  bool _showSwitch = false;

  void _handleFilterSelection(int index) {
    setState(() {
      _selectedFilters2[index] = !_selectedFilters2[index];
    });
  }

  void _handleSwitch(bool value) {
    setState(() {
      _showSwitch = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Wrap(
          spacing: 8.0,
          children: [
            for (int i = 0; i < _filterOptions2.length; i++)
              FilterChip(
                label: Text(_filterOptions2[i]),
                selected: _selectedFilters2[i],
                onSelected: (_) => _handleFilterSelection(i),
              ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Switch(
              value: _showSwitch,
              onChanged: _handleSwitch,
            ),
            Text('Show Switch'),
          ],
        ),
        SizedBox(height: 16),
        if (_showSwitch)
          ListView.builder(
            shrinkWrap: true,
            itemCount: _filterOptions2.length,
            itemBuilder: (context, index) {
              if (!_showChecked || _selectedFilters2[index]) {
                return ListTile(
                  title: Text(_filterOptions2[index]),
                  trailing: _selectedFilters2[index]
                      ? Icon(Icons.check)
                      : Icon(Icons.check_box_outline_blank),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
      ],
    );
  }
}

// FilterBox - Switch 2

class FilterAndSwitchDemo3 extends StatefulWidget {
  const FilterAndSwitchDemo3({super.key});

  @override
  State<FilterAndSwitchDemo3> createState() => _FilterAndSwitchDemo3State();
}

List<String> _filterOptions3 = ['Option a', 'Option b', 'Option c'];
List<bool> _selectedFilters3 = [false, false, false];
List<bool> _showSwitches = [false, false, false];

class _FilterAndSwitchDemo3State extends State<FilterAndSwitchDemo3> {
  void _handleFilterSelection(int index) {
    setState(() {
      _selectedFilters3[index] = !_selectedFilters3[index];
    });
  }

  void _handleSwitch(int index, bool value) {
    setState(() {
      _showSwitches[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Wrap(
          spacing: 8.0,
          children: [
            for (int i = 0; i < _filterOptions3.length; i++)
              Column(
                children: [
                  FilterChip(
                    label: Text(_filterOptions3[i]),
                    selected: _selectedFilters3[i],
                    onSelected: (_) => _handleFilterSelection(i),
                  ),
                  SizedBox(height: 8),
                  Switch(
                    value: _showSwitches[i],
                    onChanged: (value) => _handleSwitch(i, value),
                  ),
                ],
              ),
          ],
        ),
        SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _filterOptions3.length,
          itemBuilder: (context, index) {
            if (_selectedFilters3[index] && _showSwitches[index]) {
              return ListTile(
                title: Text(_filterOptions3[index]),
                trailing: Icon(Icons.check),
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
