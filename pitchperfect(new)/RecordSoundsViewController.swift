//
//  RecordSoundsViewController.swift
//  pitchperfect(new)
//
//  Created by Apple on 11/26/18.
//  Copyright © 2018 mudassir. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate{
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


    @IBAction func recordAudio(_ sender: Any) {
    print("record button was pressed")
        recordingLabel.text = "Recording in progress"
        recordButton.isEnabled=false
        stopRecordingButton.isEnabled=true
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedvoice.wav"
        let pathArray = [dirPath,recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        //print(filePath)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:]) //hm ny abhi koi settings nhi krni audio ky sath that's why nil dictionary pass krdi hai
        //in the above line we're instentiating our audio recorder object of our AVAudioRecorder class
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    
    @IBAction func stopRecording(_ sender: Any) {
        print("Stop Recording button was pressed")
        recordButton.isEnabled=true
        stopRecordingButton.isEnabled=false
        recordingLabel.text="Tap to record"
        //jo session create kya tha record audio mein usy khatam krna aur jo recording shru ki thi usy bnd krna
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
    }
//this is the function in avaudiorecorderdelegate class its an optional function but we want to implemet it
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("recording wasn't succesful")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! playSoundsViewController
            //because this destination is th property of UIviewcontroller but we know its playsounds view controller we forced upcast it to playsoundsvc
            //now that we have object of playsoundsvc we can use it to access variables of playsoundsviewcontroller
            playSoundsVC.recordedAudioURL = sender as! URL   //wohi aaraha hota sender mein jo aap perform segue krty huy sender mein bhejty
            
            
        }
    }


}

