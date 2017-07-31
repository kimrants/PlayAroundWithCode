//
//  StartRecordingViewController.swift
//  PlayAroundWithCode
//
//  Created by Kim Rants on 29/07/2017.
//  Copyright © 2017 Udacity. All rights reserved.
//


// AVFoundation framework contains the record. We need this to access classes
import AVFoundation
import Foundation
import UIKit

// Conform to the AVAudioRecorderDelegate
class StartRecordingViewController: UIViewController, AVAudioRecorderDelegate {
    
    // Declares a variable sothat we can use the AVAudioRecorder in multiple places
    var audioRecorder: AVAudioRecorder!
    
    // Display status of recording
    @IBOutlet weak var recordingStatusDisplayed: UILabel!
    
    // Start recording
    @IBAction func startRecording(_ sender: Any) {
        recordingStatusDisplayed.text = "Recording in progress"
        enableButtons(temp: false)
        
        // used to get directory path --> stores as a string in document directory
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        // Creates the instance
        let recordingName = "recordedVoice.wav"
        
        // creates full audio path
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        
        // try statement indicates that we DONT handle errors...
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        
        // set this viewController as the delegate
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    
    // Stop recording
    @IBAction func stopRecording(_ sender: Any) {
        recordingStatusDisplayed.text = "Recording finished"
        enableButtons(temp: true)
        
        // stop the recording function
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // A tester
    @IBOutlet weak var testForViewWillAppear: UILabel!
    
    // Add outlets to our buttons, so we can enable/disable them
    @IBOutlet weak var startRecordingButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    // change label(s) as the viewController will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        testForViewWillAppear.text = "fucker it worked 😉😉😉"
        recordingStatusDisplayed.text = "Tab to record 🤠"
        
        // Disable stop recording from the start --> can only be done to outlets! :)
        stopRecordingButton.isEnabled = false
    }
    
    // The two buttons will never be enabled/disabled at same time
    func enableButtons (temp: Bool) {
        if temp == true {
            startRecordingButton.isEnabled = true
            stopRecordingButton.isEnabled  = false
        } else {
            startRecordingButton.isEnabled = false
            stopRecordingButton.isEnabled  = true
        }
    }
    
    // Because the file needs to save before we move to next ViewController, we have to do this programatically! We'll use the below function to know when this is
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        // Specify the segue identifier and the sender; performSegue only if flag is true
        if flag {
            // We don't have to specify the next ViewController; just the segue
            performSegue(withIdentifier: "stopRecordingSegue", sender: audioRecorder.url)
        } else{
            print("recording failed")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // check if correct identifier / segue
        if segue.identifier == "stopRecordingSegue" {
            // forced upcast
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            // grab the sender
            let recordedAudioURL = sender as! URL
            // set the URL in the playsoundsVC
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}
