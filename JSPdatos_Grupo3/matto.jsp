<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.sql.*" %>
 
<%
	/* Paso 1) Obtener los datos del formulario */
	String ls_isbn = request.getParameter("isbn");
	String ls_titulo = request.getParameter("titulo");
	String ls_autor = request.getParameter("autor");
	String ls_editorial = request.getParameter("editorial");
	String ls_anioPublic = request.getParameter("anioPublic");
	String ls_action = request.getParameter("Action");

	/* Paso 2) Inicializar variables */
	String ls_result = "Base de datos actualizada";
	String ls_query = "";
	ServletContext context = request.getServletContext();
	String path = context.getRealPath("/data");
	String filePath= path+"\\datos.mdb";
	String ls_dburl = "jdbc:odbc:Driver={MicroSoft Access Driver (*.mdb)};DBQ="+filePath;
	String ls_usuario = "";
	String ls_password = "";
	String ls_dbdriver = "sun.jdbc.odbc.JdbcOdbcDriver";
 
	/* Paso 3) Crear query&nbsp; */
	/* Paso 3.1 CREAR */
	if (ls_action.equals("Crear"))
	{
		ls_query = "insert into libros (isbn, titulo, autor, id_editorial, anioPublic)";
		ls_query += " values (";
		ls_query += "'" + ls_isbn + "',";
		ls_query += "'" + ls_titulo + "',";
		ls_query += "'" + ls_autor + "',";
		ls_query += "'" + ls_editorial + "',";
		ls_query += "'" + ls_anioPublic + "')";
	}
 
 	/* Paso 3.2 ELIMINAR */
	if (ls_action.equals("Eliminar")) 
	{
		ls_query = " delete from libros where isbn = ";
		ls_query += "'" + ls_isbn + "'";
	}
 
 	/* Paso 3.3 ACTUALIZAR */
	if (ls_action.equals("Actualizar")) 
	{
		ls_query = " update libros";
		ls_query += " set titulo= " + "'" + ls_titulo + "'";
		ls_query += ", autor = " + "'" + ls_autor + "'";
		ls_query += ", id_editorial = " + "'" + ls_editorial + "'";
		ls_query += ", anioPublic = " + "'" + ls_anioPublic+ "'";
		ls_query += " where isbn = " + "'" + ls_isbn + "'";
	}
 
	/* Paso4) Conexión a la base de datos */
	Connection l_dbconn = null;
	try 
	{
		Class.forName(ls_dbdriver);
		l_dbconn = DriverManager.getConnection(ls_dburl,ls_usuario,ls_password);
 
		/*Creación de SQL Statement */
		Statement l_statement = l_dbconn.createStatement();
		/* Ejecución de SQL Statement */
		l_statement.execute(ls_query);
	} catch (ClassNotFoundException e) {
		ls_result = "<br>"+"<span style="+"color:#FF0000;"+">"+" Error creando el driver!"+"</span>";
		ls_result += " <br/>" + "<span style="+"color:#FF0000;"+">"+e.toString()+"</span>";
	} catch (SQLException e) {
		ls_result = "<span style="+"color:#FF0000;"+">"+" Error procesando el SQL!"+"</span>";
		ls_result += " <br/>" + "<span style="+"color:#FF0000;"+">"+e.toString()+"</span>";
	} finally {
	
		/* Cerramos */
		try {
			if (l_dbconn != null) 
			{
				l_dbconn.close();
			}
		} catch (SQLException e) {
			ls_result = "<span style="+"color:#FF0000;"+">"+"Error al cerrar la conexión..."+"</span>";
			ls_result += " <br/>" + "<span style="+"color:#FF0000;"+">"+e.toString()+"</span>";
		}
	}
%>

<!-- Lo que muestra la pagina matto.jsp -->
<html>
<head>
	<link href="imagenes/icono.png" rel="icon" type="image/png" />
	<title>Reporte de BD</title>
</head>
<body bgcolor="#BBC9FF">
	<h1 style="text-align: center;"><span style="font-family:georgia,serif;">
		<span style="font-size:48px;">
			<span style="color:#FF0000;">
				<strong>- Resultado de petici&oacute;n -</strong>
			</span>
		</span>
	</h1>

	<p>&nbsp;</p>

	<h1>
		<span style="font-family:georgia,serif;">
			<span style="color:#000080;">
				La siguiente instrucci&oacute;n ejecutada fue:
			</span>
		</span>
	</h1>

	<h1>
		<span style="font-family:courier new,courier,monospace;">
			<span style="color:#0000CD;">
				<%=ls_query%>
			</span>
		</span>
	</h1>
	
	<p>&nbsp;</p>

	<h1>
		<span style="font-family:georgia,serif;">
			<span style="color:#000080;">
				El resultado fue:
			</span>
		</span>
		&nbsp;
		<span style="font-family:courier new,courier,monospace;">
			<span style="color:#008000;">
				<%=ls_result%>
			</span>
		</span>
	</h1>

	<p>&nbsp;</p>

	<h3><a href="libros.jsp">Volver a Pagina de inicio</a></h3>
</body>
</html>
