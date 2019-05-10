const info1 = document.querySelector("#item1")
const info2 = document.querySelector("#item2")
const info3 = document.querySelector("#item3")
const info4 = document.querySelector("#item4")
const info5 = document.querySelector("#item5")
const info6 = document.querySelector("#item6")

const battle1 = document.querySelector("#battle1")
const battle2 = document.querySelector("#battle2")
const battle3 = document.querySelector("#battle3")
const battle4 = document.querySelector("#battle4")

// let session = {name: "Greg", colour: "Blue", id: 1}
let session = {name: "Bob", colour: "Red", id: 2}

//sidebar function
function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
}
function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}



//show tile on side button
const board_logic = tile_id => {
  if (Game.state.currentPhase == "Deployment"){
    if(Game.state.currentPlayer.id == session.id) {
      deployment_phase(tile_id)
    }else{
      info1.innerText = `${Game.state.users[0].name}: ${Game.state.territories.map(tile => tile.owner.id == Game.state.users[0].id).filter(Boolean).length} controlled territories`
      info2.innerText = `${Game.state.users[1].name}: ${Game.state.territories.map(tile => tile.owner.id == Game.state.users[1].id).filter(Boolean).length} controlled territories  ${Game.state.users[2].name}: ${Game.state.territories.map(tile => tile.owner.id == Game.state.users[2].id).filter(Boolean).length} controlled territories`
      info3.innerText = `-------------------------------`
      info4.innerText = `Tile: ${mapObject.select(tile_id).name}`
      info5.innerText = `Controlled by: ${Game.state.territories.find(tile => tile.id == tile_id).owner.name}`
      info6.innerText = `Armies: ${Game.state.territories.find(tile => tile.id == tile_id).armies}`
    }}else if(Game.state.currentPhase == "Attack"){
      render_battle()
  }else if(Game.state.currentPhase == "Movement"){
    if(Game.state.currentPlayer.id == session.id){
      movement_phase(tile_id)
  }else
    info1.innerText = `${Game.state.users[0].name}: ${Game.state.territories.map(tile => tile.owner.id == Game.state.users[0].id).filter(Boolean).length} controlled territories`
    info2.innerText = `${Game.state.users[1].name}: ${Game.state.territories.map(tile => tile.owner.id == Game.state.users[1].id).filter(Boolean).length} controlled territories`
    info3.innerText = `--------------------------------------`
    info4.innerText = `Tile: ${mapObject.select(tile_id).name}`
    info5.innerText = `Controlled by: ${Game.state.territories.find(tile => tile.id == tile_id).owner.name}`
    info6.innerText = `Armies: ${Game.state.territories.find(tile => tile.id == tile_id).armies}`
  }
}

//create user
const create_new_user = () => {
const body = document.querySelector("Body")
const form_container = document.createElement("div")
form_container.class = "modal"
form_container.innerHTML = `
  <!-- Modal content -->
    <div class="modal-content">
      <h1 id="h1">NEW PLAYER FORM<h1>
      <form onsubmit='connectForm()' class="new-user-form">
        <input type="text" name="username" value="" placeholder="Username here">
        <select name="color">
           <option value="blue">Blue</option>
           <option value="red">Red</option>
           <option value="green">Green</option>
           <option value="pink">Pink</option>
         </select>
         <input type="submit">
      </form>
    </div>
    `
    body.append(form_container)
    // const submit_button = document.getElementById("close")
     // submit_button.addEventListener("submit", () => {
     // event.preventDefault()
     // const form = document.querySelector(".new-user-form")

}

//create Object with new user
const connectForm = () => {
  event.preventDefault()
  const form = event.target
  console.log(event)
  const username = {
    name : form.username.value,
    colour : form.color.value
  }
  session = username
  connect(username)
}

