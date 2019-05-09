const info1 = document.querySelector("#item1")
const info2 = document.querySelector("#item2")
const info3 = document.querySelector("#item3")
const info4 = document.querySelector("#item4")
const info5 = document.querySelector("#item5")
const info6 = document.querySelector("#item6")

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
  if (Game.state.currentPlayer.id == session.id){
    if(Game.state.currentPhase == "Deployment") {
        deployment_phase(tile_id)
    }else if(Game.state.currentPhase == ""){

    }else{

    }
  }else{
    info1.innerText = `${Game.state.users[0]}: ${Game.state.territories.map(tile => tile.owner.id == Game.state.users[0].id).length} controlled territories`
    info2.innerText = `${Game.state.users[1]}: ${Game.state.territories.map(tile => tile.owner.id !== Game.state.users[1].id).length} controlled territories`
    info3.innerText = `-----------------------------------------------`
    info4.innerText = `Tile: ${mapObject.select(tile_id).name}`
    info5.innerText = `Controlled by: ${Game.state.territories.find(tile => tile.id == tile_id).owner.name}`
    info6.innerText = `Armies: ${Game.state.territories.find(tile => tile.id == tile_id).armies}`
  }
}
  //battle information

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

  const deployment_phase = tile_id => {
    const button_deployment = document.createElement("button")
    button_deployment.class = "button_deployment"
    button_deployment.innerText = `Submit and Proceed to Attack Turn`
    //////////////////////////////////////////
    info1.innerText = `Reinforcement left`
    info2.innerText = `You currently have ${Game.state.currentPlayer.tank}`
    info3.innerText = `Deployement phase, select a tile to deploy trops on`
    info4.innerText = `Tile: ${mapObject.select(tile_id).name}`
    info5.innerText = `Controlled by: ${Game.state.territories.find(tile => tile.id == tile_id).owner.name}`
    info6.innerText = `Armies: ${Game.state.territories.find(tile => tile.id == tile_id).armies}`
  ///////////////////////////////////////
  //if the user select an owned territory
    if(Game.state.territories.find(tile => tile.id == tile_id).owner == session) {
      const div = document.createElement("div")
      const h1 = document.createElement("h1")
      const increase_button = document.createElement("button")
      const decrease_button = document.createElement("button")
      const submit_reinforcement_button = document.createElement("submit")
      const counter = document.createElement("input")

      counter.type = "text"
      counter.name = "reinforcement"
      counter.value = "0"
      increase_button.addEventListener("click", () =>{
        const old_value = counter.value.toInteger
        counter.value = old_value=+1
      })
      increase_button.addEventListener("click", () =>{
        if (counter.value = "0"){
          counter.value = "0"
        }
        const old_value = counter.value.toInteger
        counter.value = old_value=-1
      })
    info6.append(div)
    div.appendChild(h1)
    div.appendChild(counter)
    div.appendChild(increase_button)
    div.appendChild(decrease_button)
    div.appendChild(submit_reinforcement_button)
  }}


  //starting lobby
  const starting_lobby = () => {
    if(session.username == "") {
      create_new_user()
    }
  }

  starting_lobby()
