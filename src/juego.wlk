import wollok.game.*

/** First Wollok example */
object juego {
	method iniciar() {
		
		game.width(20)
		game.height(14)
		game.addVisualCharacter(mario)
		
		
		game.onCollideDo(mario,{algo=> algo.teAgarroMario()})
		
		self.generarIvasores()
		self.generarMonedas()
//		game.schedule(20000,{game.removeTickEvent("aparece invasor")})
		keyboard.enter().onPressDo({game.removeTickEvent("aparece invasor")})
		
	}
	method generarIvasores() {
		game.onTick(1000,"aparece invasor",{new Invasor().aparecer()}) 
	}
	
	method generarMonedas() {
		game.schedule(500,{self.generarMoneda(100)}) 
	}
	method generarMoneda(valor) {
		const pos = self.posicionAleatoria()
		const moneda = new Moneda(position = pos, valor = valor) 
		game.addVisual(moneda)
		moneda.animarse() 
	}
	method posicionAleatoria() = game.at(
		0.randomUpTo(game.width()),
		0.randomUpTo(game.height())
	)
	
}


object mario {
	var property position = game.center()
	var puntos = 0
	var vidas = 5
	
	method aumentar(valor){ 
		puntos += valor
	}
	method puntaje() = puntos
	method image() = "mario.png" 
	
	method perderVida() {
		vidas -=1
	}
	method vidas() = vidas
	
//	method position() = position 
//	method position(nueva) {
//		position = nueva
//	}
	
	
}

class Invasor {
	var position = null
	
	method teAgarroMario() {
		mario.perderVida()
		game.say(mario,"Me quedan " + mario.vidas() + " vidas")
		self.desaparecer()
	}
	
	method aparecer(){
		position = juego.posicionAleatoria()
		game.addVisual(self)
		self.moverseAleatoriamente()
		game.schedule(5000,{self.desaparecer()})	
	}
	
	method moverseAleatoriamente(){}
	
	method position() = position
	method image() = "invasor.png"
	
	method desaparecer() {
		if(game.hasVisual(self))
			game.removeVisual(self) 
	}
}


class Moneda {
	var image = "moneda.jpg"
	var valor
	const position
	
	method teAgarroMario() {
		mario.aumentar(valor)
		game.say(mario,mario.puntaje().toString())
		game.removeVisual(self)
		juego.generarMoneda(valor*2)
	}
	 
	method image() = image
	method animarse(){}
	method position() = position
}