//SERVER POST Request
const connect = new_user => {
  fetch(IP_ADDRESS+"connect", {
    method: "POST",
    headers: {'Content-Type': 'application/json',
  },
    body: JSON.stringify({user: new_user})
  })
    .then(resp => resp.json())
      .then(new_profile => {
        session = new_profile
        const drop_this = document.querySelector(".modal-content")
        drop_this.remove()
      })
}

//DEPLOYEMENT PHASE
const deployment_phase = tile_id => {
  const button_deployment = document.createElement("button")
  button_deployment.class = "button_deployment"
  button_deployment.innerText = `Submit and Proceed to Attack Turn`

  //////////////////////////////////////////
  info1.innerText = `Reinforcement left`
  info2.innerText = `=============================`
  info3.innerText = `Deployement phase, select a tile to deploy trops on`
  info4.innerText = `Tile: ${mapObject.select(tile_id).name}`
  info5.innerText = `Controlled by: ${Game.state.territories.find(tile => tile.id == tile_id).owner.name}`
  info6.innerText = `Armies: ${Game.state.territories.find(tile => tile.id == tile_id).armies}`
///////////////////////////////////////

//if the user select an owned territory on deployment phase
  if(Game.state.territories.find(tile => tile.id == tile_id).owner.id == session.id) {
    const div = document.createElement("div")
    const h1 = document.createElement("h1")
    const increase_button = document.createElement("button")
    const decrease_button = document.createElement("button")
    const submit_reinforcement_button = document.createElement("button")
    const counter = document.createElement("div")

    submit_reinforcement_button.innerText = `Submit reinforcements on ${mapObject.select(tile_id).name}`
    counter.innerHTML = `<input type="text" id="counter-box" value="0">`
    increase_button.innerText = `+`
    decrease_button.innerText = `-`

    increase_button.addEventListener("click", () =>{
      let box_value = document.getElementById("counter-box")
      let old_value = parseInt(box_value.value)
      if (box_value.value = "2"){
        box_value.value = "2"
      }else{
      box_value.value = (old_value+=1).toString()
    }})

    decrease_button.addEventListener("click", () =>{
      let box_value = document.getElementById("counter-box")
      if (box_value.value = "0"){
        box_value.value = "0"
      }else{
      let old_value = parseInt(box_value.value)
      box_value.value = old_value-=1
      }
    })

    submit_reinforcement_button.addEventListener("click", () => {
      let box_value = document.getElementById("counter-box")
      fetch(IP_ADDRESS+'deploy_armies', {
        method: "POST",
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({user_id: session.id, territory_id: tile_id, armies: parseInt(box_value.value)})
      }).then(resp => resp.json())
          .then(resp => {
            Game.state = resp
            render_headers()
            board_logic(tile_id)
            return resp
          })
    })


  info6.append(div)
  div.appendChild(h1)
  div.appendChild(counter)
  div.appendChild(increase_button)
  div.appendChild(decrease_button)
  div.appendChild(submit_reinforcement_button)
  }
}

