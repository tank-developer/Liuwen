//
//  RecordTool.swift
//  TextScan
//
//  Created by Apple on 2023/11/11.
//

import UIKit
import AVFoundation
import MMKV

class RecordTool: NSObject ,AVAudioPlayerDelegate, AVAudioRecorderDelegate{
    
    typealias PlayFinishBlock = (_ dic:Dictionary<String, Any>)->Void;
    var playFinishBlock : PlayFinishBlock?;
    
    typealias TimerChangeBlock = (_ dic:Dictionary<String, Any>)->Void;
    var timerChangeBlock : TimerChangeBlock?;
    
    static let shared = RecordTool()
//    static let shared = {
//         let instance = RecordTool()
//         // 其他代码
//        setupRecorder()
//         return instance
//    }()
    private override init() {}
    
    var audioStatus: AudioStatus = AudioStatus.stopped
    
    
    var audioRecorder: AVAudioRecorder!
    // 一个 音频 录制
    
    var audioPlayer: AVAudioPlayer!
    // 一个 音频 播放
    
    var soundTimer: CFTimeInterval = 0.0
    var updateTimer: CADisplayLink!
    
//    override init() {
//        super.init()
//    }
    
    
    private func savaFilePath(filePath:String) {
        
        MMKVUtil.shared.setupPathEle(ele: filePath)
    }
    func queryFilePath() -> String{
        
        let path = MMKVUtil.shared.getPathEle()
        return path
    }
    
    func getURLforMemo() -> String {
        return self.queryFilePath()
    }
    public func setupRecorder() {
        
        let tempDir = NSHomeDirectory() + "/Documents"
        let billIdentifier = CommonUtil.getIdentifier()
        let billIdentifierNSNumber = billIdentifier as NSNumber
        let billIdentifierString : String = billIdentifierNSNumber.stringValue
        
        
//        let paht = tempDir + "/" + billIdentifierString + ".caf"
        let filePath = String(format: "%@/%@.caf", tempDir,billIdentifierString)
        let fileName = String(format: "%@.caf",billIdentifierString)

        
//        let filePath = tempDir + "/TempMemo.caf"
        savaFilePath(filePath: fileName)
        print(filePath)
        let fUrls = URL(fileURLWithPath: filePath)
        print(fUrls)
        
        
        let fileURL = fUrls
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
    
    
    func setupStopRecordInit() {
        var fUrls = getURLforMemo()
        let tempDir = NSHomeDirectory() + "/Documents"

        let filePath = String(format: "%@/%@", tempDir,fUrls)
        
        let filePaths = URL(fileURLWithPath: filePath)


//        let fileURL = filePath
        let recordSettings = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ] as [String : Any]
            
        do {
            audioRecorder =  try AVAudioRecorder(url: filePaths, settings: recordSettings)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
        } catch {
            print("Error creating audio Recorder.")
        }
    }
    
    func startRecording() {
//        setupRecorder()
        audioStatus = .recording
        audioRecorder.record()
        startUpdateLoop()
    }
    func stopRecording() {
        audioStatus = .stopped
        audioRecorder.stop()
    }
    
    
    func play() {
        let tempDir = NSHomeDirectory() + "/Documents"
        
        let fileURL = getURLforMemo()
        let filePath = String(format: "%@/%@.caf", tempDir,fileURL)
        
        print(filePath)
        let filePaths = URL(fileURLWithPath: filePath)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: filePaths)
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
    
    func playBy(fileName:String) {
        let tempDir = NSHomeDirectory() + "/Documents"
        
        let filePath = String(format: "%@/%@", tempDir,fileName)
        
        print(filePath)
        let filePaths = URL(fileURLWithPath: filePath)
        
        
//        let fileURL = URL(fileURLWithPath: path)
        
        print(filePaths)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: filePaths)
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
    
    func pause(fileName:String) {
        let tempDir = NSHomeDirectory() + "/Documents"
        
        let filePath = String(format: "%@/%@", tempDir,fileName)
        
        print(filePath)
        let filePaths = URL(fileURLWithPath: filePath)
        
        
//        let fileURL = URL(fileURLWithPath: path)
        
        print(filePaths)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: filePaths)
            audioPlayer.delegate = self
            if audioPlayer.duration > 0.0 {
//                setPlayButtonOn(flag: true)
                audioPlayer.pause()
//                audioStatus = .playing
                stopUpdateLoop()
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
        var dic = Dictionary<String, Any>()
        dic["status"] = ""
        self.playFinishBlock?(dic);
    }
    
    func startUpdateLoop(){
        if updateTimer != nil{
            updateTimer.invalidate()
        }
        updateTimer = CADisplayLink(target: self, selector: #selector(updateLoop))
        updateTimer.preferredFramesPerSecond = 1
        updateTimer.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
    }
    
    func stopUpdateLoop(){
        if updateTimer != nil{
            updateTimer.invalidate()
            updateTimer = nil
        }


//        timeLabel.text = formattedCurrentTime(UInt(0))
    }
 
    @objc func updateLoop(){
        if audioStatus == .recording{
            if CFAbsoluteTimeGetCurrent() - soundTimer > 0.5 {
//                timeLabel.text = formattedCurrentTime(UInt(audioRecorder.currentTime))
//                print(formattedCurrentTime(UInt(audioRecorder.currentTime)))
                var dic = Dictionary<String,String>()
                dic["time"] = formattedCurrentTime(UInt(audioRecorder.currentTime))
                self.timerChangeBlock?(dic);

                soundTimer = CFAbsoluteTimeGetCurrent()
            }
        }
        else if audioStatus == .playing{
            if CFAbsoluteTimeGetCurrent() - soundTimer > 0.5 {
//                timeLabel.text = formattedCurrentTime(UInt(audioPlayer.currentTime))
//                print(formattedCurrentTime(UInt(audioPlayer.currentTime)))
                var dic = Dictionary<String,String>()
                dic["time"] = formattedCurrentTime(UInt(audioPlayer.currentTime))
                self.timerChangeBlock?(dic);
                
                soundTimer = CFAbsoluteTimeGetCurrent()
            }
        }
    }
    
    func formattedCurrentTime(_ time: UInt) -> String{
        let hours = time / 3600
        let minutes = ( time / 60 ) % 60
        let seconds = time % 60
        
        return String(format: "%02i: %02i: %02i", hours, minutes, seconds)
    }
}
