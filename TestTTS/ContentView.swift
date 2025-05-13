//
//  ContentView.swift
//  TestTTS
//
//  Created by apple on 5/13/25.
//

import SwiftUI
import MLXSwiftTTS
struct ContentView: View {

    @State private var kokoroTTSModel: KokoroTTSModel? = nil
    @State private var orpheusTTSModel: OrpheusTTSModel? = nil

    @State private var sayThis : String = "Hello Everybody"
    @State private var status : String = ""

    var body: some View {
        VStack {
            Image(systemName: "mouth")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("TTS Examples")
                .font(.headline)
                .padding()

            TextField("Enter text", text: $sayThis)

            Button("Kokoro") {
                Task {
                    status = "Generating..."
                    if kokoroTTSModel == nil {
                        kokoroTTSModel = KokoroTTSModel()
                    }
                    await kokoroTTSModel!.say(sayThis, .bmGeorge)
                    status = "Done"
                }
            }

            Button("Orpheus") {
                Task {
                    status = "Generating..."
                    if orpheusTTSModel == nil {
                        orpheusTTSModel = MLXSwiftTTS.OrpheusTTSModel()
                    }
                    await orpheusTTSModel!.say(sayThis, .tara)
                    status = "Done"
                }
            }
            .disabled(true) // Disable the button as it's still WIP

            Text(status)
                .font(.caption)
                .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
