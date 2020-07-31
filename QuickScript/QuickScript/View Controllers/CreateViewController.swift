//
//  CreateViewController.swift
//  QuickScript
//
//  Created by Dahna on 7/27/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

import UIKit
import Speech

class CreateViewController: UIViewController, SFSpeechRecognizerDelegate, UITextFieldDelegate {
    
    // MARK: - Properties
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    let notRecordingImage = UIImage(systemName: "mic.circle")
    let recordingImage = UIImage(systemName: "mic.circle.fill")
    
    var noteController: NoteController?
    var selectedCategory: String?
    
    // MARK: - Outlets
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categorySegControl: UISegmentedControl!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var recordButton: UIButton!
    
    // MARK: - Actions
    @IBAction func recordButtonTapped(_ sender: UIButton) {
        
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            recordButton.isEnabled = false
            recordButton.setImage(notRecordingImage, for: .normal)
            promptLabel.text = "Tap Record to Begin"
        } else {
            try! startRecording()
            recordButton.setImage(recordingImage, for: [])
            promptLabel.text = "Tap Record to stop recording"
        }
    }
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        guard let title = titleTextField.text?.capitalized,
            !title.isEmpty else { return }
        guard let noteText = noteTextView.text,
            !noteText.isEmpty else { return }
        
        let catIndex = categorySegControl.selectedSegmentIndex
        let category = Category.allCases[catIndex]
        
        let note = Note(title: title, date: Date(), category: category, body: noteText)
        
        noteController?.createNote(title: note.title, category: category.rawValue, body: note.body)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: UIViewController
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        
        recordButton.isEnabled = false
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        speechRecognizer.delegate = self
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
  
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.recordButton.isEnabled = true
                    
                case .denied:
                    self.recordButton.isEnabled = false
                    self.recordButton.setTitle("User denied access to speech recognition", for: .disabled)
                    
                case .restricted:
                    self.recordButton.isEnabled = false
                    self.recordButton.setTitle("Speech recognition restricted on this device", for: .disabled)
                    
                case .notDetermined:
                    self.recordButton.isEnabled = false
                    self.recordButton.setTitle("Speech recognition not yet authorized", for: .disabled)
                @unknown default:
                    break
                }
            }
        }
    }
    
    // MARK: - Speech Recognition Function
    
    private func startRecording() throws {
        
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSession.Category.record)
        try audioSession.setMode(AVAudioSession.Mode.measurement)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            
            if let result = result {
                self.noteTextView.text = result.bestTranscription.formattedString
                isFinal = result.isFinal
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.recordButton.isEnabled = true
                self.promptLabel.text = "Tap Record to Begin"
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        try audioEngine.start()
        
        noteTextView.text = "(Recording in session...)"
    }
    
    // MARK: - SFSpeechRecognizerDelegate
    
    public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            recordButton.isEnabled = true
            promptLabel.text = "Start Recording"
        } else {
            recordButton.isEnabled = false
            promptLabel.text = "Recognition not available."
        }
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