//Check if the region is reachable 2
const neighbours_checker = tile_id => {
  const selected_tile_obj = Game.state.territories.find(terr => terr.id == tile_id)
  if(selected_tile_obj.owner.name == `${session.name}`){
    return "Owned territory, cannot Attack!"
  }else{
    const list = mapObject.all_tiles
    const single = list.find(tile => tile.id == tile_id)
    const neighbours = single.neighbours.flat().map( ele => Game.state.territories.find(ter => ter.id == ele))
    const origin_of_attack = neighbours.find(terr => terr.owner.name == `${session.name}`)
      if (origin_of_attack) {

        const attack_button = document.createElement("button")
        const army_quantities = document.createElement("div")
        const h1 = document.createElement("h1")
        const increase_button = document.createElement("button")
        const decrease_button = document.createElement("button")
        const counter = document.createElement("div")
        info6.append(army_quantities)
        army_quantities.appendChild(h1)
        army_quantities.appendChild(counter)
        army_quantities.appendChild(increase_button)
        army_quantities.appendChild(decrease_button)
        info6.append(attack_button)

        h1.innerText = `Reachable from ${mapObject.find(terr => terr.id == origin_of_attack.id).name}. Preparing attack`
        counter.innerHTML = `<input type="text" id="counter-box" value="0">`
        increase_button.innerText = `+`
        decrease_button.innerText = `-`
        attack_button.innerText = `ATTACK!`
        increase_button.addEventListener("click", () =>{
          let box_value = document.getElementById("counter-box")
          let old_value = parseInt(box_value.value)
          if ((box_value.value == origin_of_attack.armies)-1){
            box_value.value = `${origin_of_attack.armies-1}`
          }else{
          box_value.value = (old_value+=1).toString()
        }})

        decrease_button.addEventListener("click", () =>{
          let box_value = document.getElementById("counter-box")
          if (box_value.value = "0"){
            box_value.value = "0"
          }else{
          let old_value = parseInt(box_value.value)
          box_value.value = old_value-=1
          }
        })

        attack_button.addEventListener("click", () => {debugger
          let box_value = document.getElementById("counter-box")
          posting_attack(origin_of_attack, tile_id, session.id, box_value.value)
        })
      } else {
        return "No owned state in range. Select a different state to Attack"
    }
  }
}

//POSTING ATTACK 3
const posting_attack = (origin_of_attack_object, tile_id, session_id) => {
  fetch(IP_ADDRESS+'attack', {
    method: "POST",
    headers: {"Content-Type" : "application/json"},
    body: JSON.stringify({attacker_id: session_id, armies: box_value.value, target: tile_id})
  }).then(resp => resp.json()).then(resp => render_battle(resp))
}

//ATACK PHASE 1
const attack_phase = tile_id => {
  const button_attack = document.createElement("button")
  button_attack.class = "button_attack"
  button_attack.innerText = `Attack!`
  //////////////////////////////////////////
  info1.innerText = `Attack phase, select a tile to deploy trops on`
  info2.innerText = `=============================`
  info3.innerText = `Tile: ${mapObject.select(tile_id).name}`
  info4.innerText = `Controlled by: ${Game.state.territories.find(tile => tile.id == tile_id).owner.name}`
  info5.innerText = `Armies: ${Game.state.territories.find(tile => tile.id == tile_id).armies}`
  info6.innerText =  ``
  neighbours_checker(tile_id)
///////////////////////////////////////

  }

//RENDER BATTLE
const render_battle = () => {

  const fake_promise = {
    liveBattle : {
     attacker: {
       territory_id: 17,
       user: "Greg",
       armies: 2,
       casualties: 2,
       dice: [2,4,5]
     },
     defender: {
       territory_id: 9,
       user: "Bob",
       armies: 2,
       casualties: 1,
       dice: [6,4,2]
     },
     battleRound: 2,
   }}
   //RENDER DIFFERNT LINES DEPENDS ON SESSION USER
   const confirm_or_retire = () => {
     if(session.name == fake_promise.liveBattle.attacker.user){
       const retire_button = document.createElement("button")
       const attack_again = document.createElement("button")
       retire_button.innerText = "Abort Attack!"
       attack_again.innerText = "Attack Again!"

       battle3.appendChild(retire_button)
       battle3.appendChild(attack_again)

       attack_again.addEventListener("click", () => {
         posting_attack(origin_of_attack, tile_id, session.id)
       })

       retire_button.addEventListener("click", () => {
         retire(origin_of_attack, tile_id, session.id)
       })

     }else if (session.name == promise.liveBattle.defender.user){
       battle4.innerText = `Awaiting the attacker to advace turn`
     }
   }
  item1.innerText=``
  item2.innerText=``
  item3.innerText=``
  item4.innerText=``
  item5.innerText=``
  item6.innerText=``
  battle1.innerText = `Attacker: ${fake_promise.liveBattle.attacker.user} Defender: ${fake_promise.liveBattle.defender.user}`
  battle2.innerText = `Attackers rolls ${fake_promise.liveBattle.attacker.dice}. Defender Rolls ${fake_promise.liveBattle.defender.dice}`
  battle3.innerText = `Casualities: Attacker loses ${fake_promise.liveBattle.attacker.casualties}, Defender loses ${fake_promise.liveBattle.defender.casualties}`
  confirm_or_retire()


}

