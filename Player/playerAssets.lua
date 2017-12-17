local playerAssets = {
  --brócolis
  {
    idle = {
      sheetFilename = {
        "/Assets/Player/Brocolis/brocolis_idle_corpo.png",
        "/Assets/Player/Brocolis/brocolis_idle_braco.png"
      },
      animationTime = 2.0,
      nCol = 15,
      nRow = 4,
      shouldLoop = true
      --framesQuant = {}
    },
    death = {
      sheetFilename = "/Assets/Player/Brocolis/brocolis_morte.png",
      animationTime = 2,
      nCol = 14,
      nRow = 4,
      shouldLoop = false
    },
    walk = {
      sheetFilename = {
        "/Assets/Player/Brocolis/brocolis_andando_corpo.png",
        "/Assets/Player/Brocolis/brocolis_andando_braco.png"
      },
      animationTime = 1,
      nCol = 8,
      nRow = 4,
      shouldLoop = true
    },
    shoot = {
      sheetFilename = {
        "/Assets/Player/Brocolis/brocolis_idle_braco_tiro.png",
      "/Assets/Player/Brocolis/brocolis_andando_braco_tiro.png"  
      },
      animationTime = 0.2,
      nCol = 15,
      nRow = 4,
      shouldLoop = false
    }
  },
  --robô
  {
    idle = {
      sheetFilename = {
        "/Assets/Player/Robo/robo_idle_corpo.png",
        "/Assets/Player/Robo/robo_idle_braco.png"
      },
      animationTime = 1.0,
      nCol = 8,
      nRow = 4,
      shouldLoop = true
      --framesQuant = {}
    },
    death = {
      sheetFilename = "/Assets/Player/Robo/robo_morte.png",
      animationTime = 2,
      nCol = 14,
      nRow = 4,
      shouldLoop = false
    },
    walk = {
      sheetFilename = {
        "/Assets/Player/Robo/robo_andando_corpo.png",
        "/Assets/Player/Robo/robo_andando_braco.png"
      },
      animationTime = 1,
      nCol = 8,
      nRow = 4,
      shouldLoop = true
    },
    shoot = {
      sheetFilename = {
        "/Assets/Player/Robo/robo_idle_braco_tiro.png",
      "/Assets/Player/Robo/robo_andando_braco_tiro.png"  
      },
      animationTime = 0.5,
      nCol = 8,
      nRow = 4,
      shouldLoop = false
    }
  },
  --alien
  {
    idle = {
      sheetFilename = {
        "/Assets/Player/Alien/alien_idle_corpo.png",
        "/Assets/Player/Alien/alien_idle_cabeca.png"
      },
      animationTime = 0.5,
      nCol = 8,
      nRow = 4,
      shouldLoop = true
      --framesQuant = {}
    },
    death = {
      sheetFilename = "/Assets/Player/Alien/alien_morte.png",
      animationTime = 2,
      nCol = 14,
      nRow = 4,
      shouldLoop = false
    },
    walk = {
      sheetFilename = {
        "/Assets/Player/Alien/alien_andando_corpo.png",
        "/Assets/Player/Alien/alien_andando_cabeca.png"
      },
      animationTime = 1,
      nCol = 8,
      nRow = 4,
      shouldLoop = true
    },
    shoot = {
      sheetFilename = {
        "/Assets/Player/Alien/alien_idle_cabeca_tiro.png",
      "/Assets/Player/Alien/alien_andando_cabeca_tiro.png"  
      },
      animationTime = 0.2,
      nCol = 8,
      nRow = 4,
      shouldLoop = false
    }
  },
  --pirata
  {
    idle = {
      sheetFilename = {
        "/Assets/Player/Pirate/pirata_idle_corpo.png",
        "/Assets/Player/Pirate/pirata_idle_braco.png"
      },
      animationTime = 0.5,
      nCol = 7,
      nRow = 4,
      shouldLoop = true
      --framesQuant = {}
    },
    death = {
      sheetFilename = "/Assets/Player/Pirate/pirata_morte.png",
      animationTime = 2,
      nCol = 14,
      nRow = 4,
      shouldLoop = false
    },
    walk = {
      sheetFilename = {
        "/Assets/Player/Pirate/pirata_andando_corpo.png",
        "/Assets/Player/Pirate/pirata_andando_braco.png"
      },
      animationTime = 1,
      nCol = 8,
      nRow = 4,
      shouldLoop = true
    },
    shoot = {
      sheetFilename = {
        "/Assets/Player/Pirate/pirata_idle_braco_tiro.png",
      "/Assets/Player/Pirate/pirata_andando_braco_tiro.png"  
      },
      animationTime = 0.2,
      nCol = 7,
      nRow = 4,
      shouldLoop = false
    }
  }
}
return playerAssets