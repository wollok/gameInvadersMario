import wollok.game.*

/** First Wollok example */
object juego {
	method iniciar() {
		
		game.addVisualCharacter(mario)
		
		
		game.onCollideDo(mario,{algo=> algo.teAgarroMario()})
		
		self.generarIvasores()
		self.generarMonedas()
		
	}
	method generarIvasores() {
		game.onTick(1000,"aparece invasor",{new Invasor().aparecer()}) 
	}
	
	method generarMonedas() {
		game.schedule(500,{self.generarMoneda(100)}) 
	}
	method generarMoneda(valor) {
		const moneda = new Moneda(valor = valor) 
		game.addVisual(moneda)
		moneda.animarse() 
	}
	
}


object mario {
	
	var puntos // vida, etc
	
	method aumentar(){}
	
}

class Invasor {
	method teAgarroMario() {
		// perder - sacar vida
	}
	
	method aparecer(){
		game.addVisual(self)
		self.moverseAleatoriamente()
	}
	
	method moverseAleatoriamente(){}
	
}


class Moneda {
	var valor
	method teAgarroMario() {
	//ganar - sumar puntos
	}
	 
	method animarse(){}
}