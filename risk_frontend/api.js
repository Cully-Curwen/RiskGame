class API {
  static IP_ADDRESS = "localhost";
  static PORT = "3000";
  static BaseURL = `http://${this.IP_ADDRESS}:${this.PORT}/`;

  // API functions
  // Universal
  static GameState = () => this.get(this.BaseURL + "state")
  static NextPhase = user_id => this.post(this.BaseURL + "next_phase", {user_id})
  static EndTurn = user_id => this.post(this.BaseURL + "end_turn", {user_id})
  // Game Setup Phase
  static Lobby = () => this.get(this.BaseURL + "lobby")
  static ConnectServer = (name, colour) => this.post(this.BaseURL + "connect", {name, colour})
  static StartGame = (user_id, ready) => this.post(this.BaseURL + "start_game", {user_id, ready})
  static DeployArmies = (user_id, territory_id, armies) => this.post(this.BaseURL + "deploy_armies", {user_id, territory_id, armies})
  // Reinforcement Phase
  static Reinforce = (user_id, territory_id, armies) => this.post(this.BaseURL + "reinforce", {user_id, territory_id, armies})
  // Battle Phase
  static Attack = (user_id, base_territory_id, target_territory_id, armies) => this.post(this.BaseURL + "attack", {user_id, base_territory_id, target_territory_id, armies})
  static ContinueAttack = (user_id, continue_attack) => this.post(this.BaseURL + "continue_attack", {user_id, continue_attack})
  // Redeployment Phase
  static Redeploy = (user_id, base_territory_id, target_territory_id, armies) => this.post(this.BaseURL + "redeploy", {user_id, base_territory_id, target_territory_id, armies})

  // fetch methods
  static get = (url) => {
    return fetch(url)
      .then(resp => resp.json)
  };

  static post = (url, body) => {
    const configObj = {
      method: "POST",
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify(body)
    };
    return fetch(url, configObj)
      .then(resp => resp.json)
  };

};