//
//  PreferencesManager.swift
//  uas_fim_isv_dmn_sp-ud
//
//  Created by Grupo Araysa on 06/10/26.
//

import Foundation

class PreferencesManager {
    private let defaults = UserDefaults.standard
    
    // Claves (Keys)
    private let keyUsername = "key_username"
    private let keyNotifications = "key_notifications"
    private let keyDarkTheme = "key_dark_theme"
    
    // MÉTODOS DE GUARDADO (Escritura)
    func saveSettings(username: String, notifications: Bool, darkTheme: Bool) {
        defaults.set(username, forKey: keyUsername)
        defaults.set(notifications, forKey: keyNotifications)
        defaults.set(darkTheme, forKey: keyDarkTheme)
    }
    
    // MÉTODOS DE CONSULTA (Lectura)
    func getUsername() -> String {
        return defaults.string(forKey: keyUsername) ?? ""
    }
    
    func getNotifications() -> Bool {
        return defaults.bool(forKey: keyNotifications)
    }
    
    func getDarkTheme() -> Bool {
        return defaults.bool(forKey: keyDarkTheme)
    }
    
    // Borrado de preferencias (Para el botón Restablecer)
    func clearPreferences() {
        defaults.removeObject(forKey: keyUsername)
        defaults.removeObject(forKey: keyNotifications)
        defaults.removeObject(forKey: keyDarkTheme)
    }
}
