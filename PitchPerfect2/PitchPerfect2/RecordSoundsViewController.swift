//
//  RecordSoundsViewController.swift
//  PitchPerfect2
//
//  Created by Paul Lemelle on 3/22/15.
//  Copyright (c) 2015 Paul Lemelle. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate { // Use the AVAudioRecorderDelegate to make RecordSoundsViewController a delegate for AVFoundation class for the  
    
    
    @IBOutlet weak var recordingInProgress: UILabel! // Use the word weak to manage memory of the variable. The term weak means that the memory reference was controlled by a different event.
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButtonIcon: UIButton!
    
    var audioRecorder : AVAudioRecorder! // Declaore global variable
    var recordedAudio : RecordedAudio! // new object for the AudioReccorded class
    
    @IBOutlet weak var tapToRecord: UILabel!
    
    @IBAction func stopButton(sender: UIButton) {
        
        recordingInProgress.hidden = true // Hide the cording label when pressed.
        recordButton.enabled = true
        
        //stop audio recorder
        audioRecorder.stop()
        // deactivate audio session
        var audioSession = AVAudioSession.sharedInstance();
        audioSession.setActive(false, error: nil)
        
    }
    
    @IBAction func recordAudio(sender: UIButton) {
        tapToRecord.hidden = true // hide label when Record button is pressed
        recordingInProgress.hidden = false // unhides the recording label
        stopButtonIcon.hidden = false
        //disable the microphone button after the user has pressed it.
        recordButton.enabled = false
    
        let dirPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
        var currentDateTime = NSDate()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "ddmmyyyy-HHmmss"
        var recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        //println(filePath)
        
        
        
        //setup audio session
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        // initiate and prepare the recorder
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        //Make recordSoundViewController the delegate of audioRecorder to use the method audioDidFinishRecording
        audioRecorder.delegate = self

        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        if (flag) {
            recordedAudio = RecordedAudio(_filePathUrl: recorder.url, _title: recorder.url.lastPathComponent)
            
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio) // recordedAudio is the object that will actually initites the seque
            

        } else {
            println("Error saving recording")
            recordButton.enabled = true
            stopButtonIcon.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //
        if (segue.identifier == "stopRecording") {
            
            //Way to pass data to the segue
            let playSoundVC: PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            
            //retrive the data
            let data = sender as? RecordedAudio
            
            //Pass the data
            playSoundVC.receivedAudio = data
            
        }
    }

    
    override func viewWillAppear(animated: Bool) {
        //
        //Code to hide the stop button as oppose to using the @IBAction func recordAudio funciton
        stopButtonIcon.hidden = true
        tapToRecord.hidden = false 
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Inital setup and once time setup.
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // ViewWillAppear - Method for shwoing / hiding what's on the screen.
        // ViewDidAppear - Method - right afer view appeard - great for starting animations
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

