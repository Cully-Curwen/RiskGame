# README


# API Instructions
//DataType// is indication of needed data for the body
* BASE URL will be the servers host IP Address ]
    - example - 'http://IP_ADDRESS/'

<b>Universal</b>
*  GET - GAME STATE
    - route 'state'

* POST - END TURN
  - route 'endturn'
  - body: {user_id: //int// }

<b>Game Setup Phase</b>
* POST - CONNECT SERVER
  - route 'connect'
  - body: {user: {name: //string//, colour: //string// }}

* POST - START GAME
  - route 'start_game'
  - body: {user_id: //int// }

* POST - DEPLOY ARMIES
  - route 'deploy_armies'
  - body: {user_id: //int//, territory_id: //id//, armies: //int//}
      - note; armies count must be 2 or less for Deploy Phase in the GAME Setup

<b>Reinforcement Phase</b>
<br>
<b>Battle Phase</b>
<br>
<b>Redeployment Phase</b>