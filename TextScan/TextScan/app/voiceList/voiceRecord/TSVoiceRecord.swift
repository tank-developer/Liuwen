//
//  TSVoiceRecord.swift
//  TextScan
//
//  Created by Apple on 2023/11/11.
//

import UIKit
import AVFoundation

class TSVoiceRecord: NSObject, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    
    static let shared = TSVoiceRecord()
    
    
    var audioStatus: AudioStatus = AudioStatus.stopped
    
    var audioRecorder: AVAudioRecorder!
    // 一个 音频 录制
    
    var audioPlayer: AVAudioPlayer!
    // 一个 音频 播放
    
    var soundTimer: CFTimeInterval = 0.0
    var updateTimer: CADisplayLink!
    
    override init() {
        super.init()
         self.setupRecorder()
    }
    
    func onRecord() {
    
        if appHasMicAccess == true {
            switch audioStatus {
            case .stopped:
//                recordButton.setBackgroundImage(UIImage(named: "button-record1"), for: UIControl.State.normal )
                record()
            case .recording:
//                recordButton.setBackgroundImage(UIImage(named: "button-record"), for: UIControl.State.normal )
                stopRecording()
            case .playing:
                stopPlayback()
            default:
                ()
            }
            
        }// if appHasMicAccess == true
        else {
            // 里面的 代码， 不做考虑
//            recordButton.isEnabled = false
//            let theAlert = UIAlertController(title: "Requires Microphone Access",
//                                             message: "Go to Settings > PenguinPet > Allow PenguinPet to Access Microphone.\nSet switch to enable.",
//                                             preferredStyle: UIAlertController.Style.alert)
//
//            theAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//            self.view?.window?.rootViewController?.present(theAlert, animated: true, completion: {            })
            
        }
    }
    
    // MARK: Recording
    func setupRecorder() {
        let fileURL = getURLforMemo()
        let recordSettings = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ] as [String : Any]
        
        do {
            audioRecorder =  try AVAudioRecorder(url: fileURL, settings: recordSettings)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
        } catch {
            print("Error creating audio Recorder.")
        }
        
    }
    func getURLforMemo() -> URL {
        let tempDir = NSTemporaryDirectory()
        let filePath = tempDir + "/TempMemo.caf"
        return URL(fileURLWithPath: filePath)
    }
    

    func record() {
        startUpdateLoop()
        audioStatus = .recording
        audioRecorder.record()
    }
    func stopRecording() {
//        recordButton.setBackgroundImage(UIImage(named: "button-record"), for: UIControl.State.normal  )
        audioStatus = .stopped
        audioRecorder.stop()
        stopUpdateLoop()
    }
    func stopPlayback() {
//        setPlayButtonOn(flag: false)
        audioStatus = .stopped
        audioPlayer.stop()
        stopUpdateLoop()
    }  //  停止 回放 功能
    
    func startUpdateLoop(){
        if updateTimer != nil{
            updateTimer.invalidate()
        }
        updateTimer = CADisplayLink(target: self, selector: #selector(updateLoop))
        updateTimer.preferredFramesPerSecond = 1
        updateTimer.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
    }
    func stopUpdateLoop(){
        updateTimer.invalidate()
        updateTimer = nil
//        timeLabel.text = formattedCurrentTime(UInt(0))
    }
    
    @objc func updateLoop(){
        if audioStatus == .recording{
            if CFAbsoluteTimeGetCurrent() - soundTimer > 0.5 {
//                timeLabel.text = formattedCurrentTime(UInt(audioRecorder.currentTime))
                soundTimer = CFAbsoluteTimeGetCurrent()
            }
        }
        else if audioStatus == .playing{
            if CFAbsoluteTimeGetCurrent() - soundTimer > 0.5 {
//                timeLabel.text = formattedCurrentTime(UInt(audioPlayer.currentTime))
                soundTimer = CFAbsoluteTimeGetCurrent()
            }
        }
    }
    
    func onPlay() {
        switch audioStatus {
        case .recording:
//            recordButton.setBackgroundImage(UIImage(named: "button-record"), for: UIControl.State.normal )
            stopRecording()
        case .stopped:
            play()
        case .playing:
            stopPlayback()
        default:
            ()
        }
    }
    func play() {
        let fileURL = getURLforMemo()
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            audioPlayer.delegate = self
            if audioPlayer.duration > 0.0 {
//                setPlayButtonOn(flag: true)
                audioPlayer.play()
                audioStatus = .playing
                
                startUpdateLoop()
            }
            
        } catch {
            print("Error loading audio Player")
        }
    }
    
    
    // MARK: Delegates
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        audioStatus = .stopped
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
//        setPlayButtonOn(flag: false)
        audioStatus = .stopped
        stopUpdateLoop()
    }
    func formattedCurrentTime(_ time: UInt) -> String{
        let hours = time / 3600
        let minutes = ( time / 60 ) % 60
        let seconds = time % 60
        
        return String(format: "%02i: %02i: %02i", hours, minutes, seconds)
    }
    
    
    
}



