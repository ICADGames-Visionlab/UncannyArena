require "soundAssets"

audioManager={}

function audioManager.load()
  --audioManager.bulletSound = love.audio.newSource("/Assets/Sfx/b1.wav")
  --audioManager.deathSound = love.audio.newSource("/Assets/Sfx/Dragonite.wav")
  audioManager.explodeSound = love.audio.newSource("/Assets/Sfx/shieldBreak.wav")
  audioManager.characterSelectSound = love.audio.newSource("/Assets/Sfx/Character_select.wav")
  audioManager.optionSelectSound = love.audio.newSource("/Assets/Sfx/Clique.wav")
  audioManager.matchStartSound = love.audio.newSource("/Assets/Sfx/Match_Start.wav")
  audioManager.exitSound = love.audio.newSource("/Assets/Sfx/Voltar.wav")
  audioManager.endMatchSound = love.audio.newSource("/Assets/Music/Partida Terminada.mp3")
  
  audioManager.menuMusic = love.audio.newSource("/Assets/Music/Uncanny Arena - Título.mp3")
  audioManager.characterScreenMusic = love.audio.newSource("/Assets/Music/Uncanny Arena - Escolha de Personagem.mp3")
  
  --audioManager.bulletSound:setVolume(0.5)
  --audioManager.deathSound:setVolume(0.5)
  audioManager.explodeSound:setVolume(0.5)
  audioManager.characterSelectSound:setVolume(0.5)
  audioManager.optionSelectSound:setVolume(0.5)
  audioManager.matchStartSound:setVolume(0.5)
  audioManager.exitSound:setVolume(0.5)
  
  --[[audioManager.alienDamagedSound:setVolume(0.5)
  audioManager.alienChosenSound:setVolume(0.5)
  audioManager.alienDeathSound:setVolume(0.5)
  audioManager.alienBulletSound:setVolume(0.5)
  audioManager.alienVictorySound:setVolume(0.5)
  audioManager.brocolisDamagedSound:setVolume(0.5)
  audioManager.brocolisChosenSound:setVolume(0.5)
  audioManager.brocolisDeathSound:setVolume(0.5)
  audioManager.brocolisBulletSound:setVolume(0.5)
  audioManager.brocolisVictorySound:setVolume(0.5)
  audioManager.pirateDamagedSound:setVolume(0.5)
  audioManager.pirateChosenSound:setVolume(0.5)
  audioManager.pirateDeathSound:setVolume(0.5)
  audioManager.pirateBulletSound:setVolume(0.5)
  audioManager.pirateVictorySound:setVolume(0.5)
  audioManager.robotDamagedSound:setVolume(0.5)
  audioManager.robotChosenSound:setVolume(0.5)
  audioManager.robotDeathSound:setVolume(0.5)
  audioManager.robotBulletSound:setVolume(0.5)
  audioManager.robotVictorySound:setVolume(0.5)]]--

  audioManager.musicPlaying = nil
  for i,v in ipairs(soundAssets) do
    for j,w in pairs(v) do
      v[j] = love.audio.newSource(w)
    end
  end
end

function audioManager.playBulletSound(id)
  audioManager.playSfx(soundAssets[id+1].bullet)
end

function audioManager.playExplodeSound()
  audioManager.playSfx(audioManager.explodeSound)
end

function audioManager.playCharacterSelectSound()
  audioManager.playSfx(audioManager.characterSelectSound)
end

function audioManager.playOptionSelectSound()
  audioManager.playSfx(audioManager.optionSelectSound)
end

function audioManager.playMatchStartSound()
  audioManager.playSfx(audioManager.matchStartSound)
end

function audioManager.playExitSound()
  audioManager.playSfx(audioManager.exitSound)
end

function audioManager.playEndMatchSound()
  audioManager.playSfx(audioManager.endMatchSound)
end

--[[function audioManager.playdeathSound()
  audioManager.playSfx(audioManager.deathSound)
end]]--

function audioManager.playAlienDamagedSound()
  audioManager.playSfx(audioManager.alienDamagedSound)
end

function audioManager.playAlienChosenSound()
  audioManager.playSfx(audioManager.alienChosenSound)
end

function audioManager.playAlienDeathSound()
  audioManager.playSfx(audioManager.alienDeathSound)
end

function audioManager.playAlienBulletSound()
  audioManager.playSfx(audioManager.alienBulletSound)
end

function audioManager.playAlienVictorySound()
  audioManager.playSfx(audioManager.alienVictorySound)
end

function audioManager.playBrocolisDamagedSound()
  audioManager.playSfx(audioManager.brocolisDamagedSound)
end

function audioManager.playBrocolisChosenSound()
  audioManager.playSfx(audioManager.brocolisChosenSound)
end

function audioManager.playBrocolisDeathSound()
  audioManager.playSfx(audioManager.brocolisDeathSound)
end

function audioManager.playBrocolisBulletSound()
  audioManager.playSfx(audioManager.brocolisBulletSound)
end

function audioManager.playBroolisVictorySound()
  audioManager.playSfx(audioManager.brocolisVictorySound)
end

function audioManager.playPirateDamagedSound()
  audioManager.playSfx(audioManager.pirateDamagedSound)
end

function audioManager.playPirateChosenSound()
  audioManager.playSfx(audioManager.pirateChosenSound)
end

function audioManager.playPirateDeathSound()
  audioManager.playSfx(audioManager.pirateDeathSound)
end

function audioManager.playPirateBulletSound()
  audioManager.playSfx(audioManager.pirateBulletSound)
end

function audioManager.playPirateVictorySound()
  audioManager.playSfx(audioManager.pirateVictorySound)
end

function audioManager.playRobotDamagedSound()
  audioManager.playSfx(audioManager.robotDamagedSound)
end

function audioManager.playRobotChosenSound()
  audioManager.playSfx(audioManager.robotChosenSound)
end

function audioManager.playRobotDeathSound()
  audioManager.playSfx(audioManager.robotDeathSound)
end

function audioManager.playRobotBulletSound()
  audioManager.playSfx(audioManager.robotBulletSound)
end

function audioManager.playRobotVictorySound()
  audioManager.playSfx(audioManager.robotVictorySound)
end



function audioManager.play(music)
  if audioManager.musicPlaying ~= nil then
    love.audio.stop(audioManager.musicPlaying)
  end
  audioManager.musicPlaying = music
	music:setLooping(true)
  music:setVolume(0.5)
	love.audio.play(music)
end

function audioManager.playSfx(sfx)
  if sfx:isPlaying() then
    love.audio.stop(sfx)
  end
  love.audio.play(sfx)
end
return audioManager
