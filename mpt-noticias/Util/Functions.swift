//
//  Functions.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 05/08/23.
//

import Foundation

func formatSubjects(ploneSubjects: [String]) -> String{
    var formatedSubjects: String = ""
    
    // remove tags de controle do portal
    for subject in ploneSubjects{
        if !subject.starts(with: "#"){
            formatedSubjects += subject + ", "
        }
    }
    // retira separador entre tags do final da string
    if formatedSubjects.hasSuffix(", ")  {
        formatedSubjects = String(formatedSubjects.dropLast(2))
    }
    return formatedSubjects
}

func formatDate(ploneDate: String) -> String{
    /* possibilidades:
       Há xx minutos < 1 hora
       Há xx horas   < 24 horas
       Há xx dias    < 30 dias
       Há xx meses  < 12 meses
    */
    var localDate: String = ploneDate
    localDate = localDate.replacingOccurrences(of: "T", with: " ")
    
    //localDate.ranges(of: <#T##RegexComponent#>)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-mm-dd hh:mm:ss"
    print(dateFormatter.date(from: localDate) ?? "")
    return localDate
}
