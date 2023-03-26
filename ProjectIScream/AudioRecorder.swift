//
//  AudioRecorder.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 25/03/23.
//

import SwiftUI
import AVFoundation
import Combine

class AudioRecorder: ObservableObject {
    
    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    var audioRecorder: AVAudioRecorder!
    var decibelLevelTimer = Timer()
    @Published var peakPower: Float = 0
    
    var recording = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Failed to set up recording session")
        }
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent("\(Date().toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss")).m4a")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.record()

            recording = true
            audioRecorder.isMeteringEnabled = true
            self.decibelLevelTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
                self.audioRecorder.updateMeters()

                self.peakPower = self.audioRecorder.peakPower(forChannel: 0)
                self.peakPower += (160 - 68)
                self.peakPower += (0.1*self.peakPower)
//                self.peakPower += (160 - 78 + 40) // untuk coba2
//                print(self.peakPower)
            }
        } catch {
            print("Could not start recording")
        }
    }
    
    func stopRecording() {
        audioRecorder.stop()
        recording = false
        decibelLevelTimer.invalidate()
    }
}

extension Date {
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