//MOVEMENT CHECKER PHASE 2
const movement_neighbours_phase = tile_id => {
    const selected_tile_obj = Game.state.territories.find(terr => terr.id == tile_id)
    if(selected_tile_obj.owner.name !== `${session.name}`){
    }else{
      const list = mapObject.all_tiles
      const single = list.find(tile => tile.id == tile_id)
      const neighbours = single.neighbours.flat().map( ele => Game.state.territories.find(ter => ter.id == ele))
      const origin_of_movement = neighbours.find(terr => terr.owner.name == `${session.name}`)
        if (origin_of_movement) {

          const movement_button = document.createElement("button")
          const army_quantities = document.createElement("div")
          const h1 = document.createElement("h1")
          const increase_button = document.createElement("button")
          const decrease_button = document.createElement("button")
          const counter = document.createElement("div")
          info6.append(army_quantities)
          army_quantities.appendChild(h1)
          army_quantities.appendChild(counter)
          army_quantities.appendChild(increase_button)
          army_quantities.appendChild(decrease_button)
          info6.append(movement_button)

          h1.innerText = `Reachable from ${mapObject.all_tiles.find(terr => terr.id == origin_of_movement.id).name}. Preparing movement`
          counter.innerHTML = `<input type="text" id="counter-box" value="0">`
          increase_button.innerText = `+`
          decrease_button.innerText = `-`
          attack_button.innerText = `ATTACK!`

          increase_button.addEventListener("click", () =>{
            let box_value = document.getElementById("counter-box")
            let old_value = parseInt(box_value.value)
            if ((box_value.value == origin_of_movement.armies)){
              box_value.value = `${origin_of_movement.armies-1}`
            }else{
            box_value.value = (old_value+=1).toString()
          }})

          decrease_button.addEventListener("click", () =>{
            let box_value = document.getElementById("counter-box")
            if (box_value.value = "0"){
              box_value.value = "0"
            }else{
            let old_value = parseInt(box_value.value)
            box_value.value = old_value-=1
            }
          })

          attack_button.addEventListener("click", () => {debugger
            let box_value = document.getElementById("counter-box")
            posting_movement(origin_of_movement, tile_id, session.id, box_value.value)
          })
        } else {
          return "No owned state in range. Select a different state to reinforce"
      }
    }
  }
//POSTING MOVEMENT 3
const posting_movement = (origin_of_movement_object, tile_id, session_id) => {
  fetch(IP_ADDRESS+'attack', {
    method: "POST",
    headers: {"Content-Type" : "application/json"},
    body: JSON.stringify({attacker_id: session_id, armies: box_value.value, target: tile_id})
  }).then(resp => resp.json()).then(resp => render_battle(resp))
}
//MOVEMENT PHASE 1
const movement_phase = tile_id => {
  //////////////////////////////////////////
  info1.innerText = `Movement phase, select a tile to move trops on`
  info2.innerText = `=============================`
  info3.innerText = `Tile: ${mapObject.select(tile_id).name}`
  info4.innerText = `Controlled by: ${Game.state.territories.find(tile => tile.id == tile_id).owner.name}`
  info5.innerText = `Armies: ${Game.state.territories.find(tile => tile.id == tile_id).armies}`
  info6.innerText =  ``
  movement_neighbours_phase(tile_id)
}

//starting lobby
const starting_lobby = () => {
  if(session.username == "") {
    create_new_user()
  }
}

starting_lobby()
