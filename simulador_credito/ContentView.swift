//
//  ContentView.swift
//  BottomSheet
//
//  Created by Giordano Bruno on 31/05/23.
//

import SwiftUI


struct ContentView: View {
    
    @State var offset: CGFloat = 0
    @State var translation: CGSize = CGSize(width: 0, height: 0)
    @State var location: CGPoint = CGPoint(x: 0, y: 0)
// Preciso armazenar as informacoes que o usuario vai inserir em valor desejado e prazo
    @State var valorDesejado = ""
    @State var prazo = ""
    
    @State var numero = ""
    @State var valorJuros = ""
    @State var valorPrestacao = ""
    

   
    
    
    
var body: some View {
     
    ZStack(alignment: Alignment (horizontal: .center, vertical: (.bottom))) {
        VStack(alignment: .leading) {
            
            //             Colocar text field aqui
            
            
            Text("EMPRÉSTIMO - CDC")
                .font(.custom("futura", size: 20).bold())
                .foregroundColor(Color("grafite"))
                .padding(.top, 50)
                .padding(.leading, 30)
            
            Spacer()
                .frame(height: 30)
            
            Text("Tá precisando de uma graninha? Informe o valor que deseja receber e em quantas prestações você deseja pagar:")
                .font(.custom("futura", size: 18))
                .foregroundColor(Color("grafite"))
                .padding(.horizontal, 30)
            
            
            
            Text("valor")
                .font(.custom("futura", size: 14))
                .foregroundColor(Color("grafite"))
                .frame(maxWidth: .infinity)
                .padding(.top, 30)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            
            TextField("digite", text: $valorDesejado)
                .font(.custom("futura", size: 20))
                .foregroundColor(Color("grafite"))
            
                .padding(.vertical, 5)
            
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color("tangerina"), lineWidth: 1)
                        .padding(.horizontal, 35)
                    
                    
                )
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            
            
            
            
            Text("prazo")
                .font(.custom("futura", size: 14))
                .foregroundColor(Color("grafite"))
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .padding(.top, 30)
            
            
            TextField("digite", text: $prazo)
                .font(.custom("futura", size: 20))
                .foregroundColor(Color("grafite"))
                .padding(.vertical, 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color("tangerina"), lineWidth: 1)
                        .padding(.horizontal, 150)
                )
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            Spacer()
            
            
        }
        .frame (maxHeight: .infinity)
        .background(Color("porcelana"))
        .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        //     .navigationTitle("emprestimo")
        
        
    
          
          
            
            
            
            
            
            
//Configuração do Drawer
            
            GeometryReader { reader in
                BottomSheet(valorDesejado: valorDesejado)
                    .offset(y: reader.frame (in: .global) .height - 100)
                    .offset(y: offset)
                    .gesture(DragGesture() .onChanged({ (value) in withAnimation {
                        translation = value.translation
                        location = value.location
                        
                        if value.startLocation.y > reader.frame(in: .global).midX {
                            if value.translation.height < 0 && offset > (-reader.frame (in: .global).height + 100) {
                                offset = value.translation.height
                                
                            }
                        }
                        
                        if value.startLocation.y < reader.frame (in: .global).midX {
                            if value.translation.height > 0 && offset < 0 {
                                offset = (-reader.frame (in: .global).height + 100) +
                                value.translation.height
                            }
                        }
                    }
                    }).onEnded ({ (value) in
                        withAnimation {
                            if value.startLocation.y > reader.frame(in: .global).midX {
                                if -value.translation.height > reader.frame(in: .global).midX {
                                    offset = (-reader.frame (in: .global).height + 100)
                                    return
                                }
                                offset = 0
                            }
                            
                            if value.startLocation.y < reader.frame (in: .global).midX {
                                if value.translation.height < reader.frame (in: .global).midX {
                                    offset = (-reader.frame (in: .global).height + 100)
                                    return
                                }
                                offset = 0
                                
                            }
                            
                        }
                    }))
            }
        }
        
    }
    
}



// View Snapping Drawer

struct BottomSheet: View {
    var valorDesejado: String
    

 var body: some View {
        VStack {
            
//Imagem da barrinha
            Capsule()
                .fill(Color ("porcelana"))
                .frame (width: 50, height: 5)
            

//Conteúdo do drawer
// Preciso informar o valor e prestacao informados pelo cliente nessa view. Não consigo puxar informação...
            ScrollView(.vertical, showsIndicators: false, content: {
                LazyVStack() {
                        Spacer()
                    HStack(){
                        Text ("valor")
                            .padding(.leading)
                            .font(.custom("futura", size: 14))
                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)


                        Text ("prestação")
                            .padding(.leading)
                            .font(.custom("futura", size: 14))
                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    
                    }
                    
                    
                    
                    Spacer()
               //         .frame(height: 50 )
                    
                    HStack(alignment: .center, spacing: 200){
                        Text (valorDesejado)
                            .padding(.leading)
                            .font(.custom("futura", size: 24).bold())
                            .foregroundColor(Color("tangerina"))

                        
                        Text ("200")
                            .padding(.trailing)
                            .font(.custom("futura", size: 24).bold())
                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    
                    }
                    Text ("100x")
                        .padding(.leading)
                        .padding(.bottom, 300)
                        .font(.custom("futura", size: 10).bold())
                        .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                   
                    Spacer()
                        .frame(height: 50 )
                    HStack(){
                        Image (systemName: "arrow.down.to.line.circle.fill")
                            .aspectRatio(contentMode: .fit)
                            
            
                        Text ("Salvar simulação")
                    }
                    .multilineTextAlignment(.center)
                    .padding(.leading)
                    .font(.custom("futura", size: 16))
                    .foregroundColor(Color("porcelana"))
                    
                        Spacer()
                            .frame(height: 50 )
                 
                    Text ("Para essa contratação você não pode ter mais que 30% da sua renda comprometida")
                   
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .font(.custom("futura", size: 14))
                        .foregroundColor(Color("porcelana"))
                    
                }

            })
            
        }
        .padding (.horizontal, 20)
        .padding (.bottom, 50)
        .padding (.top, 20)
        .background(Color("azul"))
        
//        .background(BlurShape()) - Está causando bug no scroll
        
    }
        
}



struct Contentview_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



//HStack(alignment: .center, spacing: 200){
