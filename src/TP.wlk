object chasqui
{
	var property mensajesEnviados = 0
	
	method puedeEnviarMensaje(mensaje)
	{
		return mensaje.size() < 50
	}
	
	method costeMensaje(mensaje)
	{
		return 2*mensaje.size()
	}
	
	method incrementarContadorMensajes()
	{
		mensajesEnviados += 1
	}
}

object sherpa
{
	//Lo defino como property ya que puede cambiar a futuro
	var property costePorMensaje = 60
	var property mensajesEnviados = 0
	
	method puedeEnviarMensaje(mensaje)
	{
		return mensaje.size().even()
	}
	
	method costeMensaje()
	{
		return costePorMensaje
	}
	
	method incrementarContadorMensajes()
	{
		mensajesEnviados += 1
	}
}

object messich
{
	var property multiplicadorCoste = 10
	var property mensajesEnviados = 0
	
	method puedeEnviarMensaje(mensaje)
	{
		return mensaje.take(1) != 'a'
	}
	
	method costeMensaje(mensaje)
	{
		return multiplicadorCoste * (mensaje.split(" ").size())
	}
	
	method incrementarContadorMensajes()
	{
		mensajesEnviados += 1
	}
}

object pali
{
	var property mensajesEnviados = 0
	
	method puedeEnviarMensaje(mensaje)
	{
		const mensajeSinEspacios = mensaje.replace(" ", "")
		return mensajeSinEspacios.toLowerCase() == mensajeSinEspacios.toLowerCase().reverse()
	}
	
	method costeMensaje(mensaje)
	{
		return (4 * mensaje.size()).min(80)
	}
	
	method incrementarContadorMensajes()
	{
		mensajesEnviados += 1
	}
}

object numeroAleatorio
{
	method generarEntre(min, max)
	{
		return new Range(start = min, end = max).anyOne()
	}
}

object pichca
{
	var property mensajesEnviados = 0
	
	method puedeEnviarMensaje(mensaje)
	{
		return (mensaje.split(" ")).size() > 3
	}
	
	method costeMensaje(mensaje)
	{
		return mensaje.size() * numeroAleatorio.generarEntre(3, 7)
	}
	
	method incrementarContadorMensajes()
	{
		mensajesEnviados += 1
	}
}

//Mensajero estandar
class Mensajero
{
	var property sector
	var property mensajesEnviados = 0
	
	method puedeEnviarMensaje(mensaje)
	{
		return mensaje.size() >= 20
	}
	
	method costeMensaje(mensaje)
	{
		return (mensaje.split(" ")).size() * sector.cuantoCobra()
	}
	
	method incrementarContadorMensajes()
	{
		mensajesEnviados += 1
	}
}

object enviosRapidos
{
	var property cuantoCobra = 20
}

object enviosEstandares
{
	var property cuantoCobra = 15
}

object enviosVIP
{
	var property cuantoCobra = 30
}

class Sectores
{
	var property cuantoCobra
}


object agenciaDeMensajeria
{
	var property mensajeros = [chasqui, sherpa, messich, pali]
	var property mensajerosReceptores = []
	var property mensajesEnviados = []
	var property totalPagado = 0
	
	method quienEnvia(mensaje)
	{
		const puedenEnviar = mensajeros.filter({ mensajero => mensajero.puedeEnviar(mensaje) })
		if(puedenEnviar.isEmpty())
		{
			self.error("Ninguno de los mensajeros puede enviar el mensaje")
		}
		return (puedenEnviar.sortedBy{ mensajeroA, mensajeroB => mensajeroA.costeMensaje(mensaje) < mensajeroB.costeMensaje(mensaje) }).get(0)
	}

	method recibirMensaje(mensaje)
	{
		const mensajero = self.quienEnvia(mensaje)
		
		if(mensaje == "")
		{
			self.error("El mensaje a enviar esta vacio")
		}
		
		mensajesEnviados.add(mensaje)
		mensajerosReceptores.add(mensajero)
		totalPagado += mensajero.costoMensaje(mensaje)
		mensajero.incrementarContadorMensajes()
	}
	
	
	method gananciaNeta()
	{
		const mensajesCortos = mensajesEnviados.filter({ mensaje => mensaje.size() < 30 })
		const mensajesLargos = mensajesEnviados.filter({ mensaje => mensaje.size() >= 30 })
		return 500 * mensajesCortos.size() + 900 * mensajesLargos.size() - self.totalPagado()
	}
	
	method chasquiQuilla()
	{
		const rankingMensajeros = mensajerosReceptores.sortedBy{ mensajeroA, mensajeroB => mensajeroA.mensajesEnviados() < mensajeroB.mensajesEnviados() }
		const empatados = rankingMensajeros.filter({ mensajero => mensajero.mensajesEnviados() == rankingMensajeros.get(0).mensajesEnviados() })
		return empatados.get(numeroAleatorio.generarEntre(0, empatados.size() - 1))
	}
	
}

