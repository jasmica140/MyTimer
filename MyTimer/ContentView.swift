//
//  ContentView.swift
//  MyTimer
//
//  Created by Jasmine Micallef on 22/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var vm = ViewModel()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 250
    
    var body: some View {
        
        ZStack {
            Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                .ignoresSafeArea()
            content
        }
    }
    
    var content: some View {
        
        VStack(spacing: 20){
            
            ZStack {
                
                Circle()
                    .stroke(lineWidth: 20)
                    .foregroundColor(.gray)
                    .opacity(0.1)
                
                Circle()
                    .trim(from: 0.0, to: min(CGFloat(vm.seconds), 1.0))
                    .stroke(AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3349274397, green: 0.3337651491, blue: 0.7736441493, alpha: 1)), Color(#colorLiteral(red: 0.5472646952, green: 0.3784973323, blue: 0.770352006, alpha: 1)), Color(#colorLiteral(red: 0.7935088277, green: 0.4518128633, blue: 0.7316951752, alpha: 1)), Color(#colorLiteral(red: 0.3108555079, green: 0.708450973, blue: 0.8780270219, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.980586946, blue: 0.9457913041, alpha: 1)), Color(#colorLiteral(red: 0.3349274397, green: 0.3337651491, blue: 0.7736441493, alpha: 1))]), center: .center), style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                    .rotationEffect((Angle(degrees: 270)))
                    .animation (.easeInOut (duration: 1.0), value: vm.seconds)
                
                VStack{
                    
                    Text("\(vm.time)")
                        .font(.system(size: 35, weight: .light, design: .rounded))
                        .opacity(0.7)
                        .alert("Timer done!", isPresented: $vm.showingAlert){
                            Button("Continue", role: .cancel){
                                vm.keepVibrate = false
                            }
                        }
                        .frame(height: 100)
                        .padding(.top, 30)
                    
                    Text("\(vm.endTime, format: .dateTime.hour().minute())")
                        .font(.system(size: 15, weight: .light, design: .rounded))
                        .opacity(0.7)
                }
            }
            .frame(width: 250, height: 250)
            .padding(.bottom,75)

            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .stroke(AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3349274397, green: 0.3337651491, blue: 0.7736441493, alpha: 1)), Color(#colorLiteral(red: 0.5472646952, green: 0.3784973323, blue: 0.770352006, alpha: 1)), Color(#colorLiteral(red: 0.7935088277, green: 0.4518128633, blue: 0.7316951752, alpha: 1)), Color(#colorLiteral(red: 0.3108555079, green: 0.708450973, blue: 0.8780270219, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.980586946, blue: 0.9457913041, alpha: 1)), Color(#colorLiteral(red: 0.3349274397, green: 0.3337651491, blue: 0.7736441493, alpha: 1))]), center: .center), style: StrokeStyle(lineWidth: 2.0, lineCap: .round, lineJoin: .round))
                
                HStack(spacing: 15) {
                    Picker(selection: $vm.hours, label: Text("Hours")) {
                        ForEach(0...23, id: \.self) {
                            Text("\($0) hr")
                        }
                    }
                    Picker(selection: $vm.minutes, label: Text("Minutes")) {
                        ForEach(0...59, id: \.self) {
                            Text("\($0) min")
                        }
                    }
                    Picker(selection: $vm.seconds, label: Text("Seconds")) {
                        ForEach(0...59, id: \.self) {
                            Text("\($0) sec")
                        }
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .disabled(vm.isActive)
                .cornerRadius(20)
            }
            .frame(width: 280, height: 50)
            .padding(.bottom, 75)
            
            
            VStack(spacing: 30){
                HStack(spacing: 50){
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3349274397, green: 0.3337651491, blue: 0.7736441493, alpha: 1)), Color(#colorLiteral(red: 0.5472646952, green: 0.3784973323, blue: 0.770352006, alpha: 1)), Color(#colorLiteral(red: 0.7935088277, green: 0.4518128633, blue: 0.7316951752, alpha: 1)), Color(#colorLiteral(red: 0.3108555079, green: 0.708450973, blue: 0.8780270219, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.980586946, blue: 0.9457913041, alpha: 1)), Color(#colorLiteral(red: 0.3349274397, green: 0.3337651491, blue: 0.7736441493, alpha: 1))]), center: .center), style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
                        
                        Button("Start"){
                            vm.start(hours: vm.hours, minutes: vm.minutes, seconds: vm.seconds)
                        }
                        .disabled(vm.isActive)
                        .padding()
                    }
                    .frame(width: 80, height: 50)
                    .cornerRadius(50)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3349274397, green: 0.3337651491, blue: 0.7736441493, alpha: 1)), Color(#colorLiteral(red: 0.5472646952, green: 0.3784973323, blue: 0.770352006, alpha: 1)), Color(#colorLiteral(red: 0.7935088277, green: 0.4518128633, blue: 0.7316951752, alpha: 1)), Color(#colorLiteral(red: 0.3108555079, green: 0.708450973, blue: 0.8780270219, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.980586946, blue: 0.9457913041, alpha: 1)), Color(#colorLiteral(red: 0.3349274397, green: 0.3337651491, blue: 0.7736441493, alpha: 1))]), center: .center), style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
                        
                        
                        Button("Reset", action: vm.reset)
                            .padding()
                            .cornerRadius(50)
                    }
                    .frame(width: 80, height: 50)
                    .cornerRadius(50)
                }
                .frame(width: width, height: 50)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3349274397, green: 0.3337651491, blue: 0.7736441493, alpha: 1)), Color(#colorLiteral(red: 0.5472646952, green: 0.3784973323, blue: 0.770352006, alpha: 1)), Color(#colorLiteral(red: 0.7935088277, green: 0.4518128633, blue: 0.7316951752, alpha: 1)), Color(#colorLiteral(red: 0.3108555079, green: 0.708450973, blue: 0.8780270219, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.980586946, blue: 0.9457913041, alpha: 1)), Color(#colorLiteral(red: 0.3349274397, green: 0.3337651491, blue: 0.7736441493, alpha: 1))]), center: .center), style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
                    
                    
                    Button("Pause", action: vm.pause)
                        .padding()
                        .cornerRadius(50)
                }
                .frame(width: 80, height: 50)
                .cornerRadius(50)
            }
            .font(.system(size: 15, weight: .light, design: .rounded))
            .padding(.bottom,20)
            .frame(width: 100, height: 120)


     
        }
        .foregroundColor(.white)
        .onReceive(timer) { _ in
            vm.updateCountDown()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
