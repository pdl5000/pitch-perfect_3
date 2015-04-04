//
//  PlaySoundsViewController.swift
//  PitchPerfect2
//
//  Created by Paul Lemelle on 3/22/15.
//  Copyright (c) 2015 Paul Lemelle. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer! // Declare an instance of the AVAudioPlayer
    var receivedAudio: RecordedAudio!
    var audioEngine : AVAudioEngine! // declare global object.
    
    var audioFile : AVAudioFile! // Will be used to convert NSURL recordAudio file to AVAudioFile
    
    
    @IBAction func snailSoundButton(sender: UIButton) {
        //
        audioEngine.reset()
        playBackAudio(audioSpeed: 0.5)
        
    }
    @IBAction func rabbitSoundButton(sender: UIButton) {
        //
        audioEngine.reset()
        playBackAudio(audioSpeed: 1.5)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        //
        audioEngine.reset()
        playAudioWithVariablePitch(pitch: 1000)
        
    }
    
    @IBAction func darthVadorSound(sender: UIButton) {
        //
        audioEngine.reset()
        playAudioWithVariablePitch(pitch: -1000)
        
    
    }
    
    func playAudioWithVariablePitch(#pitch: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    
        
    }
    
    
    func playBackAudio (#audioSpeed: Float) {
        audioPlayer.stop()
        audioPlayer.prepareToPlay()
        audioPlayer.rate = audioSpeed
        audioPlayer.play()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Setup file path for sound playback
    
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true // enableRae is a property of AVAudioPlayer
        audioEngine = AVAudioEngine() // Initialize the global object.
        
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil) // convert receiviedAudio to audiofile

    }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
