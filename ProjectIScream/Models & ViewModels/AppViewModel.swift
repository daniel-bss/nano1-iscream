//
//  AppViewModel.swift
//  ProjectIScream
//
//  Created by Daniel Bernard Sahala Simamora on 13/02/24.
//

import SwiftUI
import Combine
import AVFoundation
import CoreData

struct AlertItem: Identifiable {
    let id = UUID()
    
    let title: String
    let message: String
    let dismissButton: Alert.Button
}

final class AppViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    
    @Published var isShowingWelcomeView = true
    @Published var isShowingMonsters = false
    
    @Published var username: String = ""
    @Published var dbCounter: Int = 0
    
    @Published var alertItem: AlertItem?
    
    var playerEntities = [PlayerEntity]()
    var sortedPlayers = [Player]()
    var numOfKills = 0
    
    // TIMER
    @Published var isShowingThreeSecTimer = true
    @Published var threeSecTimer = 3
    @Published var timeSec = 60
    
    @Published var isFinishedRecording = false
    
    // AUDIO RECORDER PROPERTIES
    let objectWillChange = PassthroughSubject<AppViewModel, Error>()
    var audioRecorder: AVAudioRecorder!
    var decibelLevelTimer = Timer()
    var recording = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    var minimumValue: Float = -40
    @Published var power: Float = 0
    // // // // // // // //// // // // // // // //
    
    let container: NSPersistentContainer
    
    public init() {
        container = NSPersistentContainer(name: "PlayersContainer")
        container.loadPersistentStores { description, error in
            print("Core Data Desc: \(description)")
            if let error {
                print("ERROR WHEN LOADING CORE DATA. \(error)")
            }
        }
        
        fetchPlayers()
        sortedPlayers = self.sortPlayers()
    }
    
    public func onTapCheckMark(completion: (() -> ())?) {
        username = username.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !username.isEmpty else {
            alertItem = AlertItem(title: "Username Empty", message: "Please add your username", dismissButton: .default(Text("OK")))
            return
        }
        
        print("User: \(self.username)")
        completion?()
    }
    
    public func setupTimer() {
        Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
            .sink { [self] _ in
                runTimer()
            }
            .store(in: &cancellables)
    }
    
    public func runTimer() {
        if threeSecTimer != 0 {
            threeSecTimer -= 1
        } else {
            isShowingThreeSecTimer = false
            
            timeSec -= 1
            
            if timeSec == -1 { // 0 + (1 sec delay)
                self.addPlayer(name: username, kills: numOfKills)
                sortedPlayers = self.sortPlayers()
                
                isShowingMonsters = false // now showing leaderboard
                isFinishedRecording = true
                
                // RESET
                setResetState()
            }
        }
    }
    
    public func setResetState() {
        self.username = ""
        self.numOfKills = 0
        
        isShowingThreeSecTimer = true
        self.threeSecTimer = 3
        self.timeSec = 60
    }
    
    private func sortPlayers() -> [Player] {
        // This is to sort players based on the latest added player
        // in case of the same amount of Kills.
        
        let players = playerEntities.compactMap { playerEntity in
            guard
                let id = playerEntity.id,
                let name = playerEntity.name
            else {
                return Player(id: UUID(), name: "NaN", kills: 99) // FAILED DATA
            }
            
            return Player(id: id, name: name, kills: Int(playerEntity.kills))
        }
        
        let sortedPlayers = players.sorted(by: { $0.kills > $1.kills })
        
        // GET UNIQUE KILLS AMOUNT
        var numOfKillsSet = Set<Int>()

        for player in sortedPlayers {
            numOfKillsSet.insert(player.kills)
        }

        // REVERSED BACK AGAIN DESCENDING
        let numOfKillsList = Array(numOfKillsSet).sorted(by: { $0 > $1 })

        // GROUP SORTING
        var finalSortedPlayers = [Player]()

        for i in numOfKillsList {
            var container = [Player]()
            
            for player in sortedPlayers {
                if player.kills == i {
                    container.append(player)
                }
            }
            
            container.reverse()
            finalSortedPlayers.append(contentsOf: container)
        }
        
        // FINAL SORTED
        return finalSortedPlayers
    }
    
    public func cancelTimer() {
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
    // MARK: CORE DATA
    
    func fetchPlayers() {
        let request = NSFetchRequest<PlayerEntity>(entityName: "PlayerEntity")
        
        do {
            playerEntities = try container.viewContext.fetch(request)
        } catch {
            print("ERROR WHEN FETCHING. \(error)")
        }
    }
    
    func addPlayer(name: String, kills: Int) {
        let player = PlayerEntity(context: container.viewContext)
        player.id = UUID()
        player.name = name
        player.kills = Int32(kills)
        
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchPlayers()
        } catch {
            print("ERROR WHEN SAVING DATA. \(error)")
        }
    }
    
    // MARK: AVFOUNDATION SETUPS
    
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
            
            self.decibelLevelTimer = Timer.scheduledTimer(
                withTimeInterval: 0.01,
                repeats: true
            ) { timer in
                self.audioRecorder.updateMeters()

                let avgPower = self.audioRecorder.peakPower(forChannel: 0)
                
                let offset = self.minimumValue - avgPower
                
                self.power = offset + self.minimumValue
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

