//sidebar function
function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
}

function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}

//show tile on side button

const board_logic = tile => {
  const state = find_state()
  debugger
    const info1 = document.querySelector("#item1")
    const info2 = document.querySelector("#item2")
    const info3 = document.querySelector("#item3")
    const info4 = document.querySelector("#item4")
    info1.innerText = ``
    info1.innerText = `Tile: ${tile.name}`
    info2.innerText = ``
    info2.innerText = `Owner:`
    info3.innerText = ``
    info3.innerText = `Infantry force:`
  }

  const battle_status_rendering = () => {
    const data1 = document.querySelector("#battle1")
    const data2 = document.querySelector("#battle2")
    const data3 = document.querySelector("#battle3")
    const data4 = document.querySelector("#battle4")
    const img = document.createElement("image")
    const bottom_menu = document.getElementById("mySidenav-bottom")

    img.src = ("images/attack_alert.gif")
    bottom_menu.append(img)
    data1.innerText = ``
    data1.innerText = `War has been declared between <P1> and <P2> on the territory of <territory>`
    data2.innerText = ``
    data2.innerText = ``
    data3.innerText = ``
    data3.innerText = ``
  }
