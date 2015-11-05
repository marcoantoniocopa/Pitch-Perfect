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
   
    // global variables
    var receivedAudio : RecordedAudio!;
    var audioEngine: AVAudioEngine!;
    var audioFile: AVAudioFile!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioEngine = AVAudioEngine();
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    //** function to play the recording with a slow effect changing the rate value */
    @IBAction func playSlowAudio(sender: UIButton) {
        playAudioWithMultipleEffect(0.5, pitch: 1.0, echo: 0, reverb: 0)

    }

    //** function to play the recording with a  fast rate */
    @IBAction func playFastAudio(sender: UIButton) {
        playAudioWithMultipleEffect(1.5, pitch: 1.0, echo: 0, reverb: 0)
    }
 
    //** function to play the recording with a chipmunk effect changing the pitch value*/
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithMultipleEffect(1, pitch: 1000, echo: 0, reverb: 0)
    }
    
    //** function to play the recording with a  darth vader effect changing the pitch value*/
    @IBAction func playDarthvaderAudio(sender: AnyObject) {
        playAudioWithMultipleEffect(1, pitch: -1000, echo: 0, reverb: 0)
    }
    
    //** function to play the recording with a reverb effect*/
    @IBAction func playReverbAudio(sender: UIButton) {
        playAudioWithMultipleEffect(1, pitch: 1.0, echo: 0, reverb: 50)
    }
    
    //** function to play the recording with a echo effect*/
    @IBAction func playEchoAudio(sender: UIButton) {
        playAudioWithMultipleEffect(1, pitch: 1.0, echo: 0.2, reverb: 0)
    }
    
    //** function to stop and reset the audio */
    @IBAction func stopSound(sender: UIButton) {
        audioEngine.stop();
        audioEngine.reset();

    }
    
    /**
        It reproduce an audio with multiples effects.
        - parameters:
            - rate: the rate value, default value of 1.0
            - pitch: the pitch value. The default value is 1.0. The range of values is -2400 to 2400.
            - echo: the delay time value. The default value is 50.
            - reverb: reverb the wetDryMix value. Range between 0 (all dry) -> 100 (all wet)
        - remark: This is a super-easy method.
    */
    func playAudioWithMultipleEffect(rate: Float, pitch: Float, echo: Float, reverb: Float){
        
        let audioPlayerNode = AVAudioPlayerNode();
        audioPlayerNode.stop();
        
        audioEngine.stop();
        audioEngine.reset();
        
        audioEngine.attachNode(audioPlayerNode);
        
        
        // Setting the pitch and rate effect
        let audioUnitTimeEffect = AVAudioUnitTimePitch()
        audioUnitTimeEffect.pitch = pitch
        audioUnitTimeEffect.rate = rate
        audioEngine.attachNode(audioUnitTimeEffect)
        
        // Setting the echo effect
        let echoEffect = AVAudioUnitDelay()
        echoEffect.delayTime = NSTimeInterval(echo)
        audioEngine.attachNode(echoEffect)
        
        // Setting the reverb effect
        let reverbEffect = AVAudioUnitReverb()
        reverbEffect.loadFactoryPreset(AVAudioUnitReverbPreset.Cathedral)
        reverbEffect.wetDryMix = reverb
        audioEngine.attachNode(reverbEffect)
        
        
        
        // connect effects between them, ending with the output
        audioEngine.connect(audioPlayerNode, to: audioUnitTimeEffect, format: nil)
        audioEngine.connect(audioUnitTimeEffect, to: echoEffect, format: nil)
        audioEngine.connect(echoEffect, to: reverbEffect, format: nil)
        audioEngine.connect(reverbEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil);
        
        try! audioEngine.start();
        audioPlayerNode.play();
    }

    /**
     It reproduce an audio selecting one parameter of type AVAudioUnit and editing their value.
     - parameters:
     - audioChangeValue: the value of the new effect
     - typeOfEffect: type of effect that you want apply _options:_ pitch, rate, echo ,reverb
     - experiment: this method is redundant.
     */
    func playAudioWithOneEffect(audioChangeValue: Float, typeOfEffect: String){
        
        let audioPlayerNode = AVAudioPlayerNode();
        audioPlayerNode.stop();
        audioEngine.stop();
        audioEngine.reset();
        audioEngine.attachNode(audioPlayerNode);
        
        let changeAudioUnitTimeEffect = AVAudioUnitTimePitch();
        
        // Setting the reverb effect
        let reverbEffect = AVAudioUnitReverb()
        reverbEffect.loadFactoryPreset(AVAudioUnitReverbPreset.Cathedral)
        
        // Setting the echo effect on a specific interval
        let echoEffect = AVAudioUnitDelay()
        
        switch typeOfEffect {
            
            case "rate" :
                changeAudioUnitTimeEffect.rate = audioChangeValue
                changeAudioUnitTimeEffect.pitch = 0
                echoEffect.delayTime = 0
                reverbEffect.wetDryMix =  0
            
            case "pitch" :
                changeAudioUnitTimeEffect.pitch = audioChangeValue
                changeAudioUnitTimeEffect.rate = 1
                echoEffect.delayTime = 0
                reverbEffect.wetDryMix =  0
            
            case "reverb" :
                reverbEffect.wetDryMix = audioChangeValue
                echoEffect.delayTime = 0
                changeAudioUnitTimeEffect.pitch = 0
                changeAudioUnitTimeEffect.rate = 1
            
            case "echo" :
                echoEffect.delayTime = NSTimeInterval(audioChangeValue)
                reverbEffect.wetDryMix =  0
                changeAudioUnitTimeEffect.rate = 1
            
            default: break
        }
        
        audioEngine.attachNode(reverbEffect)
        audioEngine.attachNode(echoEffect)
        audioEngine.attachNode(changeAudioUnitTimeEffect);
        
        audioEngine.connect(audioPlayerNode, to: changeAudioUnitTimeEffect, format: nil);
        audioEngine.connect(changeAudioUnitTimeEffect, to: reverbEffect, format: nil);
        audioEngine.connect(reverbEffect, to: echoEffect, format: nil);
        audioEngine.connect(echoEffect, to: audioEngine.outputNode, format: nil);
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil);
        try! audioEngine.start();
        audioPlayerNode.play();
    }
    
}
