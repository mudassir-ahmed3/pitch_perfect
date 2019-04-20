//
//  playSoundsViewController.swift
//  pitchperfect(new)
//
//  Created by Apple on 12/2/18.
//  Copyright © 2018 mudassir. All rights reserved.
//

import UIKit
import AVFoundation

class playSoundsViewController: UIViewController {
    

    
    @IBOutlet weak var snailButton:UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL:URL!
    
//these are some properties and enumeration that are gonna used by our class extension
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio() // so that avaudioengine gets properly setup when this screen loads
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureUI(.notPlaying) //in order to make stop button disabled when this screen appears it should active only when one of these six buttons get pressed
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch (ButtonType(rawValue: sender.tag)!) { //code contained within the switch statement is what convert's button tag to a button type then using the button type you can play sound appropriately
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate:1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
            }
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    



}
