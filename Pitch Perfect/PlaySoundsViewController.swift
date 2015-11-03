//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Marco Antonio Copa@ on 18/10/15.
//  Copyright © 2015 mcopa. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var audioPlayer: AVAudioPlayer!;
    var receivedAudio : RecordedAudio!;
    var audioEngine: AVAudioEngine!;
    var audioFile: AVAudioFile!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer =  try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true;
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func playSlowAudio(sender: UIButton) {
        playAudioAtRate(0.5);

    }

    @IBAction func playFastAudio(sender: UIButton) {
        playAudioAtRate(1.5);
    }
 
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000);
        
    }
    
    @IBAction func playDarthvaderAudio(sender: AnyObject) {
        playAudioWithVariablePitch(-1000);
        
    }
    
    @IBAction func stopSound(sender: UIButton) {
        audioPlayer.stop();
        audioPlayer.currentTime = 0.0;
        audioEngine.stop();
        audioEngine.reset();
    }
    
    func playAudioAtRate(rate: Float){
        audioPlayer.stop();
        audioEngine.stop();
        audioEngine.reset();
        audioPlayer.rate = rate;
        audioPlayer.currentTime = 0.0;
        audioPlayer.play();
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop();
        audioEngine.stop();
        audioEngine.reset();
        
        let audioPlayerNode = AVAudioPlayerNode();
        audioEngine.attachNode(audioPlayerNode);
        
        let changePitchEffect = AVAudioUnitTimePitch();
        changePitchEffect.pitch = pitch;
        audioEngine.attachNode(changePitchEffect);
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil);
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil);
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil);
        
        try! audioEngine.start();
        audioPlayerNode.play();
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
