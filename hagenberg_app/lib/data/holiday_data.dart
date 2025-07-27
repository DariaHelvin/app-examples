class Holiday {
  final String date;
  final String name;

  Holiday(this.date, this.name);
}

final List<Holiday> holidays = [
  Holiday('2024-01-01', 'New Year\'s Day'),
  Holiday('2024-01-06', 'Epiphany'),
  Holiday('2024-02-14', 'Ash Wednesday'),
  Holiday('2024-03-08', 'International Women\'s Day'),
  Holiday('2024-03-19', 'St. Joseph\'s Day'),
  Holiday('2024-03-24', 'Palm Sunday'),
  Holiday('2024-03-31', 'Easter Sunday'),
  Holiday('2024-04-01', 'Easter Monday'),
  Holiday('2024-05-01', 'State Holiday'),
  Holiday('2024-05-04', 'Florian\'s Day'),
  Holiday('2024-05-08', 'Victory Day'),
  Holiday('2024-05-09', 'Ascension Day'),
  Holiday('2024-05-12', 'Mother\'s Day'),
  Holiday('2024-05-19', 'Pentecost Sunday'),
  Holiday('2024-05-20', 'Whit Monday'),
  Holiday('2024-05-30', 'Corpus Christi'),
  Holiday('2024-06-01', 'Children\'s Day'),
  Holiday('2024-06-09', 'Father\'s Day'),
  Holiday('2024-06-19', 'Sacred Heart'),
  Holiday('2024-08-15', 'Assumption Day'),
  Holiday('2024-10-04', 'St. Francis of Assisi Day'),
  Holiday('2024-10-26', 'National Day'),
  Holiday('2024-11-01', 'All Saints\' Day'),
  Holiday('2024-11-02', 'All Souls\' Day'),
  Holiday('2024-12-08', 'Immaculate Conception Day'),
  Holiday('2024-12-25', 'Christmas Day'),
  Holiday('2024-12-26', 'St. Stephen\'s Day'),
  Holiday('2024-12-31', 'New Year\'s Eve'),


  //local events
  Holiday('2024-06-02 15:00', 'Exhibition "Wartberger Variety"'),
  Holiday('2024-06-06 20:00', 'Concert Mavi Phoenix and KGW3'),
  Holiday('2024-06-07', 'Long night of churches'),
  Holiday('2024-06-08 10:00', 'Parish Confirmation'),
  Holiday('2024-06-12 00:00', 'STIWA Jazz Forum'),
  Holiday('2024-06-15 00:00', 'Nature Friends Archery'),
  Holiday('2024-06-15 09:00', 'Archery at NATURFREUNDE HAGENBERG'),
  Holiday('2024-06-15 10:00', 'Parish Confirmation at PFARRE WARTBERG'),
  Holiday('2024-06-15 13:00', 'Plattlcup at FREIWILLIGE FEUERWEHR WARTBERG'),
  Holiday('2024-06-15 13:30', 'Pinselsafari24 at Wartberg ob der Aist'),
  Holiday('2024-06-15 13:38', 'Mühlviertel Classic Rally in Wartberg'),
  Holiday('2024-06-20 16:00', 'Sustainable IT at SOFTWAREPARK HAGENBERG'),
  Holiday('2024-06-20 19:30', 'Concert "Sounds of the Soul" in WARTBERG'),
  Holiday('2024-06-21 00:00', 'AISTFESTSPIELE - "Stories from the Vienna Woods"'),
  Holiday('2024-06-21 16:00', 'Children Climbing at TV NATURFREUNDE WARTBERG'),
  Holiday('2024-06-21 17:00', 'Children Theater at THEATER AM WARTBERG'),
  Holiday('2024-06-21 19:00', 'Sonnwendfeuer at UNTERWEITERSDORF'),
  Holiday('2024-06-22 10:00', 'Summer Festival at KAMERADSCHAFTSBUND WARTBERG'),
  Holiday('2024-06-22 15:00', 'Children Theater at THEATER AM WARTBERG'),
  Holiday('2024-06-22 16:00', 'Wild West in Hagenberg'),
  Holiday('2024-06-22 19:00', 'Cultural.Space.Church in WARTBERG'),
  Holiday('2024-06-23 08:00', 'Music and Costume Fair in WARTBERG'),
  Holiday('2024-06-23 17:00', 'Children Theater at THEATER AM WARTBERG'),
  Holiday('2024-06-27 20:00', 'BLUES NIGHT at RUF'),
  Holiday('2024-06-28 08:00', 'Good Mood Breakfast at WARTBERG'),
  Holiday('2024-06-28 16:00', 'Children Climbing at TV NATURFREUNDE WARTBERG'),
  Holiday('2024-06-29 18:00', 'Petersfeuer at UNTERWEITERSDORF'),
  Holiday('2024-06-30', 'Parish Festival at WARTBERG'),
];

void main() {
  DateTime today = DateTime.now();
  String todayFormatted = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

  Holiday? todayHoliday = holidays.firstWhere(
        (holiday) => holiday.date == todayFormatted,
    orElse: () => Holiday(todayFormatted, 'Just a regular day'),
  );

  print('Today is ${todayHoliday.date}: ${todayHoliday.name}');
}
