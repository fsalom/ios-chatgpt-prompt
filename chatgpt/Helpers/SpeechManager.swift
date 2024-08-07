import Speech

@Observable
class SpeechManager {
    private var speechRecognizer = SFSpeechRecognizer()
    private let audioEngine = AVAudioEngine()
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    var transcribedText = ""

    init(){
        let locale = Locale(identifier: "es-ES")
        self.speechRecognizer = SFSpeechRecognizer(locale: locale)
        configureAudioSession()
        setupAudioEngine()
    }

    func startRecording() {
        transcribedText = ""

        SFSpeechRecognizer.requestAuthorization { authStatus in
            switch authStatus {
            case .authorized:
                self.record()
            default:
                print("Speech recognition authorization was denied.")
            }
        }
    }

    func record() {
        do {
            self.request = SFSpeechAudioBufferRecognitionRequest()
            guard let request = self.request else { return }

            request.shouldReportPartialResults = true

            let inputNode = self.audioEngine.inputNode
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                request.append(buffer)
            }

            self.audioEngine.prepare()
            try self.audioEngine.start()

            self.recognitionTask = self.speechRecognizer?.recognitionTask(with: request) { result, error in
                if let result = result {
                    print(result.bestTranscription.formattedString)
                    self.transcribedText = result.bestTranscription.formattedString
                }
                if error != nil || result?.isFinal == true {
                    print(error)
                    self.stopRecording()
                }
            }
        } catch {
            print("There was a problem starting the audio engine: \(error.localizedDescription)")
        }
    }

    func stopRecording() {
        audioEngine.stop()
        request?.endAudio()
        recognitionTask?.cancel()
        request = nil
        recognitionTask = nil
        audioEngine.inputNode.removeTap(onBus: 0)
    }

    func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.record, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Failed to configure audio session: \(error)")
        }
    }

    func setupAudioEngine() {
        let audioEngine = AVAudioEngine()
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)

        print("Sample Rate: \(recordingFormat.sampleRate), Channel Count: \(recordingFormat.channelCount)")

        guard recordingFormat.sampleRate > 0, recordingFormat.channelCount > 0 else {
            print("Invalid recording format detected")
            return
        }

        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            // Handle the audio buffer
        }

        audioEngine.prepare()

        do {
            try audioEngine.start()
        } catch {
            print("AudioEngine failed to start: \(error.localizedDescription)")
        }
    }
}
