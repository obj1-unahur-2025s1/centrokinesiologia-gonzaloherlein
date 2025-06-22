class Paciente{
  var edad
  var nivelDeFortaleza
  var nivelDeDolor

  method puedeUsar(unAparato) = unAparato.puedeUsarse(self)

  method disminuirNivelDeDolor(nuevoNivelDeDolor){
    nivelDeDolor -= nuevoNivelDeDolor
  }

  method aumentarNivelDeFortaleza(nuevoNivelDeFortaleza){
    nivelDeFortaleza += nuevoNivelDeFortaleza
  }

  method nivelDeDolor() = nivelDeDolor

  method nivelDeFortaleza() = nivelDeFortaleza

  method edad() = edad

  method usarAparato(unAparato){
    if(self.puedeUsar(unAparato)){
      unAparato.usarse(self)
    }
  }
}

class Magneto{
  method puedeUsarse(unPaciente) = true

  method usarse(unPaciente){
    unPaciente.disminuirNivelDeDolor(unPaciente.nivelDeDolor() * 0.10)
  }
}

class Bicicleta{
  method puedeUsarse(unPaciente) = unPaciente.edad() > 8

  method usarse(unPaciente){
    unPaciente.disminuirNivelDeDolor(4)
    unPaciente.aumentarNivelDeFortaleza(3)
  }
}

class Minitramp{
  method puedeUsarse(unPaciente) = unPaciente.nivelDeDolor() < 20

  method usarse(unPaciente){
    unPaciente.aumentarNivelDeFortaleza(unPaciente.edad() * 0.10)
  }
}