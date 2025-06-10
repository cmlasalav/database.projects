--Base de datos para los metodos de pago

--Tarjeta
CREATE TABLE Tarjeta (
  Id_Registro NVARCHAR(5) NOT NULL,
  Numero_Tarjeta NVARCHAR(max) NOT NULL,
  Mes_Exp NVARCHAR(max) NOT NULL,
  Year_Exp NVARCHAR(max) NOT NULL,
  CVV INT  NOT NULL,
  Total float(4) NOT NULL,
  Estado_Reservacion NVARCHAR(max) NOT NULL,
  Tipo_Tarjeta NVARCHAR(max) NOT NULL,
  CONSTRAINT TarjetaK PRIMARY KEY (Id_Registro),
);

--Cuenta_Banco
CREATE TABLE Cuenta_Banco (
  Id_RegistroCuenta NVARCHAR(5) NOT NULL,
  Num_Cuenta NVARCHAR(max) NOT NULL,
  Codigo NVARCHAR(max) NOT NULL,
  Password_Cuenta NVARCHAR(max) NOT NULL,
  CONSTRAINT Cuenta_BancoPK PRIMARY KEY (Id_RegistroCuenta)
);
