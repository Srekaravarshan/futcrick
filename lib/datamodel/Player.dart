
class Player<T> {

  int _id;
  String _name;
  DateTime _dateOfBirth;
  int _age;
  String _nationality;
  String _position;
  String _bio;

  Player(this._id, this._name, this._dateOfBirth, this._nationality,
      this._position, this._bio){
    this._age = DateTime.now().year - _dateOfBirth.year;
  }

  String get bio => _bio;

  String get position => _position;

  String get nationality => _nationality;

  int get age => _age;

  DateTime get dateOfBirth => _dateOfBirth;

  String get name => _name;

  int get id => _id;

}

class ChennainFC extends Player{
  ChennainFC(int id, String name, DateTime dateOfBirth, String nationality, String position, String bio) : super(id, name, dateOfBirth, nationality, position, bio);
}

class Hydrabad extends Player{
  Hydrabad(int id, String name, DateTime dateOfBirth, String nationality, String position, String bio) : super(id, name, dateOfBirth, nationality, position, bio);
}


class Main{

  List<Player<ChennainFC>> chennainFC = [];
  List<Player> bengaluru = [];
  List<Player> goa = [];
  List<Player> mumbaiCity = [];
  List<Player> keralaBlasters = [];
  List<Player> odisha = [];
  List<Player> jamshedpurFC = [];
  List<Player> scEastBengal = [];
  List<Player> hyderabad = [];
  List<Player> atkMohunBagan = [];

  void main(){
    chennainFC.add(new Player<ChennainFC>(1, "Player name", DateTime.utc(1986, DateTime.october, 3),"Nationality", "Position in full form", "bio"));
    chennainFC.add(new Player<ChennainFC>(2, "Player name", DateTime.utc(1986, DateTime.october, 3),"Nationality", "Position in full form", "bio"));
    chennainFC.add(new Player<ChennainFC>(3, "Player name", DateTime.utc(1986, DateTime.october, 3),"Nationality", "Position in full form", "bio"));

    bengaluru.add(new Player(4, "Player name", DateTime.utc(1986, DateTime.october, 3),"Nationality", "Position in full form", "bio"));
    bengaluru.add(new Player(5, "Player name", DateTime.utc(1986, DateTime.october, 3),"Nationality", "Position in full form", "bio"));
    bengaluru.add(new Player(6, "Player name", DateTime.utc(1986, DateTime.october, 3),"Nationality", "Position in full form", "bio"));
  }
}
