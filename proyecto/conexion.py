import pyodbc as odbc 

class Database: 
    def __init__(self, driver, server, database):
        self.__driver = driver 
        self.__server = server 
        self.__database = database
        self.conexion = None
    
    def Conectar(self):
        try:
            print("conectando...")
            
            connection_qry = f"""
                DRIVER={self.__driver};
                SERVER={self.__server};
                DATABASE={self.__database};
                Trust_Connection=yes;
            """
            self.conexion = odbc.connect(connection_qry)
            print("Conexion exitosa")
            return self.conexion
        
        except Exception as error:
            print(error)

db = Database('SQL Server', 'PIPITO', 'agencia_db')
conexion = db.Conectar()
cursor = conexion.cursor()