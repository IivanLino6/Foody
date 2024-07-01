//DEFINICION DE ESTADOS

abstract class Resource<T> {
  Resource();
}

class Init extends Resource {
  //Contructor
  Init();
}

//Mediante este metodo se le indica al usuario que debe esperr mientras se ejecuta el metodo Login
class Loading extends Resource {
  //Contructor
  Loading();
}
//Recovery method
class Recovery extends Resource {
  Recovery();
}

//captura la data T que devuelve firebase cuando nos loggeamos de forma correcta
class Success<T> extends Resource<T> {
  final T data;
  //Contructor
  Success(this.data);
}

//cao¿ptura el valor de error
class Error<T> extends Resource<T> {
  final String error;
  //Contructor
  Error(this.error);
}
