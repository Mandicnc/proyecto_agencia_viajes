from conexion import cursor

class Destino:
    def __init__(self, nombre, descripcion, actividades_disponibles, costo):
        self.__nombre = nombre 
        self.__descripcion = descripcion 
        self.__actividades_disponibles = actividades_disponibles
        self.__costo = costo
        
    def AgregarDestino(self):
        try:
            insert_qry = "INSERT INTO Destino(nombre, descripcion, actividades_disponibles, costo) values (?, ?, ?, ?)"
            values_qry = self.__nombre, self.__descripcion, self.__actividades_disponibles, self.__costo
            cursor.execute(insert_qry, values_qry)
            cursor.commit()
            print("Se agregó un destino correctamente")
        except Exception as error:
            print(error)
            
    @staticmethod
    def ModificarDestino(nombre, descripcion, actividades_disponibles, costo):
        try:
            update_qry = "UPDATE Destino set nombre = ?, descripcion = ?, actividades_disponibles = ?, costo = ? where id = ?"
            values_qry = nombre, descripcion, actividades_disponibles, costo
            cursor.execute(update_qry, values_qry)
            cursor.commit()
            print(f"""Destino modificado exitosamente
                  nombre: {nombre}
                  descripcion: {descripcion}
                  actividades disponibles{actividades_disponibles}
                  costo: {costo}""")
            
        except Exception as error:
            print(error)
    
    @staticmethod
    def EliminarDestino(id):
        try:
            delete_qry = "DELETE FROM Destino where id = ?"
            cursor.execute(delete_qry, id)
            cursor.commit()
            print("Destino eliminado exitosamente")
        except Exception as error:
            print(error)
    
    @staticmethod        
    def MostrarDestinos():
        try:
            select_qry = "SELECT * FROM Destino"
            cursor.execute(select_qry)
            data = cursor.fetchall()
            for i in data:
                print(f"""
                      id: {i[0]} || nombre: {i[1]}
                      descripcion: {i[2]}
                      actividades disponibles: {i[3]}
                      costo: {i[4]}
                      """)
        except Exception as error:
            print(error)
            
class PaqueteTuristico:
    def __init__(self, destino, fecha_inicio, fecha_fin, precio, disponibilidad):
        self.__destino = destino 
        self.__fecha_inicio = fecha_inicio 
        self.__fecha_fin = fecha_fin 
        self.__precio = precio
        self.__disponibilidad = disponibilidad
        
    def AgregarPaquete(self):
        try:
            insert_qry = "INSERT INTO PaqueteTuristico(destino, fecha_inicio, fecha_fin, precio, disponibilidad) values (?, ?, ?, ?, ?)"
            values_qry = self.__destino, self.__fecha_inicio, self.__fecha_fin, self.__precio, self.__disponibilidad
            cursor.execute(insert_qry, values_qry)
            cursor.commit()
            print("Paquete turistico agregado exitosamente")
        except Exception as error:
            print(error)
            
    @staticmethod
    def EliminarPaquete(id):
        try:
            delete_qry = "DELETE FROM PaqueteTuristico where id = ?"
            cursor.execute(delete_qry, id)
            cursor.commit()
            print("Paquete turistico eliminado exitosamente")
        except Exception as error:
            print(error)
    
    @staticmethod
    def VerDisponibilidad():
        try:
            select_qry = "SELECT * from disponibilidad_paquete"
        except Exception as error:
            print(error)
    
    def CalcularPrecioTotal(self):
        pass
    
class Reserva:
    def __init__(self, cliente, paquete_turistico, fecha_reserva):
        self.__cliente = cliente 
        self.__paquete_turistico = paquete_turistico 
        self.__fecha_reserva = fecha_reserva
    
    def VerReserva(self):
        try:
            pass
        except Exception as error:
            print(error)
            
    def EditarReserva(self):
        try:
            pass
        except Exception as error:
            print(error)
    
    def CancelarReserva(self):
        try:
            pass
        except Exception as error:
            print(error)


#Metodos:
#   DESTINO
#   nuevo_destino = Destino(nombre, descripcion, actividades_disponibles, costo)
#   nuevo_destino.AgregarDestino()
#
#   Destino.MostrarDestinos() - estático
#   Destino.EliminarDestino(id) - estático  
#   Destino.ModificarDestino(nombre, descripcion, actividades_disponibles, costo)
#
#   PAQUETE TURISTICO
#   nuevo_paquete = PaqueteTuristico(destino, fecha_inicio, fecha_fin, precio, diponibilidad)
#   nuevo_paquete.AgregarPaquete()
#   
#   PaqueteTuristico.EliminarPaquete()
#   PaqueteTuristico.VerDisponibilidad()
#   PaqueteTuristico.CalcularPrecioTotal()
#   
#   
#   
