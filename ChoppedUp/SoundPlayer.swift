import UIKit
import SpriteKit
import AVFoundation



class SoundPlayer: NSObject {
    
    var audioPlayer:AVAudioPlayer!
    
    static var sharedInstance = SoundPlayer()
    
    
    // Game Sound Effects
    
    let wordBlockSelectedSound = SKAction.playSoundFileNamed("smooth_button_click11.wav", waitForCompletion: false)
    let placewordBlocksSound = SKAction.playSoundFileNamed("glossy_click_14.wav", waitForCompletion: false)
    let letterSelectedSound = SKAction.playSoundFileNamed("smooth_button_click11.wav", waitForCompletion: false)
    let wrongBlockSelectionSound = SKAction.playSoundFileNamed("glossy_interface_36.wav", waitForCompletion: false)
    let noMatchFoundSound = SKAction.playSoundFileNamed("glossy_interface_05.wav", waitForCompletion: false)
    let matchFoundSound = SKAction.playSoundFileNamed("chime_flourish_02.wav", waitForCompletion: false)
    let wholeBlockBonusSound = SKAction.playSoundFileNamed("success_sound_exploding_glass_01.wav", waitForCompletion: false)
    let newLettersSpawnedSound = SKAction.playSoundFileNamed("glossy_success_17.wav", waitForCompletion: false)
    let wordBlockMovedSound = SKAction.playSoundFileNamed("Swish_1.wav", waitForCompletion: false)
    let wordBlockShineSound = SKAction.playSoundFileNamed("wordBlockShineSound.wav", waitForCompletion: false)
    let multiplierSound = SKAction.playSoundFileNamed("score_counter_07.wav", waitForCompletion: false)
    let powerUpMenuToggle = SKAction.playSoundFileNamed("powerUpMenuToggleSmoothRollerOver19.wav", waitForCompletion: false)
    let freezeBlocks = SKAction.playSoundFileNamed("freezeBlocks.wav", waitForCompletion: false)
    let powerUpSelected = SKAction.playSoundFileNamed("powerUpSelected.wav", waitForCompletion: false)
    let falloutZoneSound = SKAction.playSoundFileNamed("falloutZoneSound.wav", waitForCompletion: false)
    let magnetizeSound = SKAction.playSoundFileNamed("magnetizeSound.wav", waitForCompletion: false)
    let magnetizeSoundAttracted = SKAction.playSoundFileNamed("magnetizeSoundAttracted.wav", waitForCompletion: false)
    let powerUpHideSound = SKAction.playSoundFileNamed("PowerUpHideSound.wav", waitForCompletion: false)
    let menuButtonSound = SKAction.playSoundFileNamed("glossy_click_33.wav", waitForCompletion: false)
    let menuSelectSound = SKAction.playSoundFileNamed("glossy_click_25.wav", waitForCompletion: false)
 
}

