//
//  ViewController.swift
//  pitchperfect(new)
//
//  Created by Apple on 11/26/18.
//  Copyright © 2018 mudassir. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var audioRecorder:AVAudioRecorder!
    
    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
          stopRecordingButton.isEnabled=false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("view will appear called")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func recordAudio(_ sender: Any) {
    print("record button was pressed")
        recordingLabel.text = "Recording in progress"
        recordButton.isEnabled=false
        stopRecordingButton.isEnabled=true
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedvoice.wav"
        let pathArray = [dirPath,recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:]) //hm ny abhi koi settings nhi krni audio ky sath that's why nil dictionary pass krdi hai
        //in the above line we're instentiating our audio recorder object of our AVAudioRecorder class
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    
    @IBAction func stopRecording(_ sender: Any) {
        print("Stop Recording button was pressed")
        recordButton.isEnabled=true
        stopRecordingButton.isEnabled=false
        recordingLabel.text="Tap to record"
    }
}

