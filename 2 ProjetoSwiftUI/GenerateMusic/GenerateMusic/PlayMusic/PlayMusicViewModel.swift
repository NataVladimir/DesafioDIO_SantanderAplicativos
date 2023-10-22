//
//  PlayMusicViewModel.swift
//  GenerateMusic
//
//  Created by test on 22/10/23.
//

import Foundation
import Foundation
import Firebase
import AVFAudio
import FirebaseStorage

class CancaoTFMVIewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    @Published var liked = false
    @Published var slider: Double = 0
    @Published var isPlaying = true
 
    @Published var currentAudioTime: String = "00:00"
    
    var audioID: String?

    
    @Published var text: String = ""
    @Published var audioData: Data?
    
    @Published private var audioPlayer: AVAudioPlayer?
    @Published var audioDuration: Double = 0
    private var audioTimer: Timer?
    
    let networkManager = NetworkManager()
    
    @Published var progressView: Bool = false
    
    init(text: String) {
            self.text = text
            super.init()
        print("Texto recebido: \(text)") // Linha de depuração
            self.requisiçãoDoAudio()
        }
    
    
    func convertTime(time: Double) -> String {
        let totalSeconds = Int(time)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func updateCurrentAudioTime() {
        if let currentTime = audioPlayer?.currentTime {
            currentAudioTime = convertTime(time: currentTime)
        }
    }
    
    
    // MARK: -- FUNC ONDE RESPONSAVEL POR TOCAR AUDIO CARREGADO --
    func playAudio() {
        // Verificando se ainda não foi inicializado
        if audioPlayer == nil {
            guard let audioData = audioData else { return }
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                
                audioPlayer = try AVAudioPlayer(data: audioData)
                audioPlayer?.delegate = self // Adicionando o delegate
                
                audioDuration = audioPlayer?.duration ?? 0
            } catch {
                print("Error playing audio: \(error)")
                return
            }
        }
        
        if audioPlayer?.isPlaying == false {
            audioPlayer?.play()
            // Inicie o Timer para atualizar o valor do Slider
            audioTimer?.invalidate()  // Primeiro, invalide qualquer Timer existente
            audioTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
                self?.updateCurrentAudioTime()
                if let currentTime = self?.audioPlayer?.currentTime {
                    self?.slider = currentTime
                }
            }
        }
    }
    
    // MARK:  -- UPLOADAUDIO NO FIREBASE STORAGE --
    func uploadAudioToFirebase() {
        guard let audioData = audioData else {
            print("No audio data available")
            return
        }
        
        let audioID = UUID().uuidString
        self.audioID = audioID
        let storageRef = Storage.storage().reference().child("audios/\(audioID).mp3")
        storageRef.putData(audioData, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
                print("Error uploading audio: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            storageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print("Error getting download URL: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                let data: [String: Any] = [
                    "id": audioID,
                    "downloadURL": downloadURL.absoluteString,
                    "userID": Auth.auth().currentUser?.uid ?? ""
                ]
                
                Firestore.firestore().collection("audios").addDocument(data: data) { error in
                    if let error = error {
                        print("Error saving audio to Firestore: \(error)")
                    } else {
                        print("Audio uploaded and saved successfully!")
                    }
                }
            }
        }
    }
    
    // MARK: -- REQUISIÇÃO NA API PARA GERAR AUDIO --
    func requisiçãoDoAudio() {
        networkManager.fetchTTSData(text: text) { data in
            DispatchQueue.main.async {
                self.audioData = data
                print("Requisição feita")
                print(self.audioData == nil)
            }
        }
    }
    
    // MARK: -- REQUISIÇÃO CHAT GPT ---
    
    func stopAudio() {
        audioPlayer?.stop()
        audioTimer?.invalidate() // Pare o Timer quando o áudio for parado
    }
    
    func pauseAudio() {
        audioPlayer?.pause()
        audioTimer?.invalidate() // Pare o Timer quando o áudio for pausado
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            audioPlayer = nil // Destruindo o player ao terminar de tocar
            isPlaying = false // Atualizando o estado de reprodução
            audioTimer?.invalidate() // Parando o Timer
            slider = 0.0 // Reiniciando o slider
            currentAudioTime = "00:00" // Reiniciando o tempo atual do áudio
        }
    }
}
