/*
//  ContentView.swift
//  MyMusic
//
//  Created by David Strube on 2026/09/23.

 TODO:
 1- Fix intermitent issue where the music gets garbled when leaving the app or locking the phone
 2- Add controls to the lock screen using MPRemoteCommandCenter
//
*/

import SwiftUI
import UniformTypeIdentifiers
import AVFoundation
import MediaPlayer

struct AudioTrack: Identifiable {
    // a song in our application
    let id = UUID()
    let name: String
    let url: URL
}

struct ContentView: View {
    // SwiftUI views are driven by state.
    @State private var showingFileImporter = false
    @State private var tracks: [AudioTrack] = []
    @State private var audioPlayer: AVAudioPlayer?
    @State private var currentTrack: AudioTrack?
    @State private var isPlaying = false
    @State private var currentTime: TimeInterval = 0
    @State private var duration: TimeInterval = 0
    @State private var wasPlaying = false
    @State private var isShuffleEnabled = false
    @State private var shuffledTracks: [AudioTrack] = []
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            VStack {
                if tracks.isEmpty {
                    Text("No music imported")
                        .foregroundStyle(.secondary)
                } else {
                    List(tracks) { track in
                        // Displays every imported track
                        Button {
                            play(track)
                        } label: {
                            Text(track.name)
                        }
                    }
                }

                if let currentTrack {
                    VStack(spacing: 12) {
                        Text("Now Playing")
                            .font(.headline)

                        Text(currentTrack.name)
                            .lineLimit(1)
                        
                        Slider(
                            value: Binding(
                                get: {
                                    currentTime
                                },
                                set: { newValue in
                                    audioPlayer?.currentTime = newValue
                                    currentTime = newValue
                                }
                            ),
                            in: 0...max(duration, 0.1)
                        )
                        
                        HStack {
                            Text(formatTime(currentTime))
                            Spacer()
                            Text(formatTime(duration))
                        }
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        
                        HStack {
                            Button("Previous") {
                                playPrevious()
                            }
                            
                            Button(isPlaying ? "Pause" : "Play") {
                                togglePlayPause()
                            }
                            
                            Button("Next") {
                                playNext()
                            }

                            Button("Stop") {
                                stop()
                            }
                        }
                        
                    }
                    .padding()
                }
                
                Button(isShuffleEnabled ? "Shuffle On" : "Shuffle") {
                    toggleShuffle()
                }
                
                Button("Import Music") {
                    showingFileImporter = true
                }
                .padding()
            }
            .navigationTitle("My Music")
            .fileImporter(
                // When the button is clicked, showingFileImporter = true,
                // which puts us here
                 isPresented: $showingFileImporter,
                allowedContentTypes: [.audio],
                allowsMultipleSelection: true
            ) { result in
                handleImport(result)
            }
            .onAppear {
                configureAudioSession()
                loadTracks()
            }
            .onReceive(timer) { _ in
                guard let player = audioPlayer else {
                    return
                }

                currentTime = player.currentTime
                duration = player.duration

                if player.isPlaying {
                    wasPlaying = true
                    isPlaying = true
                } else if wasPlaying {
                    wasPlaying = false
                    isPlaying = false

                    print("Finished: \(currentTrack?.name ?? "Unknown")")
                    
                    playNext()
                }
                
                updateNowPlayingInfo()
            }
        }
    }

    private func handleImport(
        _ result: Result<[URL], Error>
    ) {
        switch result {
        case .success(let urls):
            for url in urls {
                importFile(url)
            }

        case .failure(let error):
            print("Import failed: \(error)")
        }
    }

    private func importFile(_ sourceURL: URL) {
        let fileManager = FileManager.default

        guard let documentsDirectory = fileManager.urls(
            //gets the application's private Documents directory.
            for: .documentDirectory,
            in: .userDomainMask
        ).first else {
            print("Could not find Documents directory.")
            return
        }

        let destinationURL = documentsDirectory
            .appendingPathComponent(sourceURL.lastPathComponent)
        
        // Don't add the same file twice.
        if tracks.contains(where: {
            $0.url.lastPathComponent == sourceURL.lastPathComponent
        }) {
            print("Already imported: \(sourceURL.lastPathComponent)")
            return
        }

        do {
            // This is overkill with the above prevention of duplicates,
            // but handy for when a duplicate was added before the above logic was in place.
            /*if fileManager.fileExists(atPath: destinationURL.path) {
                try fileManager.removeItem(at: destinationURL)
            }*/

            try fileManager.copyItem(
                at: sourceURL,
                to: destinationURL
            )

            let track = AudioTrack(
                name: sourceURL.lastPathComponent,
                url: destinationURL
            )

            tracks.append(track)

            print("Imported: \(sourceURL.lastPathComponent)")
            print("Stored at: \(destinationURL.path)")

        } catch {
            print("Could not import file: \(error)")
        }
    }
    
    private func loadTracks() {
        let fileManager = FileManager.default

        guard let documentsDirectory = fileManager.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else {
            print("Could not find Documents directory.")
            return
        }

        do {
            let files = try fileManager.contentsOfDirectory(
                at: documentsDirectory,
                includingPropertiesForKeys: nil
            )

            let audioFiles = files.filter { url in
                url.pathExtension.lowercased() == "mp3" ||
                url.pathExtension.lowercased() == "m4a" ||
                url.pathExtension.lowercased() == "aac" ||
                url.pathExtension.lowercased() == "wav"
            }

            tracks = audioFiles.map { url in
                AudioTrack(
                    name: url.lastPathComponent,
                    url: url
                )
            }

            print("Loaded \(tracks.count) audio file(s).")

        } catch {
            print("Could not load music library: \(error)")
        }
    }
    
    private func play(_ track: AudioTrack) {
        //let audioSession = AVAudioSession.sharedInstance()

        do {
            /*try audioSession.setCategory(
                .playback,
                mode: .default,
                options: []
            )

            try audioSession.setActive(true)*/
    
            let player = try AVAudioPlayer(contentsOf: track.url)

            player.prepareToPlay()

            if player.play() {
                audioPlayer = player
                currentTrack = track
                isPlaying = true
                wasPlaying = true

                currentTime = 0
                duration = player.duration
                
                // This is part of how the song info can be shown on the lock screen
                updateNowPlayingInfo()

                print("Playing: \(track.name)")
            } else {
                print("Could not start playback: \(track.name)")
            }

        } catch {
            print("Could not play \(track.name): \(error)")
        }
    }
    
    private func playPrevious() {
        guard let currentTrack else {
            return
        }

        let playbackTracks = isShuffleEnabled
            ? shuffledTracks
            : tracks

        guard let currentIndex = playbackTracks.firstIndex(where: {
            $0.id == currentTrack.id
        }) else {
            return
        }

        let previousIndex = currentIndex - 1

        guard previousIndex >= 0 else {
            print("Already at the first track.")
            return
        }

        play(playbackTracks[previousIndex])
    }
    
    private func togglePlayPause() {
        guard let player = audioPlayer else {
            return
        }

        if player.isPlaying {
            player.pause()
            isPlaying = false
            wasPlaying = false
        } else {
            if player.play() {
                isPlaying = true
                wasPlaying = true
            }
        }
        
        updateNowPlayingInfo()
    }
    
    private func playNext() {
        guard let currentTrack else {
            return
        }

        let playbackTracks = isShuffleEnabled
            ? shuffledTracks
            : tracks

        guard let currentIndex = playbackTracks.firstIndex(where: {
            $0.id == currentTrack.id
        }) else {
            return
        }

        let nextIndex = currentIndex + 1

        guard nextIndex < playbackTracks.count else {
            print("Reached the end of the playlist.")
            isPlaying = false
            currentTime = duration
            return
        }

        play(playbackTracks[nextIndex])
    }
    
    private func stop() {
        audioPlayer?.stop()
        // Reset the song back to its beginning
        audioPlayer?.currentTime = 0
        currentTime = 0
        isPlaying = false
        wasPlaying = false
        
        updateNowPlayingInfo()
    }
    
    private func toggleShuffle() {
        isShuffleEnabled.toggle()

        if isShuffleEnabled {
            shuffledTracks = tracks.shuffled()

            print("Shuffle enabled.")
        } else {
            shuffledTracks.removeAll()

            print("Shuffle disabled.")
        }
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
        let totalSeconds = Int(time)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60

        return String(format: "%d:%02d", minutes, seconds)
    }
    
    private func updateNowPlayingInfo() {
        guard let currentTrack,
              let player = audioPlayer else {
            return
        }

        var nowPlayingInfo = [String: Any]()

        nowPlayingInfo[MPMediaItemPropertyTitle] = currentTrack.name
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = player.duration
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player.currentTime
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] =
            player.isPlaying ? 1.0 : 0.0

        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    private func configureAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()

        do {
            try audioSession.setCategory(
                .playback,
                mode: .default,
                options: []
            )

            try audioSession.setActive(true)

            print("Audio session configured.")
            print("Category: \(audioSession.category.rawValue)")
            print("Mode: \(audioSession.mode.rawValue)")
            print("Sample rate: \(audioSession.sampleRate)")
            print("Output channels: \(audioSession.outputNumberOfChannels)")
            print("Current route: \(audioSession.currentRoute)")
        } catch {
            print("Could not configure audio session: \(error)")
        }
    }
}

