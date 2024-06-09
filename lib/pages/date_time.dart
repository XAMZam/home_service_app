import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DateAndTimePage extends StatefulWidget {
  const DateAndTimePage({Key? key}) : super(key: key);

  @override
  _DateAndTimePageState createState() => _DateAndTimePageState();
}

class _DateAndTimePageState extends State<DateAndTimePage> {
  int _selectedDayIndex = 1;
  int _selectedRepeatIndex = 0;
  String _selectedTime = '13:30';
  List<int> _selectedExtraServices = [];

  final ItemScrollController _itemScrollController = ItemScrollController();

  final List<Map<String, dynamic>> _daysOfMonth = List.generate(31, (index) {
    return {
      'day': index + 1,
      'weekday': ['Fri', 'Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu'][index % 7]
    };
  });

  final List<String> _timeSlots = [
    for (int i = 1; i <= 23; i += 1) ...[
      '${i.toString().padLeft(2, '0')}:00',
      '${i.toString().padLeft(2, '0')}:30'
    ]
  ];

  final List<String> _repeatOptions = ['No repeat', 'Daily', 'Weekly', 'Monthly'];

  final List<Map<String, String>> _additionalServices = [
    {'name': 'Washing', 'iconUrl': 'https://img.icons8.com/office/2x/washing-machine.png', 'price': '10'},
    {'name': 'Fridge', 'iconUrl': 'https://img.icons8.com/cotton/2x/fridge.png', 'price': '8'},
    {'name': 'Oven', 'iconUrl': 'https://img.icons8.com/external-becris-lineal-color-becris/2x/external-oven-kitchen-cooking-becris-lineal-color-becris.png', 'price': '8'},
    {'name': 'Vehicle', 'iconUrl': 'https://img.icons8.com/external-vitaliy-gorbachev-blue-vitaly-gorbachev/2x/external-bycicle-carnival-vitaliy-gorbachev-blue-vitaly-gorbachev.png', 'price': '20'},
    {'name': 'Windows', 'iconUrl': 'https://img.icons8.com/external-kiranshastry-lineal-color-kiranshastry/2x/external-window-interiors-kiranshastry-lineal-color-kiranshastry-1.png', 'price': '20'},
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      _itemScrollController.scrollTo(
        index: 24,
        duration: Duration(seconds: 3),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/home');
        },
        child: Icon(Icons.arrow_forward),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 120.0, horizontal: 20.0),
                child: Text(
                  'Choose Date and Time',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Row(
                children: [
                  Text("June 2024", style: TextStyle(fontSize: 18)),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_drop_down_circle, color: Colors.grey.shade700),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildDaySelector(),
              SizedBox(height: 20),
              _buildTimeSelector(),
              SizedBox(height: 40),
              Text("Repeat", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              _buildRepeatSelector(),
              SizedBox(height: 40),
              Text("Additional Services", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              _buildAdditionalServicesSelector(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDaySelector() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(width: 1.5, color: Colors.grey.shade200),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _daysOfMonth.length,
        itemBuilder: (BuildContext context, int index) {
          final dayInfo = _daysOfMonth[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDayIndex = dayInfo['day'];
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 62,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: _selectedDayIndex == dayInfo['day'] ? Colors.blue.shade100.withOpacity(0.5) : Colors.transparent,
                border: Border.all(
                  color: _selectedDayIndex == dayInfo['day'] ? Colors.blue : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(dayInfo['day'].toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(dayInfo['weekday'], style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeSelector() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(width: 1.5, color: Colors.grey.shade200),
      ),
      child: ScrollablePositionedList.builder(
        itemScrollController: _itemScrollController,
        scrollDirection: Axis.horizontal,
        itemCount: _timeSlots.length,
        itemBuilder: (BuildContext context, int index) {
          final timeSlot = _timeSlots[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTime = timeSlot;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: _selectedTime == timeSlot ? Colors.orange.shade100.withOpacity(0.5) : Colors.transparent,
                border: Border.all(
                  color: _selectedTime == timeSlot ? Colors.orange : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(timeSlot, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRepeatSelector() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _repeatOptions.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedRepeatIndex = index;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: _selectedRepeatIndex == index ? Colors.blue.shade400 : Colors.grey.shade100,
              ),
              margin: EdgeInsets.only(right: 20),
              child: Center(
                child: Text(
                  _repeatOptions[index],
                  style: TextStyle(fontSize: 18, color: _selectedRepeatIndex == index ? Colors.white : Colors.grey.shade800),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAdditionalServicesSelector() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _additionalServices.length,
        itemBuilder: (context, index) {
          final service = _additionalServices[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                if (_selectedExtraServices.contains(index)) {
                  _selectedExtraServices.remove(index);
                } else {
                  _selectedExtraServices.add(index);
                }
              });
            },
            child: Container(
              width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: _selectedExtraServices.contains(index) ? Colors.blue.shade400 : Colors.transparent,
              ),
              margin: EdgeInsets.only(right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(service['iconUrl'], height: 40),
                  SizedBox(height: 10),
                  Text(
                    service['name'],
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: _selectedExtraServices.contains(index) ? Colors.white : Colors.grey.shade800),
                  ),
                  SizedBox(height: 5),
                  Text("+${service['price']}\$", style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
