//
//  FormScreen.swift
//  uas_fim_isv_dmn_sp-ud
//
//  Created by Grupo Araysa on 06/10/26.
//

import SwiftUI

struct FormScreen: View {
    private let preferencesManager = PreferencesManager()
    
    // Estados locales
    @State private var username: String = ""
    @State private var notificationsEnabled: Bool = false
    @State private var darkThemeEnabled: Bool = false
    
    // Mensaje del Toast
    @State private var toastMessage: String? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Práctica 5: Configuración")
                .font(.title2)
                .fontWeight(.bold)
            
            Divider()
            
            // 1. Campo de texto para el Usuario
            VStack(alignment: .leading, spacing: 5) {
                Text("Nombre de Usuario")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                TextField("Escribe tu nombre", text: $username)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.sentences) // <--- Solo la primera letra en mayúscula
                    .autocorrectionDisabled(true)             // Opcional: evita que la autocorrección cambie los nombres
            }
            
            // 2. Switch para Notificaciones
            Toggle("Recibir Notificaciones:", isOn: $notificationsEnabled)
                .font(.body)
            
            // 3. Switch para Tema Oscuro
            Toggle("Activar Tema Oscuro:", isOn: $darkThemeEnabled)
                .font(.body)
            
            Spacer().frame(height: 10)
            
            // Botón: Guardar Preferencias
            Button(action: {
                preferencesManager.saveSettings(
                    username: username,
                    notifications: notificationsEnabled,
                    darkTheme: darkThemeEnabled
                )
                showToast(message: "Configuración guardada")
            }) {
                Text("Guardar Preferencias")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(12)
            }
            
            // Botón: Recargar Datos Guardados
            Button(action: {
                loadPreferences()
                showToast(message: "Preferencias cargadas")
            }) {
                Text("Recargar Datos Guardados")
                    .font(.headline)
                    .foregroundColor(.purple)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.purple, lineWidth: 1.5)
                    )
            }
            
            // Botón: Restablecer Configuración
            Button(action: {
                preferencesManager.clearPreferences()
                username = ""
                notificationsEnabled = false
                darkThemeEnabled = false
                showToast(message: "Preferencias eliminadas")
            }) {
                Text("Restablecer Configuración")
                    .font(.body)
                    .foregroundColor(.red)
            }
            
            Spacer()
        }
        .padding(24)
        .preferredColorScheme(darkThemeEnabled ? .dark : .light) // Cambio de tema dinámico
        .onAppear {
            loadPreferences()
        }
        .overlay(
            Group {
                if let message = toastMessage {
                    VStack {
                        Spacer()
                        Text(message)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Capsule().fill(Color.black.opacity(0.8)))
                            .padding(.bottom, 30)
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        )
    }
    
    private func loadPreferences() {
        username = preferencesManager.getUsername()
        notificationsEnabled = preferencesManager.getNotifications()
        darkThemeEnabled = preferencesManager.getDarkTheme()
    }
    
    private func showToast(message: String) {
        withAnimation {
            toastMessage = message
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation {
                toastMessage = nil
            }
        }
    }
}

#Preview {
    FormScreen()
}
