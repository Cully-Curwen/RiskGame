class Game {
  static state = {}
  static player = sessionStorage.getItem("player")

  static connect = user => {
    const name = user.name;
    const colour = user.colour;
    return API.ConnectServer(name, colour)
      .then(resp => sessionStorage.setItem(resp));
  };
}
