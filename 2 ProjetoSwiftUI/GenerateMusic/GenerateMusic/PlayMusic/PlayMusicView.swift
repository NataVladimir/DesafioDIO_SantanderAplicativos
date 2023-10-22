//
//  PlayMusicView.swift
//  GenerateMusic
//
//  Created by test on 22/10/23.
//

import Foundation
import SwiftUI
import Foundation

fileprivate let HORIZONTAL_SPACING: CGFloat = 24

struct CancanTFMView: View {
    
    @StateObject var viewModel: CancaoTFMVIewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var isSheetPresentd: Bool = false
    
    var body: some View {
        VStack{
            ZStack{
                VStack(alignment: .center, spacing: 0) {
                    HStack(alignment: .center) {
                        
                        Spacer()
                        Button(action: {
                            isSheetPresentd = true
                        }) {
                            Image(systemName: "sun.max.fill").resizable().frame(width: 16, height: 16)
                                .padding(12).background(Color.gray)
                                .cornerRadius(20)
                        }
                        .sheet(isPresented: $isSheetPresentd, content: {
                            SavedSongsView(viewModel: SavedSongsViewModel())
                        })
                        
                    }.padding(.horizontal, HORIZONTAL_SPACING).padding(.top, 12)
                    
                    Text("Audio gerado").foregroundStyle(Color.init(red: 208 / 255, green: 210 / 255, blue: 220 / 255))
                        .font(.title)
                        .bold()
                    
                    
                    if viewModel.audioData != nil {
                        
                        ScrollView(.vertical, showsIndicators: false){
                            Text(viewModel.text).foregroundColor(Color.black)
                               
                                .padding()
                                .padding(.top, 12)
                            
                        }.padding(.top, 20)
                            .padding(.bottom, 20)
                    }else{
                        ProgressView()
                            .scaleEffect(2.5)
                            .frame(maxHeight: 300)
                            .foregroundColor(Color.black)
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.init(red: 208 / 255, green: 210 / 255, blue: 220 / 255)))
                        Text("Gerando musica...")
                            .foregroundColor(Color.init(red: 208 / 255, green: 210 / 255, blue: 220 / 255))
                            .bold()
                    }
                
                    Spacer()
                    
                    HStack(alignment: .center, spacing: 12) {
                        
                        //Timer
                        Text(viewModel.currentAudioTime).foregroundColor(Color.init(red: 208 / 255, green: 210 / 255, blue: 220 / 255))
                
                        
                        //Slider
                        Slider(value: $viewModel.slider, in: 0...viewModel.audioDuration)
                            .accentColor(.white)
                        
                        //Button Salvar
                        Button(action: {
                            viewModel.liked.toggle()
                            if viewModel.liked {
                                viewModel.uploadAudioToFirebase()
                            }
                        }) {
                            (viewModel.liked ? Image(systemName: "heart.fill") : Image(systemName: "heart"))
                                .resizable().frame(width: 20, height: 20)
                        }
                    }.padding(.horizontal, 45)
                        .padding(.bottom, 20)
                    
                    HStack(alignment: .center) {

                        
                        Button(action: {
                            viewModel.playAudio()
                        }) {
                            Image(systemName: "goforward")
                                .frame(width: 18, height: 18)
                                .foregroundColor(.white)
                                .rotationEffect(Angle(degrees: 180))
                                .bold()
                                .padding(24).background(Color.black)
                                .cornerRadius(40)
                        }
                        
                        Spacer()
                        
                        //Play and Pause
                        Button(action: { viewModel.isPlaying.toggle()
                            if viewModel.isPlaying == false{
                                viewModel.playAudio()
                            }else{
                                viewModel.pauseAudio()
                            }
                        }) {
                            (viewModel.isPlaying ? Image(systemName: "play.fill") : Image(systemName: "pause.fill"))
                                .resizable().frame(width: 28, height: 28)
                                .padding(50).background(Color.black)
                                .cornerRadius(70)
                                
                        }.disabled(viewModel.audioData == nil)
                        Spacer()
                        
                        Button(action: {
                        }) {
                            Image(systemName: "playpause.fill")
                                .frame(width: 18, height: 18)
                                .foregroundColor(.white)
                                .padding(24).background(Color.black)
                                .cornerRadius(40)
                        }.disabled(viewModel.audioData == nil)
                    }.padding(.horizontal, 32)
                    
                }.padding(.bottom, HORIZONTAL_SPACING)
                    .animation(.spring(), value: HORIZONTAL_SPACING)
                
            }
            
        }.background(Color.init(red: 208 / 255, green: 210 / 255, blue: 220 / 255))
    }
}



struct CancanTFMView_Previews: PreviewProvider {
    static var previews: some View {
        CancanTFMView(viewModel: CancaoTFMVIewModel(text: "Olá mundo"))
    }
}
