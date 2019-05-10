class Game {
  static state = {}
  static player = JSON.parse(sessionStorage.player)

  static connect = user => {
    const name = user.name;
    const colour = user.colour;
    return API.ConnectServer(name, colour)
      .then(resp => {
        const data = JSON.stringify(resp)
        sessionStorage.setItem("player", data)
        console.log(data)
        return resp
      });
  };
}
