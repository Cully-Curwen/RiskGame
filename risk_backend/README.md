# README


# API Instructions
//DataType// is indication of needed data for the body
* BASE URL will be the servers host IP Address + Port (defualt - 3000)
  - example - 'http://IP_ADDRESS:PORT/'

<b>Universal</b>
* GET - GAME STATE
  - route 'state' or root
  - returns Game.STATE

* POST - NEXT PHASE
  - route 'next_phase'
  - body: {user_id: //int// }
  - returns Game.STATE

* POST - END TURN
  - route 'end_turn'
  - body: {user_id: //int// }
  - returns Game.STATE

<b>Game Setup Phase</b>
* GET - LOBBY
  - route 'lobby'
  - returns Game.STATE[:users]

* POST - CONNECT SERVER
  - route 'connect'
  - body: {user: {name: //string//, colour: //string// }}
  - returns players user object with id in

* POST - START GAME
  - route 'start_game'
  - body: {user_id: //int//, ready: //boolean//}
  - return Game.STATE + Setup.READY

* POST - DEPLOY ARMIES
  - route 'deploy_armies'
  - body: {user_id: //int//, territory_id: //int//, armies: //int//}
      - note; armies count must be 2 or less for Deploy Phase in the GAME Setup
  - return Game.STATE

<b>Reinforcement Phase</b>
* POST - REINFORCE
  - route 'reinforce'
  - body: {user_id: //int//, territory_id: //int//, armies: //int//}
  - return: Game.STATE

<b>Battle Phase</b>
* POST - ATTACK
  - route 'attack'
  - body: {user_id: //int//, base_territory_id: //int//, target_territory_id: //int//, armies: //int//}
  - return: Game.STATE + Battle.LOCK
  
* POST - CONTINUE ATTACK
  - route 'continue_attack'
  - body: {user_id: //int//, continue_attack: //boolean//}
  - return: Game.STATE + Battle.LOCK

<b>Redeployment Phase</b>
* POST - REDEPLOY
  - route 'redeploy'
  - body: {user_id: //int//, base_territory_id: //int//, target_territory_id: //int//, armies: //int//}
  - return: Game.STATE + Redeploy.LOCK