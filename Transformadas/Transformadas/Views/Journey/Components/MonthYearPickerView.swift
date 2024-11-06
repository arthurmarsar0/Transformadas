//
//  MonthYearPickerView.swift
//  Transformadas
//
//  Created by Arthur Alves Marsaro on 06/11/24.
//

import SwiftUI
import UIKit

class MonthYearPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var monthPicker: UIPickerView!
    var yearPicker: UIPickerView!
    var onDateSelected: ((String, Int) -> Void)?
    
    let months = [
        "Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
        "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"
    ]
    
    var years: [Int] {
        let currentYear = Calendar.current.component(.year, from: Date())
        return Array(currentYear - 10...currentYear + 10) // De 10 anos atrás até 10 anos à frente
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuração do UIPickerView
        let picker = UIPickerView()
        picker.frame = CGRect(x: 20, y: 100, width: self.view.frame.width - 40, height: 200)
        picker.delegate = self
        picker.dataSource = self
        self.view.addSubview(picker)
        
        // Configuração do layout e estilo
        self.view.backgroundColor = .white
        self.title = "Selecionar Mês e Ano"
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2 // Um para mês e outro para ano
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return months.count // Para o componente mês
        } else {
            return years.count // Para o componente ano
        }
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return months[row] // Exibe o nome do mês
        } else {
            return "\(years[row])" // Exibe o ano
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedMonth = months[pickerView.selectedRow(inComponent: 0)]
        let selectedYear = years[pickerView.selectedRow(inComponent: 1)]
        
        // Mostra a seleção em um formato desejado
        print("Mês: \(selectedMonth), Ano: \(selectedYear)")
        
        // Passa o mês e o ano selecionado para o SwiftUI através da closure
        onDateSelected?(selectedMonth, selectedYear)
    }
    
    
}

struct MonthYearPickerView: UIViewControllerRepresentable {
    @Binding var selectedMonth: String
    @Binding var selectedYear: Int

    func makeUIViewController(context: Context) -> MonthYearPickerViewController {
        let viewController = MonthYearPickerViewController()
        viewController.onDateSelected = { month, year in
            self.selectedMonth = month
            self.selectedYear = year
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: MonthYearPickerViewController, context: Context) {
        // Atualize o controlador aqui se necessário
    }
}
