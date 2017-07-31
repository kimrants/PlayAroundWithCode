//
//  PlaySoundsViewController.swift
//  PlayAroundWithCode
//
//  Created by Kim Rants on 30/07/2017.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    // Fast = 1, HighPitch = 2, etc.; like their tag values that we set earlier in attributes inspector
    enum ButtonType: Int { case Slow = 0, Fast, HighPitch, LowPitch, Echo, Reverb }
    
    // Outlets from all buttons
    @IBOutlet weak var Slow: UIButton!
    @IBOutlet weak var Fast: UIButton!
    @IBOutlet weak var HighPitch: UIButton!
    @IBOutlet weak var LowPitch: UIButton!
    @IBOutlet weak var Echo: UIButton!
    @IBOutlet weak var Reverb: UIButton!
    @IBOutlet weak var StopButton: UIButton!
    
    // Action to all buttons except stopButton - connected via document outline
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .HighPitch:
            playSound(pitch: 1000)
        case .LowPitch:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)
    }
    
    // Stop Button - connected via document outline
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }
    
    
    
}
