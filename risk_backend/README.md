# README


# API Instructions
//DataType// is indication of needed data for the body
* BASE URL will be the servers host IP Address ]
  - example - 'http://IP_ADDRESS/'

<b>Universal</b>
* GET - GAME STATE
  - route 'state'
  - returns Game.STATE

* POST - END TURN
  - route 'endturn'
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
  - return Game.LIVE + Setup.READY

* POST - DEPLOY ARMIES
  - route 'deploy_armies'
  - body: {user_id: //int//, territory_id: //id//, armies: //int//}
      - note; armies count must be 2 or less for Deploy Phase in the GAME Setup
  - return Game.STATE + Setup.STATE

<b>Reinforcement Phase</b>
<br>
<b>Battle Phase</b>
<br>
<b>Redeployment Phase</b